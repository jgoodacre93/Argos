
#ToDo: Move user.js file to proper directory ~/.mozilla/ http://kb.mozillazine.org/Profile_folder
#ToDo: set up installation of extra programs: maltego, sherlock's brothers,
#ToDo: set osint report templates for libreoffice
#ToDo: set choice in the user profile script of your interest

#!/bin/bash
# Most of this script is based on the Michael Bazzell's txt and Skykn0t's OSINT_VM_Setup script, so credit where credit is due.
echo '#######################################################################'
echo '#                       Let me Update the distro                      #'
echo '#######################################################################'

sudo apt-get -y update && sudo snap refresh
sudo apt-get -y upgrade

# Optional Virtualbox tools.
# sudo add-apt-repository multiverse
# sudo apt install virtualbox-guest-dkms virtualbox-guest-x11
# sudo adduser osint vboxsf

# setting the 'quiet' background image
cd ~/Downloads/Argos/wallpaper/ 
sudo cp * ~/Pictures
gsettings set org.gnome.desktop.background picture-uri 'file:///home/osint/Pictures/Be-quiet-Priest-sculpture-in-Venlo.jpg'


# Bazzell goodies - Please change PASSWORD with the current one!
echo '#######################################################################'
echo '#                       Bazzell''s goodies                            #'
echo '#######################################################################'
cd ~/Documents/
curl -u osint:PASSWORD -O https://inteltechniques.com/osintbooksecure/linux.20.txt

cd ~/Downloads
curl -u osint:PASSWORD -O https://inteltechniques.com/osintbooksecure/vm-files.zip
unzip vm-files.zip -d ~/Desktop/

curl -u osint:PASSWORD -O https://inteltechniques.com/osintbooksecure/workflow.zip
unzip workflow.zip -d ~/Documents/

curl -u osint:PASSWORD -O https://inteltechniques.com/osintbooksecure/tools.zip
unzip tools.zip -d ~/Documents/

curl -u osint:PASSWORD -O https://inteltechniques.com/osintbooksecure/templates.zip
mkdir ~/Documents/templates && unzip templates.zip -d ~/Documents/templates

mkdir ~/Documents/scripts
cd ~/Desktop/vm-files/scripts
sudo cp * ~/Documents/scripts
sudo chown -R $USER ~/Documents/scripts/

mkdir ~/Documents/icons
cd ~/Desktop/vm-files/icons
cp * ~/Documents/icons

cd ~/Desktop/vm-files/shortcuts
sudo cp * /usr/share/applications/

# the date_osint_tools.sh is copied in the program folder
cd ~/Downloads
mkdir Programs
cd Programs
cp ~/Downloads/Argos/update_osint_tools.sh ~/Downloads/Programs/
sudo chmod +x update_osint_tools.sh

# Requirements for installing tools, scripts and launchers
echo '#######################################################################'
echo '#      Requirements for installing tools, scripts and launchers       #'
echo '#######################################################################'
sudo apt install -y python3
sudo apt install -y python-setuptools
sudo apt install -y jq
sudo apt install -y python3-pip
sudo apt install -y git
sudo apt install -y curl
sudo apt install -y wget
#  (missing)  "python-pip"
#  (missing)  "xargs"
sudo snap install -y vlc
sudo -H pip3 install --upgrade youtube_dl
sudo apt install -y curl
sudo -H pip3 install Instalooter
sudo -H pip3 install Instaloader
sudo python3 -m pip install pipenv
sudo apt-get install -y webhttrack
sudo apt install -y ffmpeg
sudo apt-get install -y mediainfo-gui
sudo apt install -y libimage-exiftool-perl


echo '#######################################################################'
echo '#                             Amass                                   #'
echo '#######################################################################'
echo
sudo snap install amass

# Twint
echo '#######################################################################'
echo '#                             Twint                                   #'
echo '#######################################################################'

cd ~/Downloads/Programs
git clone https://github.com/twintproject/twint.git
cd twint
sudo -H pip3 install twint
sudo -H pip3 install -r requirements.txt

# EyeWitness
echo '#######################################################################'
echo '#                          EyeWitness                                 #'
echo '#######################################################################'
cd ~/Downloads/Programs
git clone https://github.com/ChrisTruncer/EyeWitness.git
cd EyeWitness/Python/setup
sudo -H ./setup.sh
cd ~/Documents/scripts
sed -i "s/Programs\/EyeWitness/Programs\/EyeWitness\/Python/g" eyewitness.sh

# sublist3r
echo '#######################################################################'
echo '#                           sublist3r                                 #'
echo '#######################################################################'
cd ~/Downloads/Programs
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r && sudo -H pip3 install -r requirements.txt

# sublist3r
echo '#######################################################################'
echo '#                              Photon                                 #'
echo '#######################################################################'
cd ~/Downloads/Programs
git clone https://github.com/s0md3v/Photon.git
cd Photon && sudo -H pip3 install -r requirements.txt

