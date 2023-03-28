# NIPatcher
Patcher to apply modifications to Native Instruments Maschine and Komplete Kontrol software.

## Features - Maschine
### GUI
- [x] Change the default GUI window sizes.
- [x] Change GUI window minimum size (Plugins)
- [x] Change Font sizes.

### Hardware
- [x] MK3, M+, Studio - Stop button Double tap to bring playhead to the start.
- [x] JAM - Change patterns without changing Group focus.


# How to use NIPAtcher.
* 1. Press `Copy` button, this will copy all your Maschine Plugins + the Maschine app to a new folder on your Desktop called NIPatcher, it will also create shortcuts to your App and Plugin locations.<br>
* 2. Select the modifications you want and whether you want them to be applied Maschine 2.app, your plugins or both.<br>
* 3. Press `Patch` and the modifications will be applied to all files in the NIPatcher folder on the Desktop.<br>
* 4. (Optional) Press `Codesign` - this is mostly only required for Ableton Live users.<br>
* 5. Open the NIPatcher folder on your Desktop and simply move each modified file into its respective shortcut and confirm you want to overwrite the unmodified version.<br>

*If you dont codesign I step 4 MacOS will claim the app is damaged, if that happens simply right-click it and select `Open`.

### Further Step explanation.
- 1. Due to Apple's security features writing into `/Library/Audio/Plug-Ins` or `/Library/Application Support/Avid/Audio/Plug-Ins` requires either the user to be prompted for the folders or for me to make an external helper tool (like the one Native Access has). This is way above my current very low skillset so instead of directly modifying the files they are copied to the desktop first, this might not be ideal but gives the user a chance to check if everything is working on the App copy for example.<br>
- 4. Codesign is also required due to Security stuff, since we modify the Plugins and/or application and some DAW's like Ableton Live check for this we need to codesign it s Ableton Live can sleep well at night and not be scared.<br>
- 5. Moving the files thru the shortcuts is the fastest way I was able to make it work without bothering the user too much, this way it's the MacOS Finder who asks you for permissions when moving the modified files to the Plugins/Application locations.<br>
