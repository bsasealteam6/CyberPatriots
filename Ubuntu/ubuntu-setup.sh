sudo apt-get install open-vm-tools
sudo awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd

read -p "Enter number of users to delete: " userNum
let COUNTER=0
while [  $COUNTER -lt $userNum ]; do
             	read -p "Enter name of user to delete: " user
		sudo deluser $user
             	let COUNTER=COUNTER+1 
	done





read -p "Enter number of users to add: " userNum
let COUNTER=0
while [  $COUNTER -lt $userNum ]; do
		read -p "Enter name of user to add: " user
		read -p "Should this user be an admin? " admin
#		if ["$admin" == "y"];then 
#			sudo useradd $user -g admin
#		fi
		sudo useradd $user
		let COUNTER=COUNTER+1 
	done


sudo awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd
read -p "Enter number of users to make admins: " userNum
let COUNTER=0
while [  $COUNTER -lt $userNum ]; do
             	read -p "Enter name of user to make admin: " user
		sudo usermod -aG sudo $user
             	let COUNTER=COUNTER+1 
	done

read -p "Enter number of users to make regular: " userNum
let COUNTER=0
while [  $COUNTER -lt $userNum ]; do
             	read -p "Enter name of user to regular: " user
		sudo deluser $user sudo
             	let COUNTER=COUNTER+1 
	done




#sudo apt-get update
#sudo apt-get upgrade
#sudo shutdown -r
