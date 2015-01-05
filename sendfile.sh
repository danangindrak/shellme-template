#!/bin/sh

#by :Danang
#version :1.9

dir=/lokasi folder
target=/DATA2/oklaftp/wget/files.speedtest.ookla.com/tmp

datetarget=`date -d '-2 day' "+%Y-%m-%d"`
#echo "$datetarget"

#Pencarian file
#find "$dir" -type f -ctime -1 -exec sh -c  'unzip -d `dirname {}`/../tmp {}' ';'
find "$dir" \( -name tmp -prune -o -name \*_"$datetarget".zip \) -exec sh -c  'unzip -d `dirname {}`/../tmp {}' ';'

#hapus dulu
cd $target
rm -f android.csv
rm -f iphone.csv
rm -f wp.csv

#rename nama file
mv -f `ls|grep android` android.csv
mv -f `ls|grep iphone` iphone.csv
mv -f `ls|grep wp` wp.csv
{
echo "File :"
ls *.csv
echo "pada tanggal :$datetarget"


#ssh -fNL 2200:0000.0000.0000.0000:22 -p 4522 oklauser@xxx.xxx.xxx
ssh -M -S my-connection -fNL 2200:0000.0000.0000:22 -p 4522 oklauser@xxx.xxx.xxx

sftp -oPort=2200 oklauser@localhost <<EOF
rm android.csv
rm iphone.csv
rm wp.csv

put $target/android.csv 
put $target/iphone.csv 
put $target/wp.csv 
EOF
echo "Harusnya sudah di upload !"
} > LogSendFile.log

#exit connection tunnel
ssh -S my-connection -O exit oklauser@xxx.xxx.xxx

