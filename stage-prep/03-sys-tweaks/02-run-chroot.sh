git clone https://github.com/foundObjects/zram-swap
cd zram-swap
./install.sh
cd ..
rm -rf zram-swap

echo '# Setup soundcard - set correct volume and sound card settings'
#Raise 'Master' volume to 46
amixer -D hw:sndrpiproto sset 'Master' 46%
#enable 'Master Playback'
amixer -D hw:sndrpiproto sset 'Master Playback ZC' on
#enable 'Mic' 'Capture'
amixer -D hw:sndrpiproto cset iface=MIXER,name='Mic Capture Switch' on
#enable 'Playback Deemp'
amixer -D hw:sndrpiproto sset 'Playback Deemphasis' on
#set 'Input Mux' to 'Mic'
amixer -D hw:sndrpiproto sset 'Input Mux' 'Mic'
#enable 'Output Mixer HiFi'
amixer -D hw:sndrpiproto sset 'Output Mixer HiFi' on
#enable 'Store DC Offset'
amixer -D hw:sndrpiproto sset 'Store DC Offset' on
alsactl store
