sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'poactions/test/integration/FirstJourney',
		'poactions/test/integration/pages/POHeaderList',
		'poactions/test/integration/pages/POHeaderObjectPage',
		'poactions/test/integration/pages/POItemObjectPage'
    ],
    function(JourneyRunner, opaJourney, POHeaderList, POHeaderObjectPage, POItemObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('poactions') + '/index.html'
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