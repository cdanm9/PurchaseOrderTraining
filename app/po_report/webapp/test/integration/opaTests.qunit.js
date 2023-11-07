sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'poreport/test/integration/FirstJourney',
		'poreport/test/integration/pages/POHeaderList',
		'poreport/test/integration/pages/POHeaderObjectPage'
    ],
    function(JourneyRunner, opaJourney, POHeaderList, POHeaderObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('poreport') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOHeaderList: POHeaderList,
					onThePOHeaderObjectPage: POHeaderObjectPage
                }
            },
            opaJourney.run
        );
    }
);