// bash script ironfish_auto.sh
#!/bin/sh
sleep 1
echo y | ironfish wallet:mint -a 2 -f $IRONFISH_NODENAME -m $IRONFISH_WALLET -n $IRONFISH_WALLET -o 0.00000001 | tee -a /root/logfile.log
echo "Wait 5 mins"
sleep 5m 
echo y | ironfish wallet:burn -a 1 -f $IRONFISH_NODENAME -i $ASSET_ID -o 0.00000001 | tee -a /root/logfile.log
echo "Wait 5 mins" 
sleep 5m   
echo y | ironfish wallet:send -a 1 -f $IRONFISH_NODENAME -i $ASSET_ID -t dfc2679369551e64e3950e06a88e68466e813c63b100283520045925adbe59ca -o 0.00000001 | tee -a /root/logfile.log
