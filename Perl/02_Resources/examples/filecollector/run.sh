#filecollector.pl -o 604 -task 2112 -s '2004-03-30 08:00:00' -e '2004-03-30 09:00:00' -f './config/top_cfg/sie_pms_v8_iolan_filecol.xml' -ne_list ZJMSC
#filecollector.pl -o 603 -task 2112 -s '2004-03-30 08:00:00' -e '2004-03-30 09:00:00' -f './config/top_cfg/sie_pms_v8_iolan_filecol.xml'

/opt/G-BOCO.DAL/NPM/common/mbin/filecollector/filecollector.pl -o '601' -f '/opt/G-BOCO.DAL/NPM/common/mbin/filecollector/config/top_cfg/sie_pms_v8_iolan_filecol.xml' -ne_list 'UNLYG' -s '2004-04-01 10:00:00' -e '2004-04-01 10:15:00' -task '3085' -rmtmp
