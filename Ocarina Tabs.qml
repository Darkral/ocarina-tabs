import QtQuick 2.0
import MuseScore 3.0

MuseScore {
      menuPath: "Plugins.Ocarina Tabs"
      description: "This plugin adds 10-holes ocarina tabs to the current score"
      version: "1.0"
      onRun: {
            // if not in a score, quit
            if(typeof curScore === "undefined") {
                  console.log("Ocarina Tabs: undefined score");
                  Qt.quit()
            }
            // define function to get text from pitch            
            var pitch_to_text;
            pitch_to_text = function(pitch) {
                  var text
                  switch(pitch) {
                        case 60: text = "C"; break;
                        case 61: text = "d"; break;
                        case 62: text = "D"; break;
                        case 63: text = "e"; break;
                        case 64: text = "E"; break;
                        case 65: text = "F"; break;
                        case 66: text = "g"; break;
                        case 67: text = "G"; break;
                        case 68: text = "h"; break;
                        case 69: text = "H"; break;
                        case 70: text = "i"; break;
                        case 71: text = "I"; break;
                        case 72: text = "J"; break;
                        case 73: text = "k"; break;
                        case 74: text = "K"; break;
                        case 75: text = "l"; break;
                        case 76: text = "L"; break;
                        case 77: text = "M"; break;
                        default: ""; 
                  }
                  return text
            };
            // create a new cursor
            var cursor = curScore.newCursor()
            cursor.staffIdx = 0
            cursor.voice = 0
            cursor.rewind(0)
            // clear any existing STAFF_TEXT
            console.log("Ocarina Tabs: removing any previous annotation")
            while(cursor.segment) {
                  for (var n = 0; n < cursor.segment.annotations.length; n++){
                        var annotation = cursor.segment.annotations[n]
                        removeElement(annotation)
                  }                
                  cursor.next()
            }
            // start tabbing procedure
            cursor.rewind(0)
            console.log("Ocarina Tabs: doing magic ...")
            while(cursor.segment) {
                  if (cursor.element && cursor.element.type == Element.CHORD) {
                        var staff_text = newElement(Element.STAFF_TEXT)
                        staff_text.text = pitch_to_text(cursor.element.notes[0].pitch)
                        staff_text.autoplace = false
                        staff_text.offset = Qt.point(-2, 13)
                        staff_text.fontFace = "Ocarina"
                        staff_text.fontSize = 40
                        cursor.add(staff_text)                        
                  }                  
                  cursor.next()
            }
            // exiting
            console.log("Ocarina Tabs: added tabs for 10-hole ocarina!");
            Qt.quit();
            }
      }
