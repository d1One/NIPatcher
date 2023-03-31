# NIPatcher Maschine:

# Features
### GUI / Interface
- [x] Change the default GUI window sizes.
- [x] Change GUI window minimum size (Plugins)
- [x] Change Font sizes.

### Hardware
- [x] MK3, Mikro Mk3 & M+ - Stop button Double tap.
- [x] JAM - Change patterns without changing focus.

# ℹ️ GUI / Interface

## Window Size 
<p align="center">
<img src="https://github.com/d1One/NIPatcher/blob/main/Images/Window_Size.png?raw=true" width="700">
</p>

Changes the default view presets under the Maschine Dropdown > View.
These mods are mostly usefull for the Plugins since their window size is fixed, you can for example:
- Change the one of preset sizes to make sure Maschine-Plugin fills your whole screen, usefull for people with 2 monitors for example since MAS-PLug has no Full-Screen option, only the MAS-App does.
- Minimum height can be used if for some reason you want to be able to make the Maschine App window very small and only see your Scene, Sections / Song View.
- In the future I'll add more complicated mods like making the browser wider for example.

## Font Size
This modification exists mainly because the browser has a tiny font + the fact that it's blurry/pixelated due to Maschine not having Hi-Res/Retina support.
- `Button size` affects: Tags in the Browser, Pad Names, Pattern names in Ideas view and many other things.
- `Label size` affets: Mainly the Browser Preset list (But probably many other things too)

As users share results I'll make a more detailed description of font sizes and possibly add more things to costumize.

Here is an example of both Buttons and Labels with a fontsize of 15 VS the original value of 11:
![Label and Font 15 compared to original Maschine](https://github.com/d1One/NIPatcher/blob/main/Images/Labels%2015.png)

# ℹ️ Hardware

## Stop Button
TL;DR: This mod makes the STOP button return the Playhead to the beguining if the project is not playing, basically this means we can get the same beahvior as most DAW's have: double press STOP to return to the beguining.

Longer explanation: The Maschine Mk3 introduced a STOP button on the HW, prior models did not have this, this was great but the Software never changed. If you look at Maschine's top menu Transport section there is no Stop. So as far as the softare is concerned STOP and PLAY **behave exactly the same way when the project is playing**, it makes no difference if you press PLAY again or STOP, they both do the same and thus the STOP button is redundant in this scenario... So, my mod makes STOP restart then stop really fast only when the project is playing which results in leaving the playhead in the beginning without affecting the normal STOP behavior. Best of both worlds! 🎉

This is not available for the MAS-Plugin because it does not have access to the transport, the Host/DAW does.

## Jam Focus
(untested)
Changing Patterns with Jam causes Maschine to lose focus on whatever Group you have active if the Pattern yoou changed is in another Group, often this can be undesirable, this mod changes that. This was shared by maschuser1 on the Maschine Forum [here](https://community.native-instruments.com/discussion/5072/tip-changing-patterns-on-the-maschine-jam-without-changing-focus), all credit goes to him/her.
I dont have a Jam to test this so let me know how it works!

## Examples:
Adding more examples soon.
