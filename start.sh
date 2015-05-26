#!/bin/sh

# ingress-ice start script by Nikitakun (http://github.com/nibogd/ingress-ice)
#               SETTINGS          

#L=''            #google login or email
#P=''            #google password
#AREA='https://www.ingress.com/intel?ll=35.682398,139.693909&z=11' #link to your location
#MINLEVEL='1'    #minimal portal level, set to 1 to display all available portals
#MAXLEVEL='8'    #highest portal level, set to 8 to display all
#V='120'          #Delay between capturing screenshots in seconds
#WIDTH='900'     #Picture width
#HEIGHT='500'    #Picture height
#FOLDER='./'     #Folder where to save screenshots with \ (or /) in the end. '.' means current folder. 
#NUMBER='0'      #Number of screenshots to take. 0 for infinity.
#LOGLEVEL='3'    #Log level. 0 = silence, 1 = only short welcome, two-factor code and errors, 2 = everything from 1 + every screenshot announced, 3 = beautiful welcome + everything from 2, 4 = all logs including debug messages, short welcome

#DO NOT EDIT ANYTHING BELOW THIS LINE

file="~/.ingress_ice"

user_input() {
	while true; do
		echo "Enter your location link (visit http://github.com/nibogd/ingress-ice for help): "
		read LINK
		if [ -z "$LINK" ]; then
			echo "Cannot be blank."
		else
			break;
		fi
	done
	while true; do
		echo "\nYour Google login: "
		read EMAIL
		[ -z "$EMAIL" ] && echo "Cannot be blank." || break;
	done
	while true; do
		echo "\nYour Google password: (not shown) "
		stty -echo
		read PASSWORD
		stty echo
		[ -z "$PASSWORD" ] && echo "Cannot be blank." || break;
	done
	echo "\nDelay between screenshots: ([ENTER] for default (120)) "
	read DELAY
	echo "\nMinimal portal level: (1) "
	read MIN_LEVEL
	echo "\nMaximum portal level: (8) "
	read MAX_LEVEL
	echo "\nScreenshots' width in pixels: (900) "
	read WIDTH
	echo "\nScreenshots' height: (500) "
	read HEIGHT
	echo "\nNumber of screenshots to take, '0' for infinity: (0) "
	read NUMBER
	
	[ -z "$DELAY" ] && $DELAY='120'
	[ -z "$MIN_LEVEL" ] && $MIN_LEVEL='1'
	[ -z "$MAX_LEVEL" ] && $MAX_LEVEL='8'
	[ -z "$WIDTH" ] && $WIDTH='900'
	[ -z "$HEIGHT" ] && $HEIGHT='500'
	[ -z "$NUMBER" ] && $NUMBER='0'
	if [ $NUMBER = "0" ]
	then
		$FAKE_NUMBER='infinity'; else 
		$FAKE_NUMBER=$NUMBER
	fi
	echo "\n\nYour google login: $EMAIL"
	echo "Your google password: (not shown)"
	echo "Delay between screenshots: $DELAY"
	echo "Minimal portal level: $MIN_LEVEL"
	echo "Maximum portal level: $MAX_LEVEL"
	echo "Dimensions: $WIDTH x $HEIGHT"
	echo "Take $FAKE_NUMBER screenshots"
	echo "Are options entered correct? (Y/n)"
}

if [ -f "$file" ]
then
	echo "Existing config found found. Starting ice..."
	#start; exit;;
else
	while true; do
	    read -p "Config file not found. Create one? (y/n) " yn
	    case $yn in
	        [Yy]* ) user_input; break;;
	        [Nn]* ) echo "Config file is mandatory. Exiting…"; exit;;
	        * ) echo "Please answer y(es) or n(o).";;
	    esac
	done
fi


ARGS="$L $P $AREA $MINLEVEL $MAXLEVEL $V $WIDTH $HEIGHT $FOLDER $NUMBER $LOGLEVEL"
for arg
do
    if [ "$arg" = --help ]
    then
       echo "Please visit http://github.com/nibogd/ingress-ice for help"
    fi
done

#exec ./phantomjs ice.js $ARGS
