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

  PageHeader {
    title    : i18n.tr("Cooking Calculator");
    extension: Sections {
                 actions: [Action {
			     text       : "Products";
			     onTriggered: {
			     }
			   },
			   Action {
			     text       : "Temperatures";
			     onTriggered: {
			     }
			   },
			   Action {
			     text       : "Guides";
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
      spacing: units.gu(1);

      anchors {
        margins: units.gu(2);
	top    : parent.bottom;
	left   : parent.left;
	right  : parent.right;
      }

      OptionSelector {
	id                    : selector_product;
	objectName            : "selector_product";
	text                  : "Product";
	width                 : parent.width;
	containerHeight       : itemHeight * 4;
	model                 : ["Shit", "Fuck", "Damn"];
	onSelectedIndexChanged: ;
      }

      OptionSelector {
	id                    : selector_measurement;
	objectName            : "selector_measurement";
	text                  : "Measurement";
	width                 : parent.width;
	containerHeight       : itemHeight * 4;
	model                 : ["Shit", "Fuck", "Damn"];
	onSelectedIndexChanged: ;
      }
    }
  }
}

