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




if [ $# -eq 2 ];then
    declare ans=0
    
    until [ $ans = X ] ||[ $ans = x ];do
        Welcome
        testEx
        echo
        if [ $res -eq 0 ];then
            
            echo Files of $directory that have $1 permissions:
            find  $directory -type f -perm $1 
            echo
            echo Files of $directory that have been modified the last $2 days: 
            find $directory -type f -mtime $2 
            echo
        else 
            echo Directory not found!
        fi
        
        echo Press X to exit anything else to continue:
        read ans
        
    done
fi

