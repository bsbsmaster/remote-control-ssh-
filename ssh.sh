#!/bin/bash
#create folder to save every think on it
function folder() 
{
#make folder 
mkdir -p $(pwd)/script 
#echo will tell when the file created 
echo "(        the file script maked : $(date)   )" &>> $(pwd)/script/data.log
#echo will tell the time and saveit in data.log
echo "(        code start at: $(date)   )" &>> $(pwd)/script/data.log
}
folder
#create a log  path 
function start()
{
#u is a variables = date
u=$( date )
#echo will tell the time and saveit in data.log
}
start 
# start to cheacking apps (logfile)
function start()
{
#echo will tell the time and saveit in data.log
echo "(        checkpackages satrt at: $u  )" &>> $(pwd)/script/data.log
}
start
#this function will scan packs and installe if not
function checkpackages()
{
#list of app (tor ,nmap ,whois,,sshpass,)
packs=("tor" "nmap" "whois" "sshpass" )
#pack will be  pick app app in packs 
for pack in "${packs[@]}"
 do
 if 
 #dpkg will scan pack
 dpkg -s "$pack" &>> $(pwd)/script/dpgk.txt
 then
 #echo will say if they installed  
echo "        $pack is installed and the data is saved in $(pwd)/script/dpgk.txt"
 else

#satrt a time installing
#  update and upgrade and insatll packs if they are not installed 
echo "(      update start  at: $u  )" &>> $(pwd)/script/data.log
echo "kali" | sudo -S  apt-get update -y  &>> $(pwd)/script/dpgk.txt
echo "(      update end  at: $u  )" &>> $(pwd)/script/data.log
echo "(      upgrade start  at: $u  )" &>> $(pwd)/script/data.log
sudo apt-get dist-upgrade -y &>> $(pwd)/script/dpgk.txt
echo "(      upgarde end  at: $u  )" &>> $(pwd)/script/data.log
echo "(        install start at: $u  )" &>> $(pwd)/script/data.log
sudo apt-get install -y "${packs[@]}" &>> $(pwd)/script/dpgk.txt
#end it a time installing
echo "(        install end at: $u   )" &>> $(pwd)/script/data.log
#echo will say the app done insttalling
echo "        @@@@@@Installation completed / every think saved in $(pwd)/script/dpgk.txt@@@@@@@@@@ " 
fi
done
}
checkpackages
# Check if the network connection is anonymous 
function network()
{
#echo start recoreder time
echo "(network   scure start at: $u   )" &>> $(pwd)/script/data.log
i=$(curl -s ifconfig.me  ) 
c=$(curl -s ipinfo.io/country)
  if  [ "$c" == "IL" ]
then
# if the network connection is  not anonymous exit
echo "      @network connection is not anonymous" 
exit
#display the spoofed country name 
else
#echo will tell the country
echo "      @spoofed country: $c "
#echo end it recoreder time
echo "(network $i  scure ended at: $u   )" &>> $(pwd)/script/data.log
fi
}
network
#this function will sremotedisktop another pc
function controlandscans()
{
#Allow the user to specify the user/pass/IP  and save
read -p "      specify a ip to scan: " domin
read -p "      specify a name: " user
read -p "      specify a  password : " pass
#c/a/p/w is a variables
x=$domin
A=$user
p=$pass
w=$(curl -s ipinfo.io/country)
#start time  remote scan
echo "(        remotcontrol status start at: $u   )" &>> $(pwd)/script/data.log
#connecnt to pc by sshpass  /# Display the details of the remote server (ip.country.uptime)
echo $(sshpass -p $p ssh -o StrictHostKeyChecking=no $A@$x "
echo ' @#ip:' $x && 
echo ' @@@@@@@@@@@@@@@@@@@@@@@@@' &&
echo ' @#country:' $w   &&
echo '@@@@@@@@@@@@@@@@@@@@@@@@@' &&
echo ' @#uptime:' $(uptime)  ")
#connecnt another time inthe same pc by sshpass  /# save the details namp and whois in the local pc
echo $(sshpass -p $p ssh -o StrictHostKeyChecking=no $A@$x "
echo "$p" | sudo -S -p ' '  whois $x &&
echo '#################################################################'
echo '#################################################################'
echo '#################################################################'
echo '#################################################################'
echo '#################################################################'
echo '#################################################################'
echo "$p" | sudo -S -p ' ' nmap -Pn --open $x  
") >> $(pwd)/script/scans.log
}
controlandscans
#end time remote sccan
echo "(        remotcontrol  status ended at:  $u  )" &>> $(pwd)/script/data.log
#end all the code 
echo "(        code ended at: $u  )" &>> $(pwd)/script/data.log

