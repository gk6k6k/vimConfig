#mkfifo pipe1
#:autocmd BufWritePost * silent! !echo "p" > ~/pipe &
while true
do
    while read i
    do
        #echo $i
        echo ""
    done < .pipe;
    $1
done

