# NIPatcher
Patcher to apply modifications to Native Instruments Maschine and Komplete Kontrol software, only supporting Maschine for now.

Tested in Maschine v2.17 only (but should work on most modern recent versions)

## Features - Maschine
### GUI
- [x] Change the default GUI window sizes.
- [x] Change GUI window minimum size (Plugins)
- [x] Change Font sizes.

### Hardware
- [x] MK3, M+, Studio - Stop button Double tap to bring playhead to the start.
- [x] JAM - Change patterns without changing Group focus.

# How to use NIPatcher.
* 1 - Press `Copy` button, this will copy all your Maschine Plugins + the Maschine app to a new folder on your Desktop called NIPatcher, it will also create shortcuts to your App and Plugin locations.<br>
* 2 - Select the modifications you want and whether you want them to be applied Maschine 2.app, your plugins or both.<br>
* 3 - Press `Patch` and the modifications will be applied to all files in the NIPatcher folder on the Desktop.<br>
* 4 - (Optional) Press `Codesign` - this is mostly only required for Ableton Live users.<br>
* 5 - Open the NIPatcher folder on your Desktop and simply move each modified file into its respective shortcut and confirm you want to overwrite the unmodified version.<br>

If you don't codesign in Step #4 MacOS will think the app is damaged, if that happens simply right-click it and select `Open`.

#### Why so many steps?
<details>
  <summary>1 Copy</summary>
Due to Apple's security features writing into `/Library/Audio/Plug-Ins` or `/Library/Application Support/Avid/Audio/Plug-Ins` requires either the user to be prompted for the folders or for me to make an external helper tool (like the one Native Access has). This is way above my current very low skillset so instead of directly modifying the files they are copied to the desktop first, this might not be ideal but gives the user a chance to check if everything is working on the App copy for example.<br>
</details>

<details>
  <summary>4 Codesign</summary>
Codesign is also required due to Security stuff, since we modify the Plugins and/or application and some DAW's like Ableton Live check for this we need to codesign it s Ableton Live can sleep well at night and not be scared.<br>
</details>

<details>
  <summary>5 Manually moving patched files</summary>
Moving the files thru the shortcuts is the fastest way I was able to make it work without bothering the user too much, this way it's the MacOS Finder who asks you for permissions when moving the modified files to the Plugins/Application locations.<br>
</details>


# Discription of the modifications:
## Window Size:
![Window Size Explanation](https://github.com/d1One/NIPatcher/blob/main/Images/Window_Size.png?raw=true)
Changes the default views under the Maschine Dropdown > View.
These mods are mostly usefull for the Plugins since their window size is fixed, you can for example:
- Change the `Small` size and since this is the 'view' that Maschine-Plugin starts with by default you can always have your prefered size when the Plug-In is loaded. 
- It can also allow you to set a huge size that covers the whole screen as a workaround for MAS-Plug not having a full screen option.
- Minimum height can be used if for some reason you want to be able to make the Maschine App window very small and only see your Scene, Sections / Song View.

## Font Size:
This modification exists mainly because the browser has a tiny font + the fact that it's blurry/pixelated due to Maschine not having Hi-Res/Retina support.
- Button size affects: Tags in the Browser, Pad Names, Pattern names in Ideas view and many other things.
- Label size affets: Mainly the Browser Preset list (But probably many other things too)

As users share results I'll make a more detailed description of font sizes and possibly add more things to costumize.

Here is an example of both Buttons and Labels with a fontsize of 15 VS the original value of 11:
![Label and Font 15 compared to original Maschine](https://github.com/d1One/NIPatcher/blob/main/Images/Labels%2015.png)

## Stop Button.
TL;DR: This mod makes the `Stop` button return the Playhead to the beguining if the project is not playing, basically this means we can get the same beahvior as most DAW's have: double press `Stop` to return to the beguining.

Longer explanation: The Maschine Mk3 introduced a Stop button to the HW, prior models did not have this, that was great but the Software never changed. If you look at Maschine's top menu Transport section there is no Stop. So as far as the softare is concerned `Stop` and `Play` **behave exactly the same way when the project is playing**, it makes no difference if you press `Play` again or `Stop`, they both do the same and thus the `Stop` button is completly redundant in Maschine-SW... So, my mod makes `Stop` restart and stop really fast only when the project is playing which results in leaving the playhead in the beguinin without affecting the normal Stop behavior. Best of both worlds! 🎉

This is not available for the Plugin because MAS-Plug does not have access to transport, the Host/DAW does.

## Jam Focus
(untested)
Changing Patterns with Jam causes Maschine to lose focus on whatever Group you have active if the Pattern yoou changed is in another Group, often this can be undesirable, this mod changes that. This was shared by maschuser1 on the Maschine Forum [here](https://community.native-instruments.com/discussion/5072/tip-changing-patterns-on-the-maschine-jam-without-changing-focus), all credit goes to him/her.



