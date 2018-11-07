#!/bash/sh
find . -name "*.txt" -print0 | while read -d $'\0' file
do
    echo "$file"
done
