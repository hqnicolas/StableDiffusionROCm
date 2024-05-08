#!/bin/bash
sudo apt update -y
sudo apt autoremove -y
for ver in 6.0.1 6.0.2; do
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/rocm/apt/$ver jammy main" | sudo tee --append /etc/apt/sources.list.d/rocm.list
done
echo -e 'Package: *\nPin: release o=repo.radeon.com\nPin-Priority: 600' | sudo tee /etc/apt/preferences.d/rocm-pin-600
sudo apt update -y
# Install ROCm packages:
sudo apt install rocm-hip-sdk -y
# Post-install Actions
# Instruct the system linker where to find the shared objects for ROCm applications:
sudo tee --append /etc/ld.so.conf.d/rocm.conf <<EOF
/opt/rocm/lib
/opt/rocm/lib64
EOF
sudo ldconfig
# Add binary paths to the PATH environment variable:
echo PATH=$PATH:/opt/rocm-6.0.2/bin:/opt/rocm-5.7/opencl/bin
# Other Requirements
# Most systems will likely need to do these additional steps. First add your user to the video and render group:
sudo usermod -a -G video $LOGNAME
sudo usermod -a -G render $LOGNAME
# The following step is only required with certain consumer grade GPUs.
# If you're running a professional card or an RDNA 2 GPU with 16GB of VRAM (i.e. RX 6800 XT, 6900 XT) 
# then the following step is not necessary.
# Lower tiered cards such as the RX 6600 XT and 6700 XT, which is what I'm using, will require the following step. 
# Cards older than RDNA might require additional steps not listed here, in which case this Reddit thread has more info on running older cards. 
# Reddit: HOW-TO: Stable Diffusion on an AMD GPU.
# Edit ~/.profile with your editor of choice.
# sudo nano ~/.profile
# Paste the following line at the bottom of the file, then press ctrl-x and save the file before exiting.
# to 7800XT
# export HSA_OVERRIDE_GFX_VERSION=11.0.0
# to 6800XT
# export HSA_OVERRIDE_GFX_VERSION=10.3.0
echo -e "export HSA_OVERRIDE_GFX_VERSION=11.0.0" > ~/.profile
# Now make sure to restart your computer before continuing.
# Then you can check if ROCm was installed successfully by running rocminfo. 
# If an error is returned then something went wrong with the installation.
# The command rocm-smi is no longer functional in the most recent version, so disregard that step from the video.
sudo reboot now
