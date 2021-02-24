# Wacom Profile Manager

Wacom Profile Manager is a tool used for managing multiple configurations for graphic tablets, such as Wacom devices. A configuration, or a profile, is a set of options and button mappings associated with a tablet. Different softwares may and would need different configurations, mostly different button mappings. This can be used to quickly switch between configurations for different softwares (e.g. Krita and GIMP).

Profiles are defined using `bash` code to invoke appropriate commands to configure tablets. A profile could execute anything, not just tablet-specific commands.


`wacom-profile-manager`
`switchmonitor`

## Install

**Dependencies**
* `bash`
* `xsetwacom`
* `libnotify`

## Configuration
### Devices definition
Using the output of `xsetwacom list`, write the names of the devices exposed by your tablet in the `devices` file, which is located by default at `$HOME/.config/devices`. For example:

```
$ xsetwacom list
HUION Huion Tablet_HS611 stylus 	id: 19	type: STYLUS    
HUION Huion Tablet_HS611 Pad pad	id: 20	type: PAD       
HUION Huion Tablet_HS611 Touch Strip pad	id: 21	type: PAD  
```

The `devices` file will look like
```
STYLUS='HUION Huion Tablet_HS611 Pen stylus'
PAD='HUION Huion Tablet_HS611 Pad pad'
STRIP='HUION Huion Tablet_HS611 Touch Strip pad'
```

These variables can then be used in a profile file, e.g. `$STYLUS`, `$PAD` and `$STRIP`. Note that only `$STYLUS` variable is required to be defined (it's used by `swtichmonitor`).

### Add a new profile
New profiles can be added inside the profiles directory, which by default is located at `$HOME/.config/wacom-profile-manager/profiles.d`. Create a new file for each profile. File names cannot contains whitespace. The file name will also be the profile name. The contents of a profile is a list of commands
```
xsetwacom set ...
xsetwacom set ...
```

### Examples
The `examples` directory contains a `device` file and two profiles that are used along with a Huion HS611 tablet.

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
