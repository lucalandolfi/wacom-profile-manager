# Example of profiles definition

source devices.sh

# Map tablet to primary output
set_primary () {
    PRIMARY_OUTPUT=$(xrandr | \
        grep ' connected' | \
        grep primary | cut -d' ' -f1)

    xsetwacom set "$STYLUS" MapToOutput "$PRIMARY_OUTPUT"
}

# Krita
profile_krita () {
    set_primary
    xsetwacom set "$STYLUS" 'Mode' 'Absolute'
    xsetwacom set "$STYLUS" 'Area' '0 0 51680 29070'
    # ---
    xsetwacom set "$STRIP" "AbsWheelUp" "key ctrl -"
    xsetwacom set "$STRIP" "AbsWheelDown" "key ctrl shift ="
    # ---
    xsetwacom set "$PAD" button  1 "key ctrl z"
    xsetwacom set "$PAD" button  2 "key ctrl shift z"
    xsetwacom set "$PAD" button  3 "key control ]"
    xsetwacom set "$PAD" button  8 "key 5"
    xsetwacom set "$PAD" button  9 "key control ["
    # ---
    xsetwacom set "$PAD" button 10 "key +shift"
    xsetwacom set "$PAD" button 11 "key +control"
    xsetwacom set "$PAD" button 12 ""
    xsetwacom set "$PAD" button 13 "key shift control w"
    xsetwacom set "$PAD" button 14 "key super"
}

# Xournal++
profile_xournalpp () {
    set_primary
    xsetwacom set "$STYLUS" 'Mode' 'Absolute'
    xsetwacom set "$STYLUS" 'Area' '0 0 51680 29070'
    # ---
    xsetwacom set "$STRIP" "AbsWheelUp" "key ctrl -"
    xsetwacom set "$STRIP" "AbsWheelDown" "key ctrl shift ="
    # ---
    xsetwacom set "$PAD" button 1 "key ctrl z"
    xsetwacom set "$PAD" button 2 "key ctrl y"
    xsetwacom set "$PAD" button 3 "key ctrl shift p"
    xsetwacom set "$PAD" button 8 "key ctrl shift h"
    xsetwacom set "$PAD" button 9 "key ctrl shift r"
    # ---
    xsetwacom set "$PAD" button 10 "key shift Print"
    xsetwacom set "$PAD" button 11 "key ctrl v"
    xsetwacom set "$PAD" button 12 ""
    xsetwacom set "$PAD" button 13 "key shift control w"
    xsetwacom set "$PAD" button 14 "key super"
}

# Profiles installation
PROFILES['Krita']=profile_krita
PROFILES['Xournal++']=profile_xournalpp
