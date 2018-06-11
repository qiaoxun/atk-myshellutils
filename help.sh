#!/bin/sh

. ./utility.sh

# Start a PPM instance at location of /c/PPMs
startPPM(){
	
	baseDir="/c/PPMs"
	
	firstMsg='which PPM you want to start?'

	forLoopChooseFile $baseDir $firstMsg

	cd "bin"
	. ./kStart.sh
	
	read a
}

# When we first install a PPM instance, we should convert some conf files to upgrate the instance.
convertConfFiles() {
	
	baseDir="/c/PPMs"
	forLoopChooseFile $baseDir

	d2u *.conf

	d2u conf/*.conf

	cd bin

	. ./kUpdateHtml.sh
}

# Sometimes the support give us some zip file that contains some data we need to import to our PPM isntance.
importZipFilesToPPM() {
	echo "Enter Incident ID"
	read incidentId

	zipDir="C:/Users/qiaox/Desktop/Incident&Defect/Incident/$incidentId"

	cd $zipDir

	pwd

	ziplist=`ls | grep zip`

	echo "Enter PPM's Name"
	read PPMName

	cd "C:/PPMs/$PPMName/bin"

	for file in $ziplist
	do
		realZipPath="$zipDir/$file"
		com="sh kMigratorImport.sh -username  admin -action import  -password admin  -filename '$realZipPath' -i18n none -refdata nochange  -flags NNYNYNNNNNNNNNNNNNN"
		echo $com
		`$com`
	done
}

# kill Java process by name
killJavaProcess() {
	processName=$1
	pid=`jps | grep $processName | awk '{print $1}'`
	echo $pid
	kill -9 $pid
}

# start up local opengrok
startUpLocalOpenGrok() {
	cd 'C:/Joey/software/apache-tomcat-8.5.31/bin'
	cmd "/C startup.bat"
}

# Shutdown local opengrok
shutdownLocalOpenGrok() {
	cd 'C:/Joey/software/apache-tomcat-8.5.31/bin'
	cmd "/C shutdown.bat"
}


# Fix ALM Failed To Login - Failed while trying to locate user in LDAP server(minssing LDAP import settings)
fixAlmLogin() {
	echo -e "${On_IYellow}You need to close ie${NC}"
	echo -e "Are you already closed the ie browser ${BRed}Y/N${NC}? (Y)"
	read yesOrNo
	
	if [ "$yesOrNo" = "N" ] || [ "$yesOrNo" = "n" ]; then
		echo "Please close the ie first and try again."
		exit 0
	fi
	
	cd 'C:/Users/qiaox/AppData/Local/HP'
	
	rm -rf ALM-Client
	echo "Removed ALM-Client"
	
	rm -rf ALM-WCF
	echo "Removed ALM-WCF..."
	
	cp -r ALM-Client-backup ALM-Client
	echo "Copyed ALM-Client..."
	
	cp -r ALM-WCF-backup ALM-WCF
	echo "Copyed ALM-WCF..."	
	
	echo "Now, you can try again. Enjoy it!"
	
	read a
}

# start oracle services
startOracle() {
	cmd "/C startOracle.bat"
}

#subN2C
subN2C() {
	cmd "/C subN2C.bat"
}

# begin
echo "What can I help you?"
echo -e "${Red}1 - StartPPM : Start a PPM instance at location of /c/PPMs${NC}"
echo -e "${Green}2 - ConvertConfFiles : When we first install a PPM instance, we should convert some conf files to upgrate the instance.${NC}"
echo -e "${Yellow}3 - ImportZipFilesToPPM ： Sometimes the support give us some zip file that contains some data we need to import to our PPM isntance.${NC}"
echo -e "${Blue}4 - Kill Java process${NC}"
echo -e "${Purple}5 - Start up local OpenGrok${NC}"
echo -e "${Cyan}6 - Shutdown local OpenGrok${NC}"
echo -e "${White}7 - Fix ALM Failed To Login${NC}"
echo -e "${White}8 - Start Oracle Services${NC}"
echo -e "${White}9 - SubN2C${NC}"
echo -e "${BRed}Input the index of service you needed.${NC}"

read serviceNum

if [ "$serviceNum" = "1" ]; then
	startPPM
elif [ "$serviceNum" = "2" ]; then
	convertConfFiles
elif [ "$serviceNum" = "3" ]; then
	importZipFilesToPPM
elif [ "$serviceNum" = "4" ]; then
	killJavaProcess Bootstrap
elif [ "$serviceNum" = "5" ]; then
	startUpLocalOpenGrok
elif [ "$serviceNum" = "6" ]; then
	shutdownLocalOpenGrok
elif [ "$serviceNum" = "7" ]; then
	fixAlmLogin
elif [ "$serviceNum" = "8" ]; then
	startOracle
elif [ "$serviceNum" = "9" ]; then
	subN2C
else
	echo "Sorry, we don't having anything you wanted.";
fi

