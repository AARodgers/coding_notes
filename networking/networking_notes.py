hostname #tells name of the host
hostname -I #tells the IP address of the host
hostname -s #tells the short name of the host

ifconfig #shows the network interfaces and their configurations
ifconfig -a #shows all network interfaces, including those that are down
ip addr #shows the IP addresses assigned to the network interfacesi
ifconfig eth0 #shows the configuration of the eth0 interface (eth0 being a ethernet adapter)


ping google.com #sends ICMP echo requests to google.com to check connectivity
# results are successful eco replies from the server
ping -c 4 google.com #sends 4 ICMP echo requests to google.com


curl # transfer data to and from a server
curl --help #shows help for curl command
curl google.com #fetches the content of google.com using HTTP
curl -I google.com #fetches the HTTP headers of google.com
wget google.com #downloads the content of google.com


# transfer the http data from a url to a file
curl -o file.txt http://example.com
# download a file from a url
curl www.google.com -o google.txt
# download a file from a url and save it with a specific name
head -n 1 google.txt #shows the first line of the file google.txt


# wget is like curl but with diff protocol and can recursively download files
wget http://example.com/file.txt #downloads file.txt from example.com
wget -r http://example.com/ #recursively downloads all files from example.com


View your network configuration using the hostname and ip commands
Test a network connection using the ping command
Transfer data using the curl and wget commands

#Display your system's hostname and IP address
hostname

# A hostname is a name that is assigned to a computer or device on a network, and it is used to identify and communicate with that device.
#To view the current hostname, run the command below:
hostname

# An IP address (Internet Protocol address) is a numerical label assigned to each device connected to a computer network that uses the Internet Protocol for communication.
# You can use the -i option to view the IP address of the host:
hostname -i

#Display network interface configuration
# Please execute the below commands to install the iproute2 package:
sudo apt update
sudo apt install iproute2

#The ip command is used to configure or display network interface parameters for a network.
#To display the configuration of all network interfaces of your system, enter:
ip a

#To display the configuration of a particular device, such as the ethernet adapter eth0, enter:
ip addr show eth0
#eth0 is usually the primary network interface that connects your server to the network.
#You can see your server's IP address in line 2 after the word inet.

#Test connectivity to a host
ping
# Use the ping command to check if www.google.com is reachable. The command keeps pinging data packets to server at www.google.com and prints the response it gets back.
# (Press Ctrl+c to stop pinging.)
ping www.google.com

#If you want to ping only a limited number of times, use -c option.
ping -c 5 www.google.com

# View or download data from a server
#Transfer data from a server
curl

#You can use curl to access the file at the following URL and display the file's contents on your screen:
curl https://file.txt

# To access the file at the given URL and also save it in your current working directory, use the -O option:
curl -O https://file.txt

# NOTE:You can also use curl to view the HTML code for any web page if you know its URL.

# Download file(s) from a URL
wget
# The wget command is similar to curl, however its primary use is for file downloading.
# One unique feature of wget is that it can recursively download files at a URL.

