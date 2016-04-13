import QtQuick 2.4
import Ubuntu.Components 1.3

/*!
 *  \brief MainView with Tabs element.
 *         First Tab has a single Label and
 *         second Tab has a single ToolbarAction.
 */

MainView {
  id                    : main_view;
  // objectName for functional testing purposes (autopilot-qt5)
  objectName            : "main_view";

  // Note! applicationName needs to match the "name" field of click manifest
  applicationName       : "cookingcalc.jaft";

  /*
   *  This property enables the application to change orientation
   *  when the device is rotated. The default is false.
   */
  //automaticOrientation: true;


  width                 : units.gu(100);
  height                : units.gu(75);

  property var temps: { "Fahrenheit": { "Fahrenheit": function(f) {
					                return f;
						      },
					"Celsius"   : function(f) {
				                        return (f - 32) *
							       5 / 9;
				                        },
					"Kelvin"    : function(f) {
				                        return (f + 459.67) *
							       5 / 9;
				                      } },
			"Celsius"   : { "Fahrenheit": function(c) {
				                        return (c * 1.8) + 32;
				                      },
					"Celsius"   : function(c) {
					                return c;
					              },
					"Kelvin"    : function(c) {
				                        return c + 273.15;
				                      } },
			"Kelvin"    : { "Fahrenheit": function(k) {
				                        return (k * 9 / 5) -
							       459.67;
				                      },
					"Celsius"   : function(k) {
				                        return k - 273.15;
				                      },
					"Kelvin"    : function(k) {
					                return k;
					              } } };
  property var vols: { 1: "one", 2: "two" };

  property var current_table: { 1: "one", 2: "two" };

  function convert() {
    var fin  = input_from.text;
    var fin2 = Number(parseFloat(fin));

    if(!(fin2 == fin)) {
      result_to.text = "";
    } else {
      result_to.text =
        current_table[selector_from.model[selector_from.selectedIndex]]
                     [  selector_to.model[  selector_to.selectedIndex]](fin2);
    }
  }

  function changeSelectorModels() {
    var k = Object.keys(current_table);
    selector_from.model = k;
    selector_to.model = k;
  }

  PageHeader {
    title    : i18n.tr("Cooking Calculator");
    extension: Sections {
                 actions: [Action {
			     text: "Volumes";
			   },
			   Action {
			     text: "Temperatures";
			     onTriggered: {
			       current_table = temps;
			       changeSelectorModels();
			     }
			   },
			   Action {
			     text: "Something";
			   }]

		 anchors {
		   left      : parent.left;
		   leftMargin: units.gu(2);
		   bottom    : parent.bottom;
		 }
               }

    Column {
      id     : col;
      spacing: units.gu(1);

      anchors {
        margins: units.gu(2);
	top    : parent.bottom;
	left   : parent.left;
	right  : parent.right;
      }

      OptionSelector {
	id                    : selector_from;
	objectName            : "selector_from";
	text                  : "Initial Value";
	width                 : parent.width;
	model                 : ["Value 1", "Value 2", "Value 3", "Value 4"];
	onSelectedIndexChanged: convert();
      }

      TextField {
	id              : input_from;
	objectName      : "input_from";
	errorHighlight  : false;
	validator       : DoubleValidator {
	                    notation: DoubleValidator.StandardNotation;
	                  }
	height          : units.gu(5);
	width           : parent.width;
	font.pixelSize  : FontUtils.sizeToPixels("medium");
	inputMethodHints: Qt.ImhFormattedNumbersOnly;
	text            : '0.0';
	onTextChanged   : convert();
      }

      OptionSelector {
	id                    : selector_to;
	objectName            : "selector_to";
	text                  : "\n\nResulting Value";
	width                 : parent.width;
	model                 : ["Value 1", "Value 2", "Value 3", "Value 4"];
	onSelectedIndexChanged: convert();
      }
    }

    Rectangle {
      id    : result;
      color : UbuntuColors.silk;
      height: result_to.height * 1.3;
      width : parent.width;

      anchors {
    	left     : parent.left;
    	top      : col.bottom;
    	topMargin: units.gu(1);
      }

      Label {
    	id  : result_to;
    	text: '0';

	anchors {
    	  verticalCenter: parent.verticalCenter;
	  leftMargin    : units.gu(3);
	  left          : parent.left;
	}
      }
    }

    Button {
      text     : i18n.tr("Make Result the Initial Value");
      width    : parent.width - 2 * units.gu(2);
      height   : units.gu(5);
      color    : UbuntuColors.red;
      onClicked: input_from.text = Number(parseFloat(result_to.text));

      anchors {
	topMargin   : units.gu(6);
	leftMargin  : units.gu(2);
	rightMargin : units.gu(2);
	top         : result.bottom;
	left        : parent.left;
      }
    }
  }
}

