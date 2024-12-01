# Tips

## Pipewire

Interact with pipewire using `pw-cli`

For example, to list objects:

- Open the command line interface `pw-cli`
- List objects ls, or
- `pw-cli ls`

`/usr/share/pipewire` contains all the default setup, among them example filter
chains.

### Filter-Chains

- Load a filter chain from file with: `pipewire -c <absolute_path_to_filter_chain_file>`
- Default filter chains can be found in `/usr/share/pipewire/filter-chain`

To run a filter chain from one configuration file, the configuration file has
to include pre-requisite filters in the `context.modules` array.

```json
    { name = libpipewire-module-rt
        args = {
            #rt.prio      = 83
            #rt.time.soft = -1
            #rt.time.hard = -1
        }
        flags = [ ifexists nofail ]
    }
    { name = libpipewire-module-protocol-native }
    { name = libpipewire-module-client-node }
    { name = libpipewire-module-adapter }
```

#### Filter Chain Parameters

- Filter Chain Parameters are attached to the capture stream
- List the available streams with `pw-cli ls Node`
- List current settings with `pw-dump <id>`
- To prevent a filter chain from connecting automatically,
set `node.autoconnect = false` in the capture and playback props

## Wireplumber

Execute lua scripts with `wpexec`

Change setting with `wpctl`

For example to set log level to debug: `wpctl set-log-level D`
To set it back to the default: `wpctl set-log-level -`

Wireplumber is generally started as a systemd user service.

To get the status `systemctl status --user wireplumber`
To get the logs `journalctl --user-unit wireplumber`
