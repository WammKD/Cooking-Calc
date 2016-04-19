import "fraction.js" as Fraction
import QtQuick 2.4
import QtQuick.LocalStorage 2.0
import Ubuntu.Components 1.3

/*!
 *  \brief MainView with Tabs element.
 *         First Tab has a single Label and
 *         second Tab has a single ToolbarAction.
 */

MainView {
  id                 : main_view;
  // objectName for functional testing purposes (autopilot-qt5)
  objectName         : "main_view";

  // Note! applicationName needs to match the "name" field of click manifest
  applicationName    : "cookingcalculator.jaft";

  /*
   *  This property enables the application to change orientation
   *  when the device is rotated. The default is false.
   */
  //automaticOrientation: true;


  width              : units.gu(100);
  height             : units.gu(75);
  property real margs: units.gu(2);

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
			  "Teaspoons (U. S.)"      : 1 / 3,
			  "Cups"                   : 16,
			  "Fluid Ounces (U. S.)"   : 2,
			  "Pinches"                : 1 / 24,
			  "Pints (liquid, U. S.)"  : 32,
			  "Pints (dry, U. S.)"     : 74.473419913 / 2,
			  "Quarts (liquid, U. S.)" : 64,
			  "Quarts (dry, U. S.)"    : 74.473419913,
			  "Gallons (liquid, U. S.)": 256,
			  "Gallons (dry, U. S.)"   : 74.473419913 * 4,
			  "Liters"                 : 67.6280454,
			  "Drops"                  : 1 / 180,
			  "Dashes"                 : 1 / 48,
			  "Gill"                   : 8,
			  "Firkins (U. S.)"        : 2304/* 2271.2470704 */,  
			  "Firkins (U. K., beer)"  : 2766.98977104,
			  "Hogshead"               : 16128,
			  "Pecks (U. S.)"          : 74.473419913 * 8,
			  "Bushels (U. S.)"        : 74.473419913 * 32,
			  "Cubic Inches (U. S.)"   : 1.108225108,
			  "Jiggers"                : 2.95735296875,
			  "Tablespoons (U. K.)"    : 1.200397806,
			  "Teaspoons (U. K.)"      : 0.400316807,
			  "Tablespoons (metric)"   : 1.0144207,
			  "Teaspoons (metric)"     : 0.33814023 };
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
			  "Coffee (ground)"               : 0.6625,
			  "Cottage Cheese"                : 20,
			  "Cranberries (dried)"           : 7.5,
			  "Cranberries (fresh or frozen)" : 6.1875,
			  "Cream"                         : 15,
			  "Flour (corn)"                  : 9.375,
			  "Flour (potato)"                : 10,
			  "Flour (soy)"                   : 5.25,
			  "Flour (all-purpose)"           : 7.8125,
			  "Flour (whole wheat)"           : 8.09986375,
			  "Flour (wholemeal)"             : 8.09986375,
			  "Gelatin"                       : 9.25,
			  "Hazelnuts (finely chopped)"    : 13.75,
			  "Honey"                         : 21.25,
			  "Jam"                           : 20.3125,
			  "Ketchup (Catsup)"              : 17.000000036,
			  "Lard"                          : 12.8125,
			  "Lentil (boiled)"               : 12.375000026,
			  "Lentil (dry/pink or red, raw)" : 12.000000025,
			  "Lentil (sprouted, raw)"        : 4.81250001,
			  "Flaxseed (Linseed, ground)"    : 6.6,
			  "Flaxseed (Linseed, whole)"     : 14.02,
			  "Margarine"                     : 13.5625,
			  "Mayonnaise"                    : 15,
			  "Milk"                          : 15,
			  "Milk (granulated)"             : 4.2,
			  "Milk (powdered)"               : 8.25,
			  "Oatmeal (old fashioned/rolled)": 5.625,
			  "Oatmeal (steel cut)"           : 9.75,
			  "Oatmeal (steel cut)"           : 9.75,
			  "Oil (cottonseed)"              : 13.6,
			  "Oil (flaxseed)"                : 13.6,
			  "Oil (olive)"                   : 13.5,
			  "Oil (peanut)"                  : 13.5,
			  "Oil (sesame)"                  : 13.6,
			  "Oil (soybean)"                 : 13.6,
			  "Oil (vegetable: avocado)"      : 13.958705953,
			  "Oil (vegetable: canola)"       : 13.958705953,
			  "Oil (vegetable: most)"         : 13.6,
			  "Oil (vegetable: mustard)"      : 13.958705953,
			  "Oil (vegetable: sunflower)"    : 13.958705953,
			  "Oil (wheat germ)"              : 13.6,
			  "Paprika (ground)"              : 6.800000014,
			  "Peas (green, frozen)"          : 8.375000018,
			  "Pepper (black, ground)"        : 6.900000015,
			  "Poppy Seeds"                   : 8.795167692,
			  "Pumpkin Seeds"                 : 8.625,
			  "Raisin"                        : 9.06,
			  "Rice (brown)"                  : 12.05,
			  "Rice (white)"                  : 11.73,
			  "Salt"                          : 17.0625,
			  "Semolina"                      : 10.4375,
			  "Sesame Seeds"                  : 8.000000017,
			  "Sugar (granulated)"            : 12.5,
			  "Sugar (icing)"                 : 7.8125,
			  "Sunflower Seeds (dry roasted)" : 8.000000017,
			  "Sunflower Seeds (toasted)"     : 8.375000018,
			  "Vanilla Extract"               : 13.000000028,
			  "Vanilla Sugar"                 : 12.685714286,
			  "Vinegar (balsamic)"            : 15.937500034,
			  "Vinegar (cider)"               : 14.937500032,
			  "Vinegar (distilled)"           : 14.875000032,
			  "Vinegar (red wine)"            : 14.937500032,
			  "Walnuts (chopped)"             : 7.3125,
			  "Water"                         : 14.7867648 };
  property var weights: { "Grams"                        : 1,
			  "Ounces"                       : 28.349523124662777,
			  "Pounds"                       : 453.5923700100354,
			  "Kilogram"                     : 1000,
			  "Milligrams"                   : 0.001,
			  "Tonnes"                       : 1000000,
			  "Short Tons (U. S.)"           : 907184.9958859162,
			  "Long Tons (U. K.)"            : 1016046.9373043159,
			  "Stones"                       : 6350.294971201412,
			  "Micrograms"                   : 1e-06,
			  "Firkin (U. K., butter/cheese)": 25401.1727200000023,
			};

  property var current_table   : vols;

  function openDB() {
    // var dB = LocalStorage.openDatabaseSync(identifier,
					   // version,
					   // description,
					   // estimated_size,
					   // callback(db));
    var dB = LocalStorage.openDatabaseSync("cookingcalculator",
					   "0.1",
					   "Mass and weight converter.",
					   100000);

    try {
      dB.transaction(function(tx) {
		       tx.executeSql('CREATE TABLE IF NOT EXISTS ' +
				     'settings(comma TEXT, period TEXT);');

		       var table = tx.executeSql("SELECT * " +
						 "FROM settings;");

		       if(table.rows.length == 0) {
			 tx.executeSql('INSERT INTO settings VALUES(?, ?);',
				       [",", "."]);
			 print('Settings table seeded');
		       }
		       print('Settings table initialized.');
		     });
      return dB;
    } catch(err) {
      print("Error creating table in database: " + err);
    }
  }

  function getDbValue(col) {
    var r = null;

    try {
      db.transaction(function(tx) {
		       r = tx.executeSql("SELECT * " +
					 "FROM settings;").rows.item(0)[col];
		     });
    } catch(err) {
      print("Error retrieving value from database: " + err);
    }

    print(r);
    return r;
  }

  property var    db           : openDB();
  property string comma        : getDbValue("comma");
  property string period       : getDbValue("period");
  property string non_number   : "N/A";
  property bool   format_num   : true;
  property string   vols_label : i18n.tr(Object.keys(vols   ).join("\n"));
  property string weight_label : i18n.tr(Object.keys(weights).join("\n"));
  property string  temps_label : i18n.tr(Object.keys(temps  ).join("\n"));
  property string values_decs  : "";
  property string values_wholes: "";
  property string values_fracts: "";
  property string weight_decs  : "";
  property string weight_wholes: "";
  property string weight_fracts: "";

  property var fraction        : Fraction["Fraction"];

  function updateBasedOnSwitch() {
    whole_numbers.text = (view_fracts.checked ? values_wholes : "");
    fract_dec.text     = (view_fracts.checked ? values_fracts : values_decs);
    weight_w_nums.text = (view_fracts.checked ? weight_wholes : "");
    weight_f_d.text    = (view_fracts.checked ? weight_fracts : weight_decs);
  }

  function round(n) {
    return (n === non_number ? n : n.toFixed(2));
  }

  function formatNums(n) {
    if(format_num) {
      return n.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1" + comma);
    } else {
      return n;
    }
  }

  function textAccumulation(t, f, o) {
    var weight = weights[s_m.model[s_m.selectedIndex]];

    return (!(f == o) ? non_number :
	                (weight ? f * weight /
			          foods[s_p.model[s_p.selectedIndex]] /
				  current_table[t] :
				  (current_table == temps ?
				   temps[s_m.model[s_m.selectedIndex]][t](f) :
				   f *
				   current_table[s_m.model[s_m.selectedIndex]]
				   / current_table[t])));
  }
  function textAccumulation2(t, f, o) {
    return (!(f == o) ? non_number :
	                textAccumulation("Tablespoons (U. S.)", f, o) *
                        foods[s_p.model[s_p.selectedIndex]] / weights[t]);
  }

  function cycleTable(label_decs, label_wholes, label_fracts, f, o, e, table) {
    if(!(current_table == temps && table == weights)) {
      for(var item in table) {
	var r       = round((table == weights ? textAccumulation2 :
			                        textAccumulation)(item, f, o));
	label_decs += formatNums(r) + e;

	var num       = (new fraction(r)).toString().split(" ");
	var test      = num[0].indexOf("/") > -1;
	label_wholes += (!(f == o) ? non_number :
			             (!test ? formatNums(num[0]) :
				              "0"))                       + e;
	label_fracts += (!(f == o) ? non_number :
			             ( test ? formatNums(num[0]) :
					      (num[1] ? num[1] : "0/0"))) + e;
      }

      return [label_decs, label_wholes, label_fracts];
    }

    return ["", "", ""];
  }

  function convert(init_page) {
    if(init_page) {
      // Fills in the appropriate model for the OptionSelectors
      s_m.model         = Object.keys(current_table);
      if(current_table == vols) {
	s_m.model       = s_m.model.concat(Object.keys(weights)).sort();
      }

      s_p.model         = Object.keys(foods);
      measurements.text = (current_table == vols ? vols_label : temps_label);
    }

    var orig       = input.text;
    var fin        = Number(parseFloat(orig));
    var end        = "\u00A0\u00A0\u00A0\n";
    var temp_array = [];

    temp_array    = cycleTable("", "", "", fin, orig, end, current_table);
    values_decs   = temp_array[0];
    values_wholes = temp_array[1];
    values_fracts = temp_array[2];

    temp_array    = cycleTable("", "", "", fin, orig, end, weights);
    weight_decs   = temp_array[0];
    weight_wholes = temp_array[1];
    weight_fracts = temp_array[2];

    updateBasedOnSwitch();
  }

  PageHeader {
    id       : main_header;
    title    : i18n.tr("Cooking Calculator");
    extension: Sections {
                 id     : sects;
		 actions: [Action {
			     text       : i18n.tr("Products");
			     onTriggered: {
			       subs_column.visible               = false;
			       selectors_fields_switches.visible = true;
			       s_p.visible                       = true;
			       weight_title.visible              = true;
			       weight_row.visible                = true;
			       current_table                     = vols;
			       convert(true);
			     }
			   },
			   Action {
			     text       : i18n.tr("Temperatures");
			     onTriggered: {
			       subs_column.visible               = false;
			       selectors_fields_switches.visible = true;
			       s_p.visible                       = false;
			       weight_title.visible              = false;
			       weight_row.visible                = false;
			       current_table                     = temps;
			       convert(true);
			     }
			   },
			   Action {
			     text       : i18n.tr("Guides");
			     onTriggered: {
 			       selectors_fields_switches.visible = false;
			       subs_column.visible               = true;
			     }
			   }]

		 anchors {
		   left      : parent.left;
		   leftMargin: margs;
		   bottom    : parent.bottom;
		 }
               }

    trailingActionBar {
      actions: [Action {
		  iconName   : "settings";
		  text       : "Settings";
		  onTriggered: {
		    main_header.visible     = false;
		    settings_header.visible = true;
		  }
		}]
    }

    ScrollView {
      height: main_view.height - (parent.height + sects.height);

      anchors {
        margins: margs;
	top    : parent.bottom;
	left   : parent.left;
	right  : parent.right;
      }

      Column {
	Column {
	  id        : selectors_fields_switches;
	  objectName: "selectors_fields_switches";
	  width     : main_view.width - 2 * margs;
	  spacing   : units.gu(1);

	  OptionSelector {
	    id                    : s_p;  // because it's long, otherwise
	    objectName            : "selector_product";
	    width                 : parent.width;
	    containerHeight       : itemHeight * 4;
	    model                 : [];
	    onSelectedIndexChanged: convert(false);
          }

          OptionSelector {
	    id                    : s_m;  // because it's long, otherwise
	    objectName            : "selector_measurement";
	    width                 : parent.width;
	    containerHeight       : itemHeight * 4;
	    model                 : [];
	    onSelectedIndexChanged: convert(false);
	  }

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
	    onTextChanged   : convert(false);
	  }

	  Row {
	    Switch {
	      id       : view_fracts;
	      checked  : false;
	      onClicked: updateBasedOnSwitch();
	    }

	    Label {
	      text: i18n.tr("    View Fractions");
	    }
	  }

	  Label {
	    text                    : i18n.tr("\n\nVolume");
	    color                   : UbuntuColors.purple;
	    font.bold               : true;
	    fontSize                : "Large";
	    anchors.horizontalCenter: parent.horizontalCenter;
	  }

	  Row {
	    width  : parent.width;
	    spacing: 0;

	    Row {
	      width          : parent.width / 2;
	      layoutDirection: Qt.RightToLeft;

	      Label {
		id                 : fract_dec;
		text               : "frac";
		lineHeight         : units.gu(3);
		lineHeightMode     : Text.FixedHeight;
		horizontalAlignment: Text.AlignRight;
	      }

	      Label {
		id                 : whole_numbers;
		text               : "wholes";
		lineHeight         : units.gu(3);
		lineHeightMode     : Text.FixedHeight;
		horizontalAlignment: Text.AlignRight;
	      }
	    }

	    Label {
	      id            : measurements;
	      text          : vols_label;
	      width         : parent.width / 2;
	      font.bold     : true;
	      lineHeight    : units.gu(3);
	      lineHeightMode: Text.FixedHeight;
	    }
	  }

	  Label {
	    id                      : weight_title;
	    text                    : i18n.tr("Weight");
	    color                   : UbuntuColors.purple;
	    font.bold               : true;
	    fontSize                : "Large";
	    anchors.horizontalCenter: parent.horizontalCenter;
	  }

	  Row {
	    id     : weight_row;
	    width  : parent.width;
	    spacing: 0;

	    Row {
	      width          : parent.width / 2;
	      layoutDirection: Qt.RightToLeft;

	      Label {
		id                 : weight_f_d;
		text               : "frac";
		lineHeight         : units.gu(3);
		lineHeightMode     : Text.FixedHeight;
		horizontalAlignment: Text.AlignRight;
	      }

	      Label {
		id                 : weight_w_nums;
		text               : "Place";
		lineHeight         : units.gu(3);
		lineHeightMode     : Text.FixedHeight;
		horizontalAlignment: Text.AlignRight;
	      }
	    }

	    Label {
	      id            : weight_meas;
	      text          : weight_label;
	      width         : parent.width / 2;
	      font.bold     : true;
	      lineHeight    : units.gu(3);
	      lineHeightMode: Text.FixedHeight;
	    }
	  }
	}

	Column {
	  id        : subs_column;
	  objectName: "subs_column";
	  visible   : false;
	  width     : main_view.width - 2 * margs;
	  spacing   : units.gu(1);

	  
	}
      }
    }
  }

  PageHeader {
    id                      : settings_header;
    title                   : i18n.tr("Settings");
    visible                 : false;
    leadingActionBar.actions: [Action {
				 iconName   : "back";
				 text       : "Back";
				 onTriggered: {
				   settings_header.visible = false;
				   main_header.visible     = true;
				 }
			       }]
  }
}