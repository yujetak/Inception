sudo apt-get update -y

# install docker
# https://docs.docker.com/engine/install/ubuntu/
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# add docker's official gpg key
# *safe* gpg running in root, warning!
# https://unix.stackexchange.com/questions/452020/gpg-warning-unsafe-ownership-on-homedir-home-user-gnupg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /tmp/docker-archive-keyring.gpg
sudo mv /tmp/docker-archive-keyring.gpg /usr/share/keyrings/docker-archive-keyring.gpg
sudo chown root:root /usr/share/keyrings/docker-archive-keyring.gpg

# setup repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null#permisson for docker
sudo apt-get update -y

# install docker engine
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update -y

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo usermod -aG docker yotak
sudo chown yotak:yotak ~/.docker -R
sudo apt-get update -y && sudo apt-get upgrade -y
# sudo chmod 666 /var/run/docker.sock
