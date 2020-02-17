# lsof_script     
#### реализацию lsof штатными средствами    
Приведен скрипт работающий по аналогии `lsof -p 1`    
где -p это PID, 1 - числовое знаечение PID.   
[lsof](https://ru.wikipedia.org/wiki/Lsof) - утилита, служащая для вывода информации о том, какие файлы используются теми или иными процессами    
Все процессы выполняемые в системе записывают информацию в файлы которые можно прочитать штатными средствами.   
#### Описание скрипта:   

`pid=1` -указан родительский процесс, можно подставить искомый либо воспользоваться переменной    
например: `pid=$(pgrep remmina)`    

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
#### Фрагмент вывода    
```
   PID	FILES
    1	/usr/lib/systemd/systemd
    1	/usr/lib64/libm-2.28.so
    1	/usr/lib64/libudev.so.1.6.11
    1	/usr/lib64/libsepol.so.1
    1	/usr/lib64/libunistring.so.2.1.0
    1	/usr/lib64/libpcap.so.1.9.0
    1	/usr/lib64/libgpg-error.so.0.24.2
    1	/usr/lib64/libjson-c.so.4.0.0
    1	/usr/lib64/libdevmapper.so.1.02
    1	/usr/lib64/libattr.so.1.1.2448
    1	/usr/lib64/libcrypto.so.1.1.1c
    1	/usr/lib64/libssl.so.1.1.1c
    1	/usr/lib64/libz.so.1.2.11
    1	/usr/lib64/libcap-ng.so.0.0.0
    1	/usr/lib64/libuuid.so.1.3.0
    1	/usr/lib64/libdl-2.28.so
    1	/usr/lib64/libpcre2-8.so.0.7.1
    1	/usr/lib64/libblkid.so.1.1.0
    1	/usr/lib64/liblz4.so.1.8.1
    1	/usr/lib64/liblzma.so.5.2.4
    1	/usr/lib64/libidn2.so.0.3.6
    1	/usr/lib64/libip4tc.so.0.1.0
    1	/usr/lib64/libgcrypt.so.20.2.3
```
