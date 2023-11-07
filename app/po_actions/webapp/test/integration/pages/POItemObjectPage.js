sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'poactions',
            componentId: 'POItemObjectPage',
            contextPath: '/POHeader/PO_Item_Master'
        },
        CustomPageDefinitions
    );
});