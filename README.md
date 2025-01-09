# NIPatcher
## Due to low interest this project is now archived, I won't be continuing it, if anyone wants to do so than feel free, reuse any code, etc...

Patcher to apply modifications to Native Instruments Maschine and Komplete Kontrol software.

This project is open-source but currently halted, working on a possibly re-write for cross compatibility with Windows. Only MacOS for now!

MacOS compatibility:
- Native Apple Silicon support.
- macOS 13 Ventura.
- macOS 12 Monterey.
- macOS 11 Big Sur.

I might add older versions later depending on users engagement.

## How to download:
Press "Releases" to the right of this page then press the .zip file.
<p align="center"><img src="https://github.com/d1One/NIPatcher/blob/main/Images/HowToDownload.png" width="500"></p>


# How to use NIPatcher:
The first time runing the app requires a righ-click and selecting `Open`, MacOS will tell you it can't verify the app, thats normal since I really dont want to pay no $100 for the Apple developer certification.

* 1 - Press `Copy` button, this will copy all your Plugins + the Maschine/KK App to a new folder on your Desktop called NIPatcher, it will also create shortcuts to your App and Plugin locations.<br>
* 2 - Select the modifications you want and whether you want them to be applied your App, Plugins or both.<br>
* 3 - Press `Patch` and the modifications will be applied to all files in the NIPatcher folder on the Desktop.<br>
* 4 - (Optional) Press `Codesign` - this is mostly only required for Ableton Live users. ⚠️ This is also a good time to test the MAS/KK App before actually replacing your files in the next step!<br>
* 5 - Open the NIPatcher folder on your Desktop and simply move each modified file into its respective shortcut and confirm you want to overwrite the unmodified version.<br>

<p align="center">
<img src="https://github.com/d1One/NIPatcher/blob/main/Images/move%20and%20replace.png?raw=true" width="300">
</p>

NOTES:
- Step 1 is a good oportunity to zip the NIPatcher folder on your desktop as a backup.
- If you don't codesign in Step #4 MacOS will think the app is damaged, if that happens simply right-click it and select `Open`.<br>
- If you break all your Plugins/App just reinstall Maschine / Komplete Kontrol from Native Access or copy back from the zip backup<br>
- Interface/GUI mods can be applied more than once but HW mods cannot.<br>

#### Why so many steps?
<details>
  <summary>1 Copy</summary>
Due to Apple's security features writing into `/Library/Audio/Plug-Ins` or `/Library/Application Support/Avid/Audio/Plug-Ins` requires either the user to be prompted for the folders or for me to make an external helper tool (like the one Native Access has). This is way above my current very low skillset so instead of directly modifying the files they are copied to the desktop first, this might not be ideal but gives the user a chance to check if everything is working on the App copy for example.<br>
</details>

<details>
  <summary>4 Codesign</summary>
Codesign is also required due to Security stuff, since we modify the Plugins and/or application and some DAW's like Ableton Live check for this we need to codesign them so Ableton Live can sleep well at night and not be scared.<br>
</details>

<details>
  <summary>5 Manually moving patched files</summary>
Moving the files thru the shortcuts is the fastest way I was able to make it work without bothering the user too much, this way it's the MacOS Finder who asks you for permissions when moving the modified files to the Plugins/Application locations.<br>
</details>

## Help and details about all modifications
### [Maschine](https://github.com/d1One/NIPatcher/blob/main/Help/Maschine.md)
### [Komplete Kontrol](https://github.com/d1One/NIPatcher/blob/main/Help/KompleteKontrol.md)

## Why make NIPatcher?
To make some improvements to the software since feature requests seem to not achieve anything. Making modifications manually is annoying and hard for the average user, by having an app dedicated to it perhaps more users will be willing to contribute with more modifications and this project can grow.


## If you want to contribute:
As of now I am just a newbie with this stuff, I'm not a real developer so until I'm more familiar with github pull requests wont be a thing, I also need the app tested by some users to know it's good, rewrite lots of the code to make it more readable etc... Then I'll put it fully on github as open-source.

So for now anyone that wants to contribute can just right click the Maschine / KK applications , select show package contents, mess around and report anything usefull. If I am not a dev and found some stuff, so can you! :)