# The Harvester
echo '#######################################################################'
echo '#                       The Harvester                                 #'
echo '#######################################################################'
cd ~/Downloads/Programs
git clone https://github.com/laramies/theHarvester.git
cd theHarvester
git checkout 8b88a66
sudo -H pip3 install -r requirements.txt

# Metagoofil
echo '#######################################################################'
echo '#                           Metagoofil                                #'
echo '#######################################################################'
cd ~/Downloads/Programs
git clone https://github.com/opsdisk/metagoofil.git
cd metagoofil
sudo -H pip3 install -r requirements.txt

# recon-ng
echo '#######################################################################'
echo '#                              recon-ng                               #'
echo '#######################################################################'
cd ~/Downloads/Programs
git clone https://github.com/lanmaster53/recon-ng.git
cd recon-ng
sudo -H pip3 install -r REQUIREMENTS

# sherlock
echo '#######################################################################'
echo '#                              sherlock                               #'
echo '#######################################################################'
cd ~/Downloads/Programs
git clone https://github.com/sherlock-project/sherlock.git
cd sherlock
python3 -m pip install -r requirements.txt
cd ~/Documents/scripts/
sed -i 's/Programs\/sherlock/Programs\/sherlock\/sherlock/g' sherlock.sh

# spiderfoot
echo '#######################################################################'
echo '#                            spiderfoot                               #'
echo '#######################################################################'
cd ~/Downloads/Programs
git clone https://github.com/smicallef/spiderfoot.git
cd spiderfoot
sudo -H pip3 install -r requirements.txt
cd ~/Documents/scripts
sed -i '/^sudo/ d' spiderfoot.sh
sed -i '/^firefox/ d' spiderfoot.sh
echo "cd ~/Downloads/Programs/spiderfoot" >> spiderfoot.sh
echo "python3 sf.py -l 127.0.0.1:5001 &" >> spiderfoot.sh
echo "sleep 5" >> spiderfoot.sh
echo "firefox http://127.0.0.1:5001" >> spiderfoot.sh

# Elasticsearch-Crawler
echo '#######################################################################'
echo '#                     Elasticsearch-Crawler                           #'
echo '#######################################################################'
cd ~/Downloads/Programs
git clone https://github.com/AmIJesse/Elasticsearch-Crawler.git
cd Elasticsearch-Crawler
sudo -H pip3 install nested-lookup
sudo -H pip3 install internetarchive

#Ripgrep
echo '#######################################################################'
echo '#                               Ripgrep                               #'
echo '#######################################################################'
cd ~/Downloads/
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb

#holehe
echo '#######################################################################'
echo '#                                holehe                               #'
echo '#######################################################################'
cd ~/Downloads/Programs
git clone https://github.com/megadose/holehe.git
cd holehe
sudo python3 setup.py install

#anonsurf (credit to Und3rf10w)
echo '#######################################################################'
echo '#                              anonsurf                               #'
echo '#######################################################################'
cd ~/Downloads/Programs
git clone https://github.com/Und3rf10w/kali-anonsurf.git
cd kali-anonsurf/
sudo ./installer.sh

#Moriarty-Project
echo '#######################################################################'
echo '#                        Moriarty-Project                             #'
echo '#######################################################################'
cd ~/Downloads/Programs
git clone https://github.com/AzizKpln/Moriarty-Project
cd Moriarty-Project
chmod 755 install.sh ./install.sh

#maigret
echo '#######################################################################'
echo '#                               maigret                               #'
echo '#######################################################################'
cd ~/Downloads/Programs
git clone https://github.com/soxoj/maigret
cd maigret
pip3 install .

#Google earth (still unable to fix an issue with the package key)
#echo '#######################################################################'
#echo '#                               maigret                               #'
#echo '#######################################################################'
#Google earth (still unable to fix an issue with the package key)
#sudo wget -O google-earth64.deb http://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb
#sudo dpkg -i google-earth64.deb
#sudo apt-get -f install; sudo rm google-earth64.deb

# Modify scripts
echo '#######################################################################'
echo '#                       Customising scripts                           #'
echo '#######################################################################'
cd ~/Documents/scripts/
sed -i "s/python3\.6/python3/g" domains.sh
sed -i "s/python\ sublist3r/python3\ sublist3r/g" domains.sh
sed -i "s/pip\ install/pip3\ install/g" updates.sh
sed -i "s/sudo\ pip3/sudo\ \-H\ pip3/g" updates.sh
pip3 install --upgrade pip
cd ~/Downloads/Programs

# General Purpose tools
echo '#######################################################################'
echo '#                       General Purpose tools                         #'
echo '#######################################################################'
sudo snap install cherrytree
sudo snap install atom --classic
sudo snap install keepassxc
sudo apt install -y kazam
sudo apt install -y audacity
sudo apt install -y openjdk-11-jre
sudo apt install -y ubuntu-restricted-extras p7zip unrar
sudo apt install -y fonts-crosextra-caladea fonts-crosextra-carlito

#sudo apt install calibre
#sudo snap install pycharm-professional --classic --edge
#sudo snap install telegram-desktop

sudo reboot now
