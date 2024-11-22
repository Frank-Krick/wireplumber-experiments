# Tips

## Pipewire

Interact with pipewire using `pw-cli`

For example, to list objects:

- Open the command line interface `pw-cli`
- List objects ls

`/usr/share/pipewire` contains all the default setup, among them example filter
chains.

## Wireplumber

Execute lua scripts with `wpexec`

Change setting with `wpctl`

For example to set log level to debug: `wpctl set-log-level D`
To set it back to the default: `wpctl set-log-level -`

Wireplumber is generally started as a systemd user service.

To get the status `systemctl status --user wireplumber`
To get the logs `journalctl --user-unit wireplumber`
