# Get arg input

$0	command itself
$1	first parameter


# Check if file exist

FILE=/etc/resolv.conf
if [ -f "$FILE" ]; then
    echo "$FILE exists."
fi

# Conditional 

if [ <some test> ]
then
<commands>
else
<other commands>
fi

if [ ! -d "/path/to/dir" ] && echo "Directory /path/to/dir DOES NOT exists."