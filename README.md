# Wacom Profile Manager

Wacom Profile Manager is a tool for managing multiple profiles for graphic tablets which are compatible with Linux [Wacom driver](https://github.com/linuxwacom).

A profile is a set of options and button mappings associated with a tablet. Different softwares may need different configurations, mostly different button mappings. This can be used to quickly switch between configurations for different softwares (e.g. Krita and GIMP). Profiles are a list of shell commands used to configure the tablet (e.g. `xsetwacom` commands).

Wacom Profile Manager is composed of two scripts:

* `wacom-profile-manager` The main component. Change active profile.

* `switchmonitor` Maps the active area of the tablet to a connected monitor.

It's entirely written in `bash` and uses `libnotify` to show a notification on profile change. Tablet must be supported by the Linux Wacom Driver, such as Wacom or Huion devices.

## Install

* Install dependencies	
```
sudo apt-get install bash libnotify xserver-xorg-input-wacom
```

* Copy the scripts to a directory in your `PATH`, for example: 
```
sudo cp wacom-profile-manager switchprofile /usr/local/bin
```

## Configuration
### Devices definition
Using the output of `xsetwacom list`, write the names of the devices exposed by your tablet in the `devices` file, which is located by default at `$HOME/.config/wacom-profile-manager/devices`. 

For example

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

These variables can then be used in a profile file
```
xsetwacom set "$STYLUS" 'MapToOutput' 'DP-2'
xsetwacom set "$STRIP" 'AbsWheelUp' 'key ctrl -'
xsetwacom set "$PAD" button  2 'key ctrl shift z'
...
```

You can define other variables if your tablet exposes more devices. You can also name them in a different way. The only requirement is that `STYLUS` is defined in the `devices` file because it's used by `swtichmonitor` to change the monitor the active area of the tablet is mapped to.

### Add a new profile
New profiles can be added inside the profiles directory, which by default is located at `$HOME/.config/wacom-profile-manager/profiles.d`. Create a new file for each profile. File names cannot contains whitespace. The file name will also be the profile name. The contents of a profile is a list of commands
```
xsetwacom set ...
xsetwacom set ...
```

### Examples
The [examples](examples/) directory contains a `devices` file and two profiles that are used along with a Huion HS611 tablet. If you want to try them out
```
CONF=${HOME}/.config/wacom-profile-manager
mkdir -p ${CONF}
cp examples/devices ${CONF}
cp -R examples/profiles.d ${CONF}
```

## Usage
### wacom-profile-manager
Print usage, available profiles and current profile (marked with a \*)
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

Switch to a particular profile
```
$ wacom-profile-manager profile Xournal++
Active profile: Xournal++
```

Print active profile
```
$ wacom-profile-manager current
Xournal++
```

Cycle through all defined profiles
```
$ wacom-profile-manager next
Active profile: Krita
$ wacom-profile-manager next
Active profile: Xournal++
$ wacom-profile-manager next
Active profile: Krita
```

### switchmonitor
List available monitors
```
$ switchmonitor list
LVDS-1 DP-2
```

Print output tablet is currently mapped to
```
$ switchmonitor current
DP-2
```

Map tablet to  `LVDS-1` (laptop internal monitor)
```
$ switchmonitor output LVDS-1
Map to: LVDS-1
```

Map tablet to primary output
```
$ switchmonitor primary
Map to: DP-2
```

Cycle through available outputs
```
$ switchmonitor next
Map to: LVDS-1
$ switchmonitor next
Map to: DP-2
```
