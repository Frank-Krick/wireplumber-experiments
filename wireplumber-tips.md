# Wireplumber Tips

Execute lua scripts with `wpexec`

Change setting with `wpctl`

For example to set log level to debug: `wpctl set-log-level D`
To set it back to the default: `wpctl set-log-level -`

Wireplumber is generally started as a systemd user service.

To get the status `systemctl status --user wireplumber`
To get the logs `journalctl --user-unit wireplumber`
