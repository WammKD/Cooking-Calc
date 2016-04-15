import QtQuick 2.4
import Ubuntu.Components 1.3
import "fraction.js" as Fraction

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
  property var vols:    { "Tablespoons (U. S.)"    : 1,
			  "Teaspoons"              : 1 / 3,
			  "Cups"                   : 16,
			  "Fluid Ounces"           : 2,
			  "Pinches"                : 1 / 24,
			  "Pints (liquid, U. S.)"  : 32,
			  "Pints (dry, U. S.)"     : 74.473419913 / 2,
			  "Quarts (liquid, U. S.)" : 64,
			  "Quarts (dry, U. S.)"    : 74.473419913,
			  "Gallons (liquid, U. S.)": 256,
			  "Gallons (dry, U. S.)"   : 74.473419913 * 4,
			  "Liter"                  : 67.6280454,
			  "Drops"                  : 1 / 180,
			  "Dashes"                 : 1 / 48,
			  "Gill"                   : 8,
			  "Firkin"                 : 2304,
			  "Hogshead"               : 16128,
			  "Peck"                   : 74.473419913 * 8,
			  "Bushel"                 : 74.473419913 * 32,
			  "Cubic Inches"           : 59136 };
  // All grams equal to 1 Tbs.
  property var foods:   { "Alcohol (ethyl)"               : 11.608497559168,
			  "Alcohol (methyl)"              : 11.629938368101,
			  "Alcohol (propyl)"              : 11.828820354409,
			  "Almonds (flaked)"              : 85 / 16,
			  "Almonds (ground)"              : 100 / 16,
			  "Baking Powder"                 : 13 + 4 / 5,
			  "Baking Soda"                   : 13 + 4 / 5,
			  "Beans (kidney)"                : 12 + 1 / 5,
			  "Blackberries"                  : 9.15,
			  "Blueberries"                   : 9.45,
			  "Bread Crumbs"                  : 120.000000254 / 16,
			  "Buckwheat Groats"              : 10 + 5 / 8,
			  "Butter"                        : 14.175,
			  "Cacao"                         : 7.375,
			  "Cheese (grated Parmesan)"      : 5,
			  "Cheese (grated Cheddar)"       : 10,
			  "Chickpeas"                     : 12.500000027,
			  "Cinnamon"                      : 7.800000017,
			  "Coconut (shredded, disiccated)": 5.8125,
			  "Coffee (ground)"               : 0.6625 };
  property var weights: { "Grams"             : 1,
			  "Ounces"            : 28.349523124662777,
			  "Pounds"            : 453.5923700100354,
			  "Kilogram"          : 1000,
			  "Milligrams"        : 0.001,
			  "Tonnes"            : 1000000,
			  "Short Tons (U. S.)": 907184.9958859162,
			  "Long Tons (U. K.)" : 1016046.9373043159,
			  "Stones"            : 6350.294971201412,
			  "Micrograms"        : 1e-06 };

  property var current_table: vols;

  property var fraction: Fraction["Fraction"];

  function textAccumulation(t, f, o) {
    var weight = weights[s_m.model[s_m.selectedIndex]];

    return (!(f == o) ?  // This is horrid; clean up.
	    "" : (weight ? f * weight / foods[s_p.model[s_p.selectedIndex]] /
		           current_table[t] :
			   (current_table == temps ?
			    temps[s_m.model[s_m.selectedIndex]][t](f) :
			    f * current_table[s_m.model[s_m.selectedIndex]] /
			    current_table[t])));
  }
  function textAccumulation2(t, f, o, e) {
    return values2.text + (!(f == o) ?
			   "" : textAccumulation("Tablespoons (U. S.)", f, o) *
                                foods[s_p.model[s_p.selectedIndex]] /
				weights[t]) + e;
  }

  function convert() {
    var orig     = input.text;
    var fin      = Number(parseFloat(orig));
    values.text  = "";
    values2.text = "";
    var end      = " \n";

    for(var tex in current_table) {
      values.text = values.text + textAccumulation(tex, fin, orig) + end;
    }

    for(var p in weights) {
      values2.text = textAccumulation2(p, fin, orig, end);
    }
  }

  function initializePage() {
    s_m.model         = Object.keys(current_table);
    if(current_table == vols) {
      s_m.model = s_m.model.concat(Object.keys(weights)).sort();
    }
    s_p.model          = Object.keys(foods);
    var orig           = input.text;
    var fin            = Number(parseFloat(orig));
    var end            = " \n"
    values.text        = "";
    values2.text       = "";
    measurements.text  = "";
    measurements2.text = "";
    
    for(var k in current_table) {
      values.text       = values.text + textAccumulation(k, fin, orig) + end;
      measurements.text = measurements.text + k + end;
    }

    for(var p in weights) {
      values2.text       = textAccumulation2(p, fin, orig, end);
      measurements2.text = measurements2.text + p + end;
    }
  }

  PageHeader {
    title    : i18n.tr("Cooking Calculator");
    extension: Sections {
                 id     : sects;
                 actions: [Action {
			     text       : i18n.tr("Products");
			     onTriggered: {
			       s_p.visible = true;
			       weight_title.visible = true;
			       weight_row.visible = true;
			       current_table = vols;
			       initializePage();
			     }
			   },
			   Action {
			     text       : i18n.tr("Temperatures");
			     onTriggered: {
			       s_p.visible = false;
			       weight_title.visible = false;
			       weight_row.visible = false;
			       current_table = temps;
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
	  model                 : [];
	  onSelectedIndexChanged: convert();
        }

        OptionSelector {
	  id                    : s_m;  // because it's long, otherwise
	  objectName            : "selector_measurement";
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
	  id       : weight_title;
	  text     : i18n.tr("Weight");
	  color    : UbuntuColors.purple;
	  font.bold: true;
	  fontSize : "Large";
	}

	Row {
	  id     : weight_row;

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