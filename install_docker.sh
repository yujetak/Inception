sudo apt-get update
# 설치에 필요한 소프트웨어 설치
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
# 서명키로 사용할 PGP(수준높은 암호 시스템)키 추가
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# 도커 레포지토리 추가
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# 레포 업데이트!
sudo apt-get update -y
# 도커 설치
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
# 관리자 외의 사용하도 도커를 사용할 수 있도록 설정
sudo groupadd docker
sudo usermod -aG docker yotak
# 로컬에서 개발을 진행할 때 로컬에서만 사용할 도메인과 IP주소 연결
echo '127.0.0.1 yotak.42.fr' | sudo tee -a /etc/hosts

sudo reboot
