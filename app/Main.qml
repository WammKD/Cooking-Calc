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
  applicationName: "cookingcalc.jaft";

  /*
   *  This property enables the application to change orientation
   *  when the device is rotated. The default is false.
   */
  //automaticOrientation: true;


  width          : units.gu(100);
  height         : units.gu(75);

  PageHeader {
    title    : i18n.tr("Cooking Calculator");
    extension: Sections {
                 model: ["Volumes", "Temperatures", "Something"];

                 anchors {
		   left      : parent.left;
		   leftMargin: units.gu(2);
		   bottom    : parent.bottom;
		 }
               }

    Column {
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
      }

      TextField {
	id            : input_from;
	objectName    : "input_from";
	errorHighlight: false;
	validator     : DoubleValidator {
	                  notation: DoubleValidator.StandardNotation;
	                }
	height        : units.gu(5);
	width         : parent.width;
	font.pixelSize: FontUtils.sizeToPixels("medium");
	text          : '0.0';
      }

      OptionSelector {
	id        : selector_to;
	objectName: "selector_to";
	text      : "\n\nResulting Value";
	width     : parent.width;
	model     : ["Value 1", "Value 2", "Value 3", "Value 4"];
      }

      TextField {
	id            : result_to;
	objectName    : "result_to";
	errorHighlight: false;
	validator     : DoubleValidator {
	                  notation: DoubleValidator.StandardNotation;
	                }
	height        : units.gu(5);
	width         : parent.width;
	font.pixelSize: FontUtils.sizeToPixels("medium");
	text          : '0.0';
      }
    }
  }
}

