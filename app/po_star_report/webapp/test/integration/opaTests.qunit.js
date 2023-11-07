sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'postarreport/test/integration/FirstJourney',
		'postarreport/test/integration/pages/POStarReportList',
		'postarreport/test/integration/pages/POStarReportObjectPage'
    ],
    function(JourneyRunner, opaJourney, POStarReportList, POStarReportObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('postarreport') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOStarReportList: POStarReportList,
					onThePOStarReportObjectPage: POStarReportObjectPage
                }
            },
            opaJourney.run
        );
    }
);