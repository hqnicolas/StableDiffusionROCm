# 💬 [Stable Diffusion](https://github.com/AUTOMATIC1111/stable-diffusion-webui) Radeon ROCm 📷
AUTOMATIC1111 implemented using Gradio library.
- Radeon RX-7000
 Select [V1.9.3](https://github.com/hqnicolas/StableDiffusionROCm/tree/v1.9.3-RX7XT) or [1.7.0](https://github.com/hqnicolas/StableDiffusionROCm/tree/v1.7.0-RX7XT)
- Radeon RX-6000
Select [V1.9.3](https://github.com/hqnicolas/StableDiffusionROCm/tree/v1.9.3-RX6XT) or [1.7.0](https://github.com/hqnicolas/StableDiffusionROCm/tree/v1.7.0-RX6XT) 
- and be free to use on Windows Docker.
- [Detailed feature showcase with images](https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Features)
- Make sure that your Debian Linux system was fresh (Also Ubuntu)
- Prepare AMD to install and restart ROCm Driver 
```
sudo usermod -a -G render,video $LOGNAME
wget https://raw.githubusercontent.com/hqnicolas/StableDiffusionROCm/v1.9.3-RX6XT/AMD-ROCm-Drivers/prepare.sh
sudo chmod 777 prepare.sh
sudo ./prepare.sh
```
- For RDNA 2 cards RX6000:
```
export HSA_OVERRIDE_GFX_VERSION=10.3.0
```
- install Docker
```
wget https://raw.githubusercontent.com/hqnicolas/StableDiffusionROCm/v1.9.3-RX6XT/docker.sh
sudo chmod 777 docker.sh
sudo ./docker.sh
```
- install Docker Compose
```
sudo apt-get update
sudo apt-get install docker-compose-plugin -y
sudo apt-get install docker-compose -y
```
- Install Stable Diffusion ROCm
```
git clone --branch v1.9.3-RX6XT https://github.com/hqnicolas/StableDiffusionROCm.git
cd StableDiffusionROCm
sudo docker-compose build stablediff-rocm
sudo docker compose up -d stablediff-rocm
```
- CTRL+C to stop UP Compose
- Copy [Models](https://huggingface.co/runwayml/stable-diffusion-v1-5/blob/main/v1-5-pruned.ckpt) to StableDiffusionROCm/stablediff-models
```
cp v1-5-pruned.ckpt StableDiffusionROCm/stablediff-models
```
- Start Stable Diffusion ROCm
```
sudo docker start -a stablediff-rocm-runner
```
- Stop Stable Diffusion ROCm
```
sudo docker stop stablediff-rocm-runner
```
To see a prompt from your GPU usage.
```
watch /opt/rocm-6.0.2/bin/rocm-smi
sudo docker ps
sudo docker exec -it stablediff-rocm-runner /bin/bash -c "watch rocm-smi"
```
To check python version.
```
sudo docker exec -it stablediff-rocm-runner /bin/bash -c "python -V"
```
