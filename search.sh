function Welcome()
{
    echo =========== Search.sh ===========
    echo please give me the directory name:
    read directory
}
function testEx() ##test whether the file exists or not
{
    test -d $directory
    res=$?
}
function GetNum()
{
    obj1=$(find  $directory -type f -perm $UserPerms | grep -c skou1)
    obj2=$(find $directory -type f -mtime $UserTime | grep -c skou1)
    ##obj3=$()
   ##obj4=$()
    ##obj5=$()
    let "numFiles= $obj1+$obj2"
}



if [ $# -eq 2 ];then
    declare ans=0
    UserPerms=$1
    UserTime=$2
    until [ $ans = X ] ||[ $ans = x ];do
        Welcome
        testEx
        echo
        if [ $res -eq 0 ];then
            GetNum
            echo Number of files that are about to be printed: $numFiles
            echo
            echo Files of $directory that have $1 permissions:
            find  $directory -type f -perm $1 
            echo
            echo Files of $directory that have been modified the last $2 days: 
            find $directory -type f -mtime $2 
            echo
            echo Subdirectories of $directory that have been accessed the last $2 days: 
            find $directory -type d -atime -$2
            echo
            
        else 
            echo Directory not found!
        fi
        
        echo Press X to exit anything else to continue:
        read ans
        
    done
    
    
else 
    echo Not enough parametres!
fi

