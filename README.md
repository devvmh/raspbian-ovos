# ovos-picroft

Run ovos on top of RaspberryPiOS

Ever wanted to run ovos on a device that an image is not provided for? Give this a try.

<strong>This guide DOES require an internet connection</strong>

## Purpose of this guide

This guide was originally designed for a headless, (No GUI) Raspberry Pi 3.  The RPi3 does not have the umph required to reliably run [ovos-shell](https://github.com/OpenVoiceOS/ovos-shell), hence "headless".  There is not an image avaliable at this point in time that works with this hardware(RPi3), so this was constructed.  This guide <strong>DOES NOT</strong> produce the same experince as the official images do.  This just creates a minimal install, that the user can then expand to thier own personal needs.

There is an image for this setup on the drawing board, but has not yet been implemented.

Please, if any mistakes, including spelling mistakes are found, or if a more detailed explanation of a step is needed, open an [issue here](https://github.com/OpenVoiceOS/ovos-picroft/issues) and I will address it ASAP.

## Step 1: Create the boot medium

- Download latest lite image and install to SD card or USB.
  - There are lots of guides, but [this one is the official guide](https://www.raspberrypi.com/documentation/computers/getting-started.html)
  - [This is the suggested download](https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-64-bit)

## Step 2: Setup the system
Boot your newly created medium and follow the prompts to create an user.
- Create user `ovos` with password `ovos`
  - The system will reboot and ask you to log in.  Log in with the above credentals

You need to configure your device with the nicely provided `raspi-config`

`sudo raspi-config`

Here you can enable several services, but a few will be necessasary.

Enter the `System Options` page

Enter the `Boot / Autologin` page
- Use the second option in the menu.  `Console Autologin`
  - This enables the ovos user to login to a console terminal on every boot

Go back to the main menu and enter the `Interface Options` page
- Enable SSH, SPI, I2C
  - After SSH is enabled, the rest of the guide can be done from a remote computer

Back to the main menu and enter the `Localisation Options` page
- Configure Locale, Timezone, WLAN Country

After these are set, you can optionally setup WIFI from here also.
- An internet connection <strong>WILL</strong> be needed.  Either WIFI here, or a LAN connection.

##### Optional: Setup WIFI
Return to the main menu and enter `System Options` again.

Enter the `Wireless LAN` section and follow the prompts

We are almost done with the device setup.

`sudo reboot now`

** From this point on, you should be able to access your device from any SSH terminal. ** For guide for how to do this, see https://www.raspberrypi.com/documentation/computers/remote-access.html. 

First you need to make sure your system is up to date.  It should be close as you just installed a new image.

`sudo apt -y update && sudo apt -y upgrade`

Now we can work on installing OVOS

## Step 3: Install OVOS-CORE

There are a few packages required for ovos, so we will install those first

`sudo apt install build-essential python3-dev swig libssl-dev libfann-dev portaudio19-dev libpulse-dev`

Also install a couple of other packages needed later

`sudo apt install cmake git libncurses-dev python3-pip`

I have also had better luck installing using `pip` from a local directory
I also install them all localy instead of system wide

Lets start with cloning a couple of repositories

- `git clone https://github.com/builderjer/ovos-raspbian.git`

This repository has files that will be used in the guide

- `git clone https://github.com/OpenVoiceOS/ovos-core.git`

This is the main ovos-core repository. While you should be able to do this without cloning the repo, I have had more luck with a fresh clone to work with.

Now we can install ovos.

This guide assumes that you are creating a headless device (no screen), so we only need some of the packages provided by ovos-core
- `pip install ./ovos-core[audio,PHAL,stt,tts,skills_lgpl,skills,bus,skills-essential]`

If you are installing a complete system with a screen, use the following command
- `pip install ./ovos-core[all]`

## Step 4: Install the systemd files

We will be installing the systemd files as a regular user instead of system wide. The official ovos buildroot images installs these files in `/usr/lib/systemd/user/`. There are guides that say user systemd files can also be placed in `/etc/systemd/user.` or `$HOME/.config/systemd/user/`. We will be using the users home directory to avoid using `sudo` here.

Enter the cloned repo `ovos-raspbian` assuming you cloned this to your home directory
- `cd ~/ovos-raspbian/systemd/`

Copy the files from there

- `cp * ~/.config/systemd/user/`

Reload the systemd daemon

- `systemctl --user daemon-reload`

Enable the system files

- `systemctl --user enable mycroft*`

## Step 5: Install the executables

These are the files that systemd uses to start ovos.  These include `hooks` for restarting and stopping the services.
- `cd ~/ovos-raspbian/libexec/`

Here we need to use sudo to copy the files to the right location.
- `sudo cp * /usr/libexec/`

And make them executable
- `sudo chmod a+x /usr/libexec/mycroft*`

These executables require `sdnotify`

- `pip install sdnotify`

Do a reboot

- `sudo reboot now`

This takes a while, especially when you are used to a Rpi4 or x86 install.  Loading everything is about as much as a Rpi3 can handle I think.

<strong>You should now have a running ovos device!!</strong>

Check with this

- `systemctl --user status mycroft*`

It takes a while to load, but they should all say `active (running)`

## Step 6: Install skills

OVOS-core does not come with any pre-installed skills, so they need to be manually installed.

Once again, I like to use `pip` where ever I can.  There are certain skills that I feel should be installed first.

I install straight from git, because they ususally have the latest bug fixes and such.

[date-time](https://github.com/OpenVoiceOS/skill-ovos-date-time)

- `pip install git+https://github.com/OpenVoiceOS/skill-ovos-date-time.git`

[weather](https://github.com/OpenVoiceOS/skill-ovos-weather)

- `pip install git+https://github.com/OpenVoiceOS/skill-ovos-weather.git`

Do this for each skill you want installed.  As a <strong>warning</strong>, pip installed skills are <strong>NOT</strong> automatically loaded on install.  A restart of mycroft is required.

- `systemctl --user restart mycroft`

## Step 7: Extras

There are a few things that are usefull to me.  [ncpamixer](https://github.com/fulhax/ncpamixer) and [ovos-cli-client](https://github.com/OpenVoiceOS/ovos-cli-client)

```
git clone https://github.com/fulhax/ncpamixer.git
cd ncpamixer/
make
sudo make install
```

`pip install git+https://github.com/OpenVoiceOS/ovos-cli-client.git`

I hope this helps people, and if there are mistakes, please let me know
