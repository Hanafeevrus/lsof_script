# lsof_script     
#### реализацию lsof штатными средствами    
Приведен скрипт работающий по аналогии `lsof -p 1`    
где -p это PID, 1 - числовое знаечение PID.   
[lsof](https://ru.wikipedia.org/wiki/Lsof) - утилита, служащая для вывода информации о том, какие файлы используются теми или иными процессами    
Все процессы выполняемые в системе записывают информацию в файлы которые можно прочитать штатными средствами.   
#### Описание скрипта:   

`pid=1` -указан родительский процесс, можно подставить искомый либо воспользоваться переменной `pid=$(pgrep remmina)`    

`files=$(sudo ls -l /proc/$pid/map_files/ | awk '{print $11}' | uniq & sudo ls -l /proc/$pid/fd | sed 1d | awk '{print $11}')`    
выше задается переменная `files` где проверяем ls -l используемые файлы процесса в директории `map_files/`   

далее `awk '{print $11}'` выводим 11-й столбец, `ls -l /proc/$pid/fd` - просматриваем дескрипторы и выводим 11-й столбец    
`  printf "%5s\t%s\n" "PID" "FILES"`    
printf синтаксис форматирования и заголовки столбцов   

#### Скрипт
```
#!/bin/sh
pid=1
files=$(sudo ls -l /proc/$pid/map_files/ | awk '{print $11}' | uniq & sudo ls -l /proc/$pid/fd | sed 1d | awk '{print $11}')
  printf "%5s\t%s\n" "PID" "FILES"
for files in ${files[@]}; do
printf "%5s\t%s\n" "$pid"  "$files"
  done
exit 0
```
