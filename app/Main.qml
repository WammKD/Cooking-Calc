import QtQuick 2.4
import Ubuntu.Components 1.3

/*!
 *  \brief MainView with Tabs element.
 *         First Tab has a single Label and
 *         second Tab has a single ToolbarAction.
 */

MainView {
  id             : main_view;
  // objectName for functional testing purposes (autopilot-qt5)
  objectName     : "main_view";

  // Note! applicationName needs to match the "name" field of click manifest
  applicationName: "cookingcalculator.jaft";

  /*
   *  This property enables the application to change orientation
   *  when the device is rotated. The default is false.
   */
  //automaticOrientation: true;


  width          : units.gu(100);
  height         : units.gu(75);

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
  property var vols: { "Tablespoons" : 1,
		       "Teaspoons"   : 1 / 3,
		       "Cups"        : 16,
		       "Fluid Ounces": 2,
		       "Pinches"     : 1 / 24,
		       "Pints"       : 32,
		       "Quarts"      : 64,
		       "Gallons"     : 256,
		       "Drops"       : 1 / 180,
		       "Dashes"      : 1 / 48 };

  property var current_table: vols;

  PageHeader {
    title    : i18n.tr("Cooking Calculator");
    extension: Sections {
                 actions: [Action {
			     text       : i18n.tr("Products");
			     onTriggered: {
			     }
			   },
			   Action {
			     text       : i18n.tr("Temperatures");
			     onTriggered: {
			     }
			   },
			   Action {
			     text       : i18n.tr("Guides");
			     onTriggered: {
			     }
			   }]

		 anchors {
		   left      : parent.left;
		   leftMargin: units.gu(2);
		   bottom    : parent.bottom;
		 }
               }

    Column {
      id        : products;
      objectName: "products";
      spacing   : units.gu(1);

      anchors {
        margins: units.gu(2);
	top    : parent.bottom;
	left   : parent.left;
	right  : parent.right;
      }

      OptionSelector {
	id                    : selector_product;
	objectName            : "selector_product";
	/* text                  : i18n.tr("Product"); */
	width                 : parent.width;
	containerHeight       : itemHeight * 4;
	model                 : ["Shit", "Fuck", "Damn"];
	onSelectedIndexChanged: ;
      }

      OptionSelector {
	id                    : selector_measurement;
	objectName            : "selector_measurement";
	/* text                  : i18n.tr("Measurement"); */
	width                 : parent.width;
	containerHeight       : itemHeight * 4;
	model                 : ["Shit", "Fuck", "Damn"];
	onSelectedIndexChanged: ;
      }

      /* Label { */
      /* 	text: i18n.tr("Amount\n"); */
      /* } */

      TextField {
	id              : input;
	objectName      : "input";
	errorHighlight  : false;
	validator       : DoubleValidator {
	                    notation: DoubleValidator.StandardNotation;
	                  }
	height          : units.gu(5);
	width           : parent.width;
	font.pixelSize  : FontUtils.sizeToPixels("medium");
	inputMethodHints: Qt.ImhFormattedNumbersOnly;
	text            : '0.0';
	onTextChanged   : ;
      }

      Label {
	text     : i18n.tr("\nVolume");
	color    : UbuntuColors.purple;
	font.bold: true;
	fontSize : "Large";
      }

      Label {
	text          : "This <b>is</b> just a text;\nHell yeah!";
	lineHeight    : units.gu(3);
	lineHeightMode: Text.FixedHeight;
      }

      Label {
	text     : i18n.tr("\nMass");
	color    : UbuntuColors.purple;
	font.bold: true;
	fontSize : "Large";
      }

      Label {
	text: "Fuck!\nShit!";
	lineHeight    : units.gu(3);
	lineHeightMode: Text.FixedHeight;
      }
    }
  }
}

