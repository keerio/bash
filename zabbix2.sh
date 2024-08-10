#!/bin/bash

# Create the /opt/conf_zabbix2.sh script
# Run with
# Download the script from GitHub and execute it
# curl -sL https://raw.githubusercontent.com/keerio/bash/main/zabbix2.sh | bash
cat << 'EOF' | sudo tee /opt/conf_zabbix2.sh > /dev/null
#!/bin/bash

# Update package list
sudo apt update

# Install Zabbix agent2
sudo apt install -y zabbix-agent2

# Prompt the user for the server IP address
read -p "Enter the IP address of the Zabbix server: " SERVER_IP

# Edit Zabbix configuration
ZABBIX_CONFIG="/etc/zabbix/zabbix_agent2.conf"

# Backup the original configuration file
sudo cp $ZABBIX_CONFIG ${ZABBIX_CONFIG}.bak

# Update the Server IP in the configuration file
sudo sed -i "s/^Server=.*/Server=$SERVER_IP/" $ZABBIX_CONFIG
sudo sed -i "s/^ServerActive=.*/ServerActive=$SERVER_IP/" $ZABBIX_CONFIG

# Restart Zabbix agent2 to apply changes
sudo systemctl restart zabbix-agent2

echo "Zabbix agent2 has been installed and configured with server IP: $SERVER_IP"
EOF

# Make the /opt/conf_zabbix2.sh script executable
sudo chmod +x /opt/conf_zabbix2.sh

echo "The script /opt/conf_zabbix2.sh has been created and is ready to be run."
