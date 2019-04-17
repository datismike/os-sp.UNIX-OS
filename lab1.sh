# .---------------------------------------------------------------------.
# | ЛАБОРАТОНАЯ РАБОТА №1					        |
# | ВАРИАНТ 4							        |
# .---------------------------------------------------------------------.
# | Написать скрипт поиска одинаковых по содержимому файлов в двух      |
# | каталогах, например, dir1 и dir2. Пользователь задает имена dir1    |
# | и dir2 в качестве первого и второго аргумента командной строки.     |
# | В результате работы скрипта, файлы, имеющиеся в dir1, сравниваются  |
# | с файлами, имеющимися в dir2, по их содержимому. На экран выводятся |
# | число просмотренных файлов и результаты их сравнения.	        |
# .---------------------------------------------------------------------.

#!/bin/bash

script=$0
dir1=$(readlink -f $1)
dir2=$(readlink -f $2)
err_file=err.log

>$err_file
let file1_count=0
for file1 in `find $dir1 -type f 2>>$err_file`
do
	let file2_count=0
	for file2 in `find $dir2 -type f 2>>$err_file`
	do
		if cmp -s $file1 $file2
		then
			echo "$file1 = $file2"
		else
			echo "$file1 ! $file2"
		fi
		let file2_count=file2_count+1
	done
	let file1_count=file1_count+1
done
let file_count=file1_count+file2_count

IFS=$'\n'
for line in `cat $err_file`
do
	echo "$(basename $script): $line">&2
done
echo "$file_count"
