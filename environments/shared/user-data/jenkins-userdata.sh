# #!/bin/bash
# set -e

# # Wait for NAT Gateway to be ready
# echo "Waiting for internet connectivity through NAT Gateway..."
# for i in {1..60}; do
#   if ping -c 1 8.8.8.8 2>/dev/null; then
#     echo "Internet connectivity confirmed"
#     break
#   fi
#   echo "Attempt $i/60: Waiting for NAT Gateway..."
#   sleep 10
# done

# # Update system packages
# echo "Updating system packages..."
# apt-get update
# apt-get upgrade -y

# # Install Java (required for Jenkins)
# echo "Installing Java..."
# apt-get install -y openjdk-11-jdk

# # Add Jenkins repository
# echo "Adding Jenkins repository..."
# wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
# sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# # Update package manager with Jenkins repository
# apt-get update

# # Install Jenkins
# echo "Installing Jenkins..."
# apt-get install -y jenkins

# # Install additional tools
# echo "Installing additional tools..."
# apt-get install -y git curl wget

# # Start and enable Jenkins
# echo "Starting Jenkins service..."
# systemctl start jenkins
# systemctl enable jenkins

# # Log completion
# echo "Jenkins installation completed successfully"
