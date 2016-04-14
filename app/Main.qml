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

  function convert() {
    var orig = input.text;
    var fin  = Number(parseFloat(orig));
    values.text    = "";
    var end  = " \n";

    for(var t in current_table) {
      values.text = values.text +
                    (!(fin == orig) ?
		     "" : (current_table == temps ?
			   temps[s_m.model[s_m.selectedIndex]][t](fin) :
			   fin * current_table[s_m.model[s_m.selectedIndex]] /
		                 current_table[t])) + end;
    }
  }

  function initializePage() {
    s_m.model = Object.keys(current_table);
    var v = "";
    var m = "";
    
    for(var k in current_table) {
      v = v + "0 \n";
      m = m + k + "\n";
    }

    values.text = v;
    measurements.text = m;
  }

  PageHeader {
    title    : i18n.tr("Cooking Calculator");
    extension: Sections {
                 id     : sects;
                 actions: [Action {
			     text       : i18n.tr("Products");
			     onTriggered: {
			       current_table = vols;
			       s_p.visible = true;
			       mass_title.visible = false;
			       mass_row.visible = false;
			       initializePage();
			     }
			   },
			   Action {
			     text       : i18n.tr("Temperatures");
			     onTriggered: {
			       current_table = temps;
			       s_p.visible = false;
			       mass_title.visible = true;
			       mass_row.visible = true;
			       initializePage();
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

    ScrollView {
      height: main_view.height - (parent.height + sects.height);

      anchors {
        margins: units.gu(2);
	top    : parent.bottom;
	left   : parent.left;
	right  : parent.right;
      }

      Column {
	objectName: "products";
	spacing   : units.gu(1);

	OptionSelector {
	  id                    : s_p;  // because it's long, otherwise
	  objectName            : "selector_product";
	  width                 : main_view.width - units.gu(2) * 2;
	  containerHeight       : itemHeight * 4;
	  model                 : ["Shit", "Fuck", "Damn"];
	  onSelectedIndexChanged: ;
        }

        OptionSelector {
	  id                    : s_m;  // because it's long, otherwise
	  objectName            : "selector_measurement";
	  /* text                  : i18n.tr("Measurement"); */
	  width                 : main_view.width - units.gu(2) * 2;
	  containerHeight       : itemHeight * 4;
	  model                 : [];
	  onSelectedIndexChanged: convert();
	}

	TextField {
	  id              : input;
	  objectName      : "input";
	  errorHighlight  : false;
	  validator       : DoubleValidator {
	                      notation: DoubleValidator.StandardNotation;
	                    }
	  height          : units.gu(5);
	  width           : main_view.width - units.gu(2) * 2;
	  font.pixelSize  : FontUtils.sizeToPixels("medium");
	  inputMethodHints: Qt.ImhFormattedNumbersOnly;
	  text            : '0.0';
	  onTextChanged   : convert();
	}

	Label {
	  text     : i18n.tr("\nVolume");
	  color    : UbuntuColors.purple;
	  font.bold: true;
	  fontSize : "Large";
	}

	Row {
	  Label {
	    id            : values;
	    text          : "Place";
	    lineHeight    : units.gu(3);
	    lineHeightMode: Text.FixedHeight;
	  }

	  Label {
	    id            : measurements;
	    text          : "Holder";
	    font.bold     : true;
	    lineHeight    : units.gu(3);
	    lineHeightMode: Text.FixedHeight;
	  }
	}

	Label {
	  id       : mass_title;
	  text     : i18n.tr("Mass");
	  color    : UbuntuColors.purple;
	  font.bold: true;
	  fontSize : "Large";
	}

	Row {
	  id: mass_row;

	  Label {
	    id            : values2;
	    text          : "Place";
	    lineHeight    : units.gu(3);
	    lineHeightMode: Text.FixedHeight;
	  }

	  Label {
	    id            : measurements2;
	    text          : "Holder";
	    font.bold     : true;
	    lineHeight    : units.gu(3);
	    lineHeightMode: Text.FixedHeight;
	  }
	}
      }
    }
  }
}