// 10-hole ocarina plugin for MuseScore 3.x 4.x
//
// Copyright (C) 2023  Luca Forniti
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import QtQuick 2.0
import QtQuick.Dialogs 1.2
import MuseScore 3.0

MuseScore {
      menuPath: "Plugins.Add 10-Hole Ocarina Tabs"
      description: "This plugin adds 10-holes ocarina tabs to the current score"
      version: "1.0"
      requiresScore: true
	
      // -----------------------------------------------------------------------------------------------------------
      //  UI Related Stuff
      // -----------------------------------------------------------------------------------------------------------
	
      MessageDialog {
            id: errorDialog
            visible: false
            title: qsTr("Error")
            text: "Error"
            modality: Qt.ApplicationModal
            onAccepted: {
                  return 0
            }
            function showDialog(message) {
                  text = message
                  open()
            }
      }
	
      MessageDialog {
            id: infoDialog
            visible: false
            title: qsTr("Info")
            text: "Info"
            modality: Qt.ApplicationModal
            onAccepted: {
                  return 0
            }
            function showDialog(message) {
                  text = message
                  open()
            }
      }
	
      // -----------------------------------------------------------------------------------------------------------
      //  UTILITY FUNCTIONS
      // -----------------------------------------------------------------------------------------------------------
	
      // Round floating point numbers
      // -----------------------------------------------------------------------------------------------------------
      function round(x, decimals) {            
            var order = Math.pow(10, decimals)
            return Math.floor(x*order)/order
      }
	
      // Check QRectF dimesions with expected values
      // -----------------------------------------------------------------------------------------------------------
      function isQRectF(rect, top, left, width, height, decimals) {            
            var top_check = round(rect.top, decimals) == round(top, decimals)
            var left_check = round(rect.left, decimals) == round(left, decimals)
            var height_check = round(rect.height, decimals) == round(height, decimals)
            var width_check = round(rect.width, decimals) == round(width, decimals)
            if (top_check && left_check && height_check && width_check) {
                  return true
            }
            return false
	}
	
      // Function to infer clef type
      // -----------------------------------------------------------------------------------------------------------
      // works only for treble clefs!
      // this function is a workaround since clef type is currently not exposed in MuseScore API 
      // based on dimensions of element bounding box and y position:
      //
      // MUSESCORE 3.x:
      //
      // | Treble Clef Symbol     | element.posY       | element.bbox                             |
      // | ---------------------- | ------------------ | ---------------------------------------- |
      // | treble clef            | 3.0000000000000004 | QRectF(-4.458125, 0, 2.559375, 7.119375) |
      // | treble clef 8va alta   | 3.0000000000000004 | QRectF(-5.345312, 0, 2.559375, 8.006563) |
      // | treble clef 15ma alta  | 3.0000000000000004 | QRectF(-5.358126, 0, 2.559062, 8.019375) |
      // | treble clef 8va bassa  | 3.0000000000000004 | QRectF(-4.458125, 0, 2.560313, 8.041875) |
      // | treble clef 15ma bassa | 3.0000000000000004 | QRectF(-4.458125, 0, 2.559375, 8.047188) |
      //
      // MUSESCORE 4.x:
      //
      // | Treble Clef Symbol     | element.posY       | element.bbox                             |
      // | ---------------------- | ------------------ | ---------------------------------------- |
      // | treble clef            | 3.0000000000000004 | QRectF(-4.439687, 0, 2.559687, 7.107812) |
      // | treble clef 8va alta   | 3.0000000000000004 | QRectF(-5.343750, 0, 2.559687, 8.011875) |
      // | treble clef 15ma alta  | 3.0000000000000004 | QRectF(-5.359688, 0, 2.559687, 8.027812) |
      // | treble clef 8va bassa  | 3.0000000000000004 | QRectF(-4.443750, 0, 2.559687, 8.043750) |
      // | treble clef 15ma bassa | 3.0000000000000004 | QRectF(-4.439687, 0, 2.559687, 8.039687) |
      //
      // for convenience, the return value is set to plus/minus the number of octaves with reference to treble clef
      // returns:
      // "undefined" for all remaining clef types
      // - treble clef            ->  0
      // - treble clef 8va alta   ->  1
      // - treble clef 15ma alta  ->  2
      // - treble clef 8va bassa  -> -1
      // - treble clef 15ma bassa -> -2
      // - any other type         -> "undefined"
      // -----------------------------------------------------------------------------------------------------------
      function getClefType(clef) { 
            if (Math.round(clef.posY) == 3) {
                  if (mscoreMajorVersion >= 4) {
                        if (isQRectF(clef.bbox, -4.439687, 0, 2.559687, 7.107812, 5)) {             
                              return 0
                        }
                        if (isQRectF(clef.bbox, -5.343750, 0, 2.559687, 8.011875, 5)) {        
                              return 1 
                        }
                        if (isQRectF(clef.bbox, -5.359688, 0, 2.559687, 8.027812, 5)) {
                              return 2
                        }
                        if (isQRectF(clef.bbox, -4.443750, 0, 2.559687, 8.043750, 5)) {      
                              return -1
                        }
                        if (isQRectF(clef.bbox, -4.439687, 0, 2.559687, 8.039687, 5)) {
                              return -2
                        }
                  } else {
                        if (isQRectF(clef.bbox, -4.458125, 0, 2.559375, 7.119375, 5)) {             
                              return 0
                        }
                        if (isQRectF(clef.bbox, -5.345312, 0, 2.559375, 8.006563, 5)) {        
                              return 1 
                        }
                        if (isQRectF(clef.bbox, -5.358126, 0, 2.559062, 8.019375, 5)) {
                              return 2
                        }
                        if (isQRectF(clef.bbox, -4.458125, 0, 2.560313, 8.041875, 5)) {      
                              return -1
                        }
                        if (isQRectF(clef.bbox, -4.458125, 0, 2.559375, 8.047188, 5)) {
                              return -2
                        }
                  }				  
            }
            return "undefined"
      }
	
      // Check if all clefs are supported
      // -----------------------------------------------------------------------------------------------------------
      // this plugin works only with the following treble clefs:
      // - treble clef
      // - treble clef 8va alta
      // - treble clef 15ma alta
      // - treble clef 8va bassa
      // - treble clef 15ma bassa
      // -----------------------------------------------------------------------------------------------------------
      function checkSupportedClefs(score) {
            var cursor = score.newCursor()
            cursor.filter = Segment.HeaderClef
            cursor.staffIdx = 0
            cursor.voice = 0
            cursor.rewind(0)
            while(cursor.segment) {
                  if (cursor.element && cursor.element.type == Element.CLEF) {
                        if (getClefType(cursor.element) == "undefined") {
                              return false
                        }
                  }
                  cursor.next()
            }
            return true
      }
	
      // Check if there is no mix between clefs
      // -----------------------------------------------------------------------------------------------------------
      function checkUniformClefs(score) {
            var cursor = score.newCursor()
            var first_clef = null
            cursor.filter = Segment.HeaderClef
            cursor.staffIdx = 0
            cursor.voice = 0
            cursor.rewind(0)
            while(cursor.segment) {
                  if (cursor.element && cursor.element.type == Element.CLEF) {
                        if (first_clef == null) {
                              first_clef = getClefType(cursor.element)
                        } else {				
                              if (getClefType(cursor.element) != first_clef) {
                                    return false
                              }
                        }
                  }
                  cursor.next()
            }
            return true
      }
	
      // Get clef type of current note
      // -----------------------------------------------------------------------------------------------------------
      function getCurrentClefType(note) {
            var measure = note.parent.parent.parent
            var segment = measure.firstSegment
            while (segment) {
                  if (segment.elementAt(0).type == Element.CLEF) {
                        return getClefType(segment.elementAt(0))
                  }
                  segment = segment.prev
            }
            return "undefined"
      }
	
      // Note to ocarina glyph conversion
      // -----------------------------------------------------------------------------------------------------------
      function pitchToText(note) {
            var clefModifier = getCurrentClefType(note)
            var notePitch = note.pitch
            var text
            if (clefModifier == "undefined") {
                  text =  ""
            } else {
                  switch(notePitch) {
                        case 60 + 12*clefModifier: text = "C"; break;
			case 61 + 12*clefModifier: text = "d"; break;
			case 62 + 12*clefModifier: text = "D"; break;
			case 63 + 12*clefModifier: text = "e"; break;
			case 64 + 12*clefModifier: text = "E"; break;
			case 65 + 12*clefModifier: text = "F"; break;
			case 66 + 12*clefModifier: text = "g"; break;
			case 67 + 12*clefModifier: text = "G"; break;
			case 68 + 12*clefModifier: text = "h"; break;
			case 69 + 12*clefModifier: text = "H"; break;
			case 70 + 12*clefModifier: text = "i"; break;
			case 71 + 12*clefModifier: text = "I"; break;
			case 72 + 12*clefModifier: text = "J"; break;
			case 73 + 12*clefModifier: text = "k"; break;
			case 74 + 12*clefModifier: text = "K"; break;
			case 75 + 12*clefModifier: text = "l"; break;
			case 76 + 12*clefModifier: text = "L"; break;
			case 77 + 12*clefModifier: text = "M"; break;
			default: text = ""; 
                  }
            }
            return text
      }
	 
      // Remove All Staff Texts
      // -----------------------------------------------------------------------------------------------------------
      function removeAllStaffTexts(score) {
            var cursor = score.newCursor()
            cursor.staffIdx = 0
            cursor.voice = 0
            cursor.rewind(0)		
            console.log("10 hole ocarina tabs >> removing any previous annotation")
            while(cursor.segment) {
                  for (var n = 0; n < cursor.segment.annotations.length; n++){
                        var annotation = cursor.segment.annotations[n]
                        if (mscoreMajorVersion >= 4) {
                              curScore.startCmd()
                        }
                        removeElement(annotation)
                        if (mscoreMajorVersion >= 4) {
                              curScore.endCmd()
                        }
                  }                
                  cursor.next()
            }
      }
	
      // Tabbing Function
      // -----------------------------------------------------------------------------------------------------------
      function addOcarinaTabs(score) {
            var cursor = score.newCursor()
            cursor.staffIdx = 0
            cursor.voice = 0
            cursor.rewind(0)		
            console.log("10 hole ocarina tabs >> adding tabs")
            while(cursor.segment) {
                  if (cursor.element && cursor.element.type == Element.CHORD) {
                        var staff_text = newElement(Element.STAFF_TEXT)
                        staff_text.text = pitchToText(cursor.element.notes[0])
                        staff_text.autoplace = false
                        staff_text.offset = Qt.point(-2, 13)
                        staff_text.fontFace = "Ocarina"
                        staff_text.fontSize = 40
                        if (mscoreMajorVersion >= 4) {
                              curScore.startCmd()
                        }
                        cursor.add(staff_text)
                        if (mscoreMajorVersion >= 4) {
                              curScore.endCmd()
                        }                
                  }                  
                  cursor.next()
            }
      }

      // Score Style Function
      // -----------------------------------------------------------------------------------------------------------
      function applyOcarinaStyle(score) {
            console.log("10 hole ocarina tabs >> applying ocarina style")
            var style = curScore.style
            var minNoteDistance = style.value("minNoteDistance")
            if (mscoreMajorVersion >= 4) {
                  if (minNoteDistance < 3.5) {
                        style.setValue("minNoteDistance", 3.5);
                  }
            } else {
                  if (minNoteDistance < 8) {
                        style.setValue("minNoteDistance", 8);
                  }
            }
      }
	 
      // -----------------------------------------------------------------------------------------------------------
      //  PLUGIN IMPLEMENTATION
      // -----------------------------------------------------------------------------------------------------------
	
      // MuseScore4 attributes
      // -----------------------------------------------------------------------------------------------------------
      Component.onCompleted: {
            if (mscoreMajorVersion >= 4) {
                  title = qsTr("Add 10 Hole Ocarina Tabs")
                  thumbnailName = "logo_ocarina.png"
                  categoryCode = "composing-arranging-tools"
            }
      }
	
      // On Run
      // -----------------------------------------------------------------------------------------------------------
      onRun: {
            // preliminary checks:
            // - if not in a score, quit:
            if (typeof curScore === "undefined") {
                  errorDialog.showDialog(qsTr("Please open a score to add ocarina tabs!"))
                  console.log("10 hole ocarina tabs >> undefined score");
                  (typeof(quit) === 'undefined' ? Qt.quit : quit)()
            }        
            // - if not all clefs are supported, quit:
            if (!checkSupportedClefs(curScore)) {
                  errorDialog.showDialog(qsTr("Found unsupported clef type"))
                  console.log("10 hole ocarina tabs >> undefined clef type");
                  (typeof(quit) === 'undefined' ? Qt.quit : quit)()
            }
            // - if not all clefs are the same, quit:
            if (!checkUniformClefs(curScore)) {
                  errorDialog.showDialog(qsTr("Found different treble clefs in the same score"))
                  console.log("10 hole ocarina tabs >> mixed clef types");
                  (typeof(quit) === 'undefined' ? Qt.quit : quit)()
            }		
            // clear any existing STAFF_TEXT
            removeAllStaffTexts(curScore)
            // give proper space to each measure
            applyOcarinaStyle(curScore)
            // add tabs
            addOcarinaTabs(curScore)		
            // exiting
            console.log("10 hole ocarina tabs >> done");
            (typeof(quit) === 'undefined' ? Qt.quit : quit)()
      }
}
