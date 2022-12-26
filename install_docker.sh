# Uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc
# Install using the repository
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# Install docker engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker yotak

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# resolve docker-permission-error
sudo chown root:docker /var/run/docker.sock
sudo chmod 666 /var/run/docker.sock

sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
# host register
sudo echo "127.0.0.1 yotak.42.fr" >> /etc/hosts
