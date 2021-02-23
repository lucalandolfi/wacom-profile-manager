# Wacom Profile Manager

Wacom Profile Manager is a `bash` script which provides a way to manage multiple configurations for graphic tablets, such as Wacom devices. A configuration, or a profile, is a set of options and button mappings associated with a tablet. Different softwares may and would need different configurations, mostly different button mappings. This can be used to quickly switch between configurations for different softwares (e.g. Krita and GIMP).

Profiles are defined using `bash` code to invoke appropriate commands to configure tablets. A profile could execute anything, not just tablet-specific commands.

Wacom Profile Manager uses `xsetwacom` to configure devices and `notify-send` to notify user.

## Configuration
### Devices definition
Using the output of `xsetwacom list`, write the names of the devices exposed by your tablet in the `devices` file, which is located by default at `$HOME/.config/devices`.

```
$ xsetwacom list
```

The `devices` file will look like
```
STYLUS=''
PAD=''
STRIP=``
```

Variables with these names can then be used in a profile file, e.g. `$STYLUS`, `$PAD` and `$STRIP`.

### Add a new profile
New profiles can be added inside the profiles directory, which by default is located at `$HOME/.config/wacom-profile-manager/profiles.d`. Create a new file for each profile. File names cannot contains whitespace. The file name will also be the profile name. The contents of a profile is a list of commands
```
xsetwacom set ...
xsetwacom set ...
```

## Usage
To print usage, available profiles and current profile (marked with a \*)
```
$ wacom-profile-manager
Usage: wacom-profile-manager [command [profile]]
Commands:
 profile profile_name  - set the profile profile_name
 next                  - cycle throught available profiles
 current               - print active profile
 help                  - print help

Profiles:
    Xournal++
    * Krita
```

To switch to a particular profile
```
$ wacom-profile-manager profile Xournal++
Active profile: Xournal++
```

To print active profile
```
$ wacom-profile-manager current
Xournal++
```

To cycle through all defined profiles
```
$ wacom-profile-manager next
Active profile: Krita
$ wacom-profile-manager next
Active profile: Xournal++
$ wacom-profile-manager next
Active profile: Krita
```
