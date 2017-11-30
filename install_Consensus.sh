#!/bin/bash
#是否重建data目录操作
ifnewdata=
case $1 in
  1)
  find . -name "*.sh" | xargs chmod 744
  find . -name "build_detect_platform" | xargs chmod 744
  ./autogen.sh
  ./configure --with-incompatible-bdb
  ;;
  2)
  ifnewdata=;rm -rf /home/test/dataConsensus;mkdir /home/test/dataConsensus
esac


ssh test@192.168.2.137 killall noded $ifnewdata
ssh test@192.168.2.128 killall noded $ifnewdata
ssh test@192.168.2.138 killall -9 noded $ifnewdata
sleep 1
echo ----shutdown node--------
make
if [ $? == 0 ]
then
scp src/bitcoind test@192.168.2.128:~/runConsensus/bin/noded
scp src/bitcoind test@192.168.2.137:~/runConsensus/bin/noded
scp src/bitcoind test@192.168.2.138:~/runConsensus/bin/noded
echo -----transport complete------
fi

ssh test@192.168.2.128 /home/test/bsdr.sh bsdr &
sleep 2
ssh test@192.168.2.138 sh /home/test/bcr1.sh bcr &
sleep 2
ssh test@192.168.2.137 sh /home/test/bcr.sh bcr &
sleep 2
#获取进程号后杀死冗余的后台进程
pid=$(ps -ef |grep "/home/test/bsdr.sh"|awk '{print $2}'|sort -n|head -n 1)
kill $pid
pid=$(ps -ef |grep "/home/test/bcr.sh"|awk '{print $2}'|sort -n|head -n 1)
kill $pid
pid=$(ps -ef |grep "/home/test/bcr1.sh"|awk '{print $2}'|sort -n|head -n 1)
kill $pid

echo ----node restarted---------
echo $?
