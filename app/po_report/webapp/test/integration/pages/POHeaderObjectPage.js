sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'poreport',
            componentId: 'POHeaderObjectPage',
            entitySet: 'POHeader'
        },
        CustomPageDefinitions
    );
});