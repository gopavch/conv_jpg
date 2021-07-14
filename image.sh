#!/bin/bash

#Нужный размер
rr=360
#Что добавить к имени файла
add="_thumbnail"
#Минимальный допустимый размер
rd=10


if [[ -f "${1}" ]] && [[ -n "${1}" ]]
	then
	while read fil
	do
	if ! [[ -f "$fil" ]]
	then
		echo "Файл \"${fil}\" отсутствует - пропускаем"
		continue
	fi

		x=$(file -F. "${fil}" |grep -o "[0-9]\{1,\}x[0-9]\{1,\}"|tail -n1|cut -d'x' -f1)
		y=$(file -F. "${fil}" |grep -o "[0-9]\{1,\}x[0-9]\{1,\}"|tail -n1|cut -d'x' -f2)
		if [ "${x}" -lt "${y}" ]
		then
			#ts=$((${x}-${rr}))
			if [ "${x}" -lt "${rr}" ]
			then
				echo "Изображение \"${fil}\" меньше заданного размера - пропускаем"
			else
				convert -resize ${rr}X${y} ${fil} ${fil%.*}${add}.jpg
			fi
		elif [ "${y}" -lt "${x}" ]
		then
			#ts=$((${x}-${rr}))
			if [ "${y}" -lt "${rr}" ]
			then
				echo "Изображение \"${fil}\" меньше заданного размера - пропускаем"
			else
				convert -resize ${x}X${rr} ${fil} ${fil%.*}${add}.jpg
			fi
		elif [ "${y}" -eq "${x}" ]
		then
			echo "Изображение \"${fil}\" квадратное - пропускаем"
		fi
	done < <(cat ${1} |grep -v ${add} | grep "\.[jJ][pP][gG]$")
else
	while read fil
	do
		x=$(file -F. "${fil}" |grep -o "[0-9]\{1,\}x[0-9]\{1,\}"|tail -n1|cut -d'x' -f1)
		y=$(file -F. "${fil}" |grep -o "[0-9]\{1,\}x[0-9]\{1,\}"|tail -n1|cut -d'x' -f2)
		if [ "${x}" -lt "${y}" ]
		then
			#ts=$((${x}-${rr}))
			if [ "${x}" -lt "${rr}" ]
			then
				echo "Изображение \"${fil}\" меньше заданного размера - пропускаем"
			else
				convert -resize ${rr}X${y} ${fil} ${fil%.*}${add}.jpg
			fi
		elif [ "${y}" -lt "${x}" ]
		then
			#ts=$((${x}-${rr}))
			if [ "${y}" -lt "${rr}" ]
			then
				echo "Изображение \"${fil}\" меньше заданного размера - пропускаем"
			else
				convert -resize ${x}X${rr} ${fil} ${fil%.*}${add}.jpg
			fi
		elif [ "${y}" -eq "${x}" ]
		then
			echo "Изображение \"${fil}\" квадратное - пропускаем"
		fi
	done < <(ls -1 ./*.[jJ][pP][gG]|grep -v ${add})
fi