#install git
sudo apt-get install git
#install docker
# https://docs.docker.com/engine/install/ubuntu/
sudo apt-get update -y
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
# add docker's official gpg key
sudo mkdir -p /etc/apt/keyrings
# *safe* gpg running in root, warning!
# https://unix.stackexchange.com/questions/452020/gpg-warning-unsafe-ownership-on-homedir-home-user-gnupg
sudo gpgconf --kill dirmngr
sudo chown -R $USER ~/.gnupg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# setup repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#permisson for docker
sudo usermod -aG docker yotak
# sudo chown yotak:yotak ~/.docker -R
# sudo chmod 666 /var/run/docker.sock

sudo apt-get update -y && apt-get upgrade -y

mkdir /home/yotak/data