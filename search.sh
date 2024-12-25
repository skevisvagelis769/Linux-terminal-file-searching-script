function Welcome()
{
    echo =========== Search.sh ===========
    echo please give me the directory name:
    read directory
}
function CheckZ()
{
    if [ $1 = 0 ];then 
        echo None!
    fi
}
function printRes()
{
    echo Number of files that are about to be printed: $numFiles
    echo
    echo Number of directories that are about to be printed: $numDir
    echo
    echo Files of $directory that have $UserPerms permissions:
    CheckZ $obj1
    find  $directory -type f -perm $UserPerms 
    echo
    echo Files of $directory that have been modified the last $UserTime days: 
    CheckZ $obj2
    find $directory -type f -mtime $UserTime
    echo
    echo Directories of $directory that have been accessed the last $UserTime days: 
    CheckZ $obj3
    find $directory -type d -atime -$UserTime
    echo Files of $directory that all users have reading rights for:
    CheckZ $obj4
    ls -l $directory | grep ^[-r..r..r..] 
    echo Directories of $directory that can create/rename/delete files: 
    CheckZ $obj5
    ls -l $directory | grep '^drwxrwxrwx'
    echo
}
function testEx() ##test whether the file exists or not
{
    test -d $directory
    res=$?
}
function GetNum()
{
    obj1=$(find  $directory -type f -perm $UserPerms | grep -c $directory)
    obj2=$(find $directory -type f -mtime $UserTime | grep -c $directory)
    obj3=$(find $directory -type d -atime -$UserTime | grep -c $directory)
    obj4=$(ls -l $directory | grep ^[-r..r..r..] -c)
    obj5=$(ls -l $directory | grep '^drwxrwxrwx' -c)
    let "numFiles= $obj1+$obj2+$obj4 "
    let "numDir= $obj3+$obj5"
}



if [ $# -eq 2 ];then
    ans=0
    Sum=0
    UserPerms=$1
    UserTime=$2
    until [ $ans = X ] ||[ $ans = x ];do
        Welcome
        testEx
        echo
        if [ $res -eq 0 ];then
            GetNum
            printRes
            
        else 
            echo Directory not found!
        fi
        let "Sum = $numFiles+$numDir+$Sum"
        echo Press X to exit anything else to continue:
        read ans
        
    done
    echo Total number of files printed: $Sum
    
else 
    echo Not enough parametres!
fi

