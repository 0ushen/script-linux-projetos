#!/bin/bash
clear

FILE1=$(md5sum projetos/testmd5sum.sh | awk '{print $1}')
FILE2=$(md5sum testmd5sum.sh | awk '{print $1}')

if [ $FILE1 == $FILE2 ] ; then
    echo "Ils sont egaux"
else
    echo "Ils sont pas identiques"
fi

p
