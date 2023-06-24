chown -Rf ovos:ovos /home/ovos

systemctl set-default multi-user.target

systemctl preset-all

cat /etc/passwd | grep -i ovos

su -c "systemctl --user preset-all" --login ovos
