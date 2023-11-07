sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'pocreate/test/integration/FirstJourney',
		'pocreate/test/integration/pages/POHeaderList',
		'pocreate/test/integration/pages/POHeaderObjectPage',
		'pocreate/test/integration/pages/POItemObjectPage'
    ],
    function(JourneyRunner, opaJourney, POHeaderList, POHeaderObjectPage, POItemObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('pocreate') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOHeaderList: POHeaderList,
					onThePOHeaderObjectPage: POHeaderObjectPage,
					onThePOItemObjectPage: POItemObjectPage
                }
            },
            opaJourney.run
        );
    }
);