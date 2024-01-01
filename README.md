# 10 Hole Ocarina Plugin for MuseScore


Add 10 hole ocarina tabs to your favourite score ... or at least try :smile:

!()[https://github.com/Darkral/ocarina-tabs/blob/main/images/example.png]

The score must be/have:

- treble clef, uniform along the track
- single-track
- single-staff
- single-voice
- single-note per stem

... no guarantee it will work with complex scores!

**NB:** This plugin is still in development, currently it has been tested on Windows and with MuseScore 3.6.2 and 4.2.0


## License

[GNU GPL v3](https://www.gnu.org/licenses/licenses.html.en)


## Installation

**TL;DR:** You will need **(1)** to copy the plugin folder `10holeocarinatabs` into the MuseScore plugin folder and **(2)** install the font with ocarina gplyphs/tabs.

MuseScore plugin folder is typically at:
 - **Windows:** `%HOMEPATH%\Documents\MuseScore3\Plugins`
 - **macOS:** `~/Documents/MuseScore3/Plugins`
 - **Linux:** `~/Documents/MuseScore3/Plugins`

**NB:** change `MuseScore3` with `MuseScore4` depending on your version.

Start by either:
- if you have (git)[https://git-scm.com/] installed, clone this repo in your MuseScore plugin folder:
  ```
  cd "path/to/MuseScore/plugin-folder"
  git clone https://github.com/Darkral/ocarina-tabs.git
  ```
- or download the folder `https://github.com/Darkral/ocarina-tabs/tree/main/10holeocarinatabs` through the site (download-directory.github.io)[https://download-directory.github.io/] as .zip file and extract into the MuseScore plugin folder 

Finally, you can find "Ocarina" font in `10holeocarinatabs/font` folder; if you are on Windows, double click on `Ocarina.ttf` and follow the installation procedure.

    
<!-- ## Demo

Insert gif or link to demo -->


## Notes for the Braves

 - The plugin itself (.qml file) should be working also on macOS and Linux. You might have only to work on the font, if your operating system complains about .ttf fonts. Edit `10h_ocarina_glyphs.sfd` with (FontForge)[https://fontforge.org/en-US/] and save it in your operating system format.
 - MuseScore 4.x API is still not ufficially released ... this plugin might be broken/require modification at the moment you will read this note.
 - The plugin works with STAFF_TEXT elements:
   - firstly, it removes any STAFF_TEXT;
   - then adds STAFF_TEXTs (letters, e.g. C, d, K) for each CHORD based on pitch value;  
     the trick is that the font gplyphs do not match with such letters, but with ocarina tabs!
   - finally, increases the minimum note distance to allow for proper spacing of ocarina tabs.
 - The "Ocarina" font follows this table:  
   | Letter | Glyph                                                                        | Note | 
   | :----: | :--------------------------------------------------------------------------: | :--: |
   | C      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_1.png]  | C    |
   | d      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_2.png]  | C#   |
   | D      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_3.png]  | D    |
   | e      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_4.png]  | D#   |
   | E      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_5.png]  | E    | 
   | F      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_6.png]  | F    |
   | g      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_7.png]  | F#   |
   | G      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_8.png]  | G    |
   | h      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_9.png]  | G#   |
   | H      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_10.png] | A    |
   | i      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_11.png] | A#   |
   | I      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_12.png] | B    |
   | J      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_13.png] | C    |
   | k      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_14.png] | C#   |
   | K      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_15.png] | D    |
   | l      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_16.png] | D#   |
   | L      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_17.png] | E    |
   | M      | !()[https://github.com/Darkral/ocarina-tabs/blob/main/images/ocarina_18.png] | F    |
   
   Any gplyph in the font can be replaced (e.g. for 12 hole ocarinas) as long as letters and font name agree with the table values  
   ... or you might simply need to change the strings in the plugin code (.xml file)
 - The plugin works only with treble clefs and infers the type by the dimension and y position of the CLEF element.  
   (code-wise, not the best approach ... but the only workaround considering MuseScore current API)

## Acknowledgements

 - Firstly, thanks to (Fabio Menaglio)[https://www.youtube.com/watch?v=ln7p4MG0EuQ] for his wondrous ocarinas.
 - Secondly, thanks to the MuseScore (community)[https://musescore.org/en/forum] and (plugin developers)[https://musescore.org/en/plugins] for all the references and examples.
 - Finally, cheers to the open source software community!
