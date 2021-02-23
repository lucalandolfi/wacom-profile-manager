# Wacom Profile Manager

Wacom Profile Manager is a simple, extendible script written in `bash` which provides a way to manage multiple configurations for graphic tablets, such as Wacom devices. A configuration, or a profile, is a set of options and button mappings associated with a tablet. Different softwares may and would need different configurations, mostly different button mappings. This can be used to quickly switch between configurations for different softwares (e.g. Krita and GIMP).

Profiles are defined using `bash` code to invoke appropriate commands to configure tablets. A profile could execute anything, not just tablet-specific commands. 

This uses `xsetwacom` to configure devices and `notify-send` to notify user.

### Add a new profile
New profiles can be defined inside the profiles file, which is by default located at `$HOME/.local/share/wacom-profile-manager/profiles.sh`.

First define a function which contains the command associated with the new profile (e.g. button mapping, drawing area, etc...)

```
profile_NEWPROFILE () {
    xsetwacom set ...
    xsetwacom set ...
}
```
Then, install the profile handler
```
PROFILES['NEW PROFILE NAME']=profile_NEWPROFILE
```
`profiles.sh` provides an example of two profiles.

### Usage
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
