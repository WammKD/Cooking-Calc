import QtQuick 2.4
import Ubuntu.Components 1.3

/*!
 *  \brief MainView with Tabs element.
 *         First Tab has a single Label and
 *         second Tab has a single ToolbarAction.
 */

MainView {
  id                : main_view;
  // objectName for functional testing purposes (autopilot-qt5)
  objectName        : "main_view";

  // Note! applicationName needs to match the "name" field of click manifest
  applicationName   : "cookingcalc.jaft";

  /*
   *  This property enables the application to change orientation
   *  when the device is rotated. The default is false.
   */
  //automaticOrientation: true;


  width             : units.gu(100);
  height            : units.gu(75);

  property var temps: { "Fahrenheit": { "Fahrenheit": function(f) { return f;},
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

  property var current_table: { 1: "one", 2: "two" };

  function convert(tf_input, tf_result, s_from, s_to) {
    var fin  = tf_input.text;
    var fin2 = Number(parseFloat(fin));

    if(!(fin2 == fin)) {
      tf_result.text = "";
    } else {
      tf_result.text = '        ' +
                       current_table[s_from.model[s_from.selectedIndex]]
                                    [  s_to.model[  s_to.selectedIndex]](fin2);
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
	id        : selector_from;
	objectName: "selector_from";
	text      : "Initial Value";
	width     : parent.width;
	model     : ["Value 1", "Value 2", "Value 3", "Value 4"];
	onSelectedIndexChanged: {
	  convert(input_from, result_to, selector_from, selector_to);
	}
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
	onTextChanged   : {
	  convert(input_from, result_to, selector_from, selector_to);
	}
      }

      OptionSelector {
	id        : selector_to;
	objectName: "selector_to";
	text      : "\n\nResulting Value";
	width     : parent.width;
	model     : ["Value 1", "Value 2", "Value 3", "Value 4"];
	onSelectedIndexChanged: {
	  convert(input_from, result_to, selector_from, selector_to);
	}
      }

      /* Label { */
      /* 	id       : result_to; */
      /* 	text     : '0.0'; */
      /* 	/\* font.italic: true; *\/ */
      /* 	anchors.horizontalCenter: parent.horizontalCenter; */
      /* /\* fontSize: "large"; *\/ */
      /* } */
    }

    Rectangle {
      id    : result;
      color: UbuntuColors.silk;
      height: result_to.height + 10;
      width: parent.width;

      anchors {
    	left   : parent.left;
    	top    : col.bottom;
    	topMargin: units.gu(1);
      }

      Label {
    	id       : result_to;
    	text     : '        0.0';
    	anchors.verticalCenter: parent.verticalCenter;
      /* fontSize: "large"; */
      }
    }
  }
}

