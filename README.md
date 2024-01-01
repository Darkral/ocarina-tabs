# 10 Hole Ocarina Plugin for MuseScore


Add 10 hole ocarina tabs to your favourite score ... or at least try :hand_over_mouth:

![](https://github.com/Darkral/ocarina-tabs/blob/main/images/example.png)

The score must be/have:

- treble clef, uniform along the track
- single-track
- single-staff
- single-voice
- single-note per stem

... no guarantee it will work with complex scores!

> [!CAUTION]
> This plugin heavily depends on staff text elements.  
> those created by `Add` → `Text` → `Staff Text`, or by the shortcut `Ctrl` + `T` (Mac: `⌘` + `T`)  
> It will <ins>ERASE ALL</ins> staff text elements and create anew with ocarina tabs.  
> Please create a backup copy of your score before running the plugin!

> [!NOTE]
> release 1.0 has been tested on Windows, with MuseScore 3.6.2 and 4.2.0

## License

[GNU GPL v3](https://www.gnu.org/licenses/licenses.html.en)


## Installation

**TL;DR:** You will need **(1)** to copy the plugin folder `10holeocarinatabs` into the MuseScore plugin folder and **(2)** install the font with ocarina glyphs/tabs.

1. Download as .zip file the folder `https://github.com/Darkral/ocarina-tabs/tree/main/10holeocarinatabs` through [download-directory.github.io](https://download-directory.github.io/)
1. Locate your MuseScore plugin folder, typically at:
   - **Windows:** `%HOMEPATH%\Documents\MuseScore3\Plugins` or `%HOMEPATH%\Documents\MuseScore4\Plugins`
   - **macOS:** `~/Documents/MuseScore3/Plugins` or `~/Documents/MuseScore4/Plugins`
   - **Linux:** `~/Documents/MuseScore3/Plugins` or `~/Documents/MuseScore4/Plugins`
1. Inside MuseScore plugin folder, create a new folder `...\Plugins\10holeocarinatabs` and copy here the contents of the .zip file
1. Finally, you can find "Ocarina" font in `..\10holeocarinatabs\font` folder;  
   if you are on Windows, double click on `Ocarina.ttf` and follow the installation procedure

> [!NOTE]
> if your MuseScore is version 3.x, remeber to enable the plugin with the plugin manager.

## Demo

MuseScore 3.6.2  
![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ms3.gif)

MuseScore 4.2.0  
![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ms4.gif)

> [!TIP]
> use the score style property `Format` → `Style` →  `Bar` →  `Minimum note distance` to find the optimal distance between notes/ocarina tabs!

## Notes for the Braves

 - The plugin itself (.qml file) should be working also on macOS and Linux. You might have only to work on the font, if your operating system complains about .ttf fonts. Edit `10h_ocarina_glyphs.sfd` with [FontForge](https://fontforge.org/en-US/) and save it in your operating system format.
 - MuseScore 4.x API is still not ufficially released ... this plugin might be broken/require modification at the moment you will read this note.
 - The plugin works with STAFF_TEXT elements:
   - firstly, it removes any STAFF_TEXT;
   - then adds STAFF_TEXTs (letters, e.g. C, d, K) for each CHORD based on pitch value;  
     the trick is that the font glyphs do not match with such letters, but with ocarina tabs!
   - finally, increases the minimum note distance to allow for proper spacing of ocarina tabs.
 - The "Ocarina" font follows this table:  
   | Letter | Glyph                                                                       | Note | 
   | :----: | :-------------------------------------------------------------------------: | :--: |
   | C      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina1.png)  | C    |
   | d      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina2.png)  | C#   |
   | D      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina3.png)  | D    |
   | e      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina4.png)  | D#   |
   | E      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina5.png)  | E    | 
   | F      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina6.png)  | F    |
   | g      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina7.png)  | F#   |
   | G      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina8.png)  | G    |
   | h      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina9.png)  | G#   |
   | H      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina10.png) | A    |
   | i      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina11.png) | A#   |
   | I      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina12.png) | B    |
   | J      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina13.png) | C    |
   | k      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina14.png) | C#   |
   | K      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina15.png) | D    |
   | l      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina16.png) | D#   |
   | L      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina17.png) | E    |
   | M      | ![](https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina18.png) | F    |
   
   Any gplyph in the font can be replaced (e.g. for 12 hole ocarinas) as long as letters and font name agree with the table values  
   ... or you might simply need to change the strings in the plugin code (.xml file)
 - The plugin works only with treble clefs and infers the type by the dimension and y position of the CLEF element.  
   (code-wise, not the best approach ... but the only workaround considering MuseScore current API)

## Acknowledgements

 - Firstly, thanks to [Fabio Menaglio](https://www.youtube.com/watch?v=ln7p4MG0EuQ) for his wondrous ocarinas.
 - Secondly, thanks to the MuseScore [Community](https://musescore.org/en/forum) and [Plugin Developers](https://musescore.org/en/plugins) for all the references and examples.
 - Finally, cheers to the open source software community!
