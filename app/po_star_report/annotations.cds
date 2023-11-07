using POReportService as service from '../../srv/po_report_srv';

annotate service.POStarReport with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_NUM,
        },
        {
            $Type : 'UI.DataField',
            Value : PO_NUMBER,
        },
        {
            $Type : 'UI.DataField',
            Value : MADEBY,
        },
        {
            $Type : 'UI.DataField',
            Value : DELIVERYDATE,
        },
        {
            $Type : 'UI.DataField',
            Value : CREATIONDATE,
        },
        {
            $Type : 'UI.DataField',
            Value : STATUS,
        },
        {
            $Type : 'UI.DataField',
            Value : PLANT,
        },
        {
            $Type : 'UI.DataField',
            Value : COMPANY,
        },
        {
            $Type : 'UI.DataField',
            Value : MDESC,
        },
        {
            $Type : 'UI.DataField',
            Value : MPRICE,
        },
        {
            $Type : 'UI.DataField',
            Value : QUANTITY,
        },
        {
            $Type : 'UI.DataField',
            Value : AMOUNT,
        },
    ]
);
annotate service.POStarReport with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PLCODE,
            },
            {
                $Type : 'UI.DataField',
                Value : PLANT,
            },
            {
                $Type : 'UI.DataField',
                Value : PCITY,
            },
            {
                $Type : 'UI.DataField',
                Value : CCODE,
            },
            {
                $Type : 'UI.DataField',
                Value : CDESC,
            },
            {
                $Type : 'UI.DataField',
                Value : CWEB,
            },
            {
                $Type : 'UI.DataField',
                Value : COMPANY,
            },
            {
                $Type : 'UI.DataField',
                Value : SCODE,
            },
            {
                $Type : 'UI.DataField',
                Value : STATUS,
            },
            {
                $Type : 'UI.DataField',
                Value : MRCODE,
            },
            {
                $Type : 'UI.DataField',
                Value : MDESC,
            },
            {
                $Type : 'UI.DataField',
                Value : PLANT_CODE,
            },
            {
                $Type : 'UI.DataField',
                Value : MPRICE,
            },
            {
                $Type : 'UI.DataField',
                Value : CREATEDBY,
            },
            {
                $Type : 'UI.DataField',
                Value : MODIFIEDAT,
            },
            {
                $Type : 'UI.DataField',
                Value : PO_NUMBER,
            },
            {
                $Type : 'UI.DataField',
                Value : CREATIONDATE,
            },
            {
                $Type : 'UI.DataField',
                Value : DELIVERYDATE,
            },
            {
                $Type : 'UI.DataField',
                Value : MADEBY,
            },
            {
                $Type : 'UI.DataField',
                Value : DELETE,
            },
            {
                $Type : 'UI.DataField',
                Value : TOTAL_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_NUM,
            },
            {
                $Type : 'UI.DataField',
                Value : QUANTITY,
            },
            {
                $Type : 'UI.DataField',
                Value : AMOUNT,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
    ]
);
annotate service.POStarReport with @(
    UI.SelectionFields : [
        CCODE,
        MRCODE,
        PLCODE,
    ]
);
annotate service.POStarReport with {
    CCODE @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'CompanyMaster',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : CCODE,
                    ValueListProperty : 'CODE',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'DESC',
                },
            ],
            Label : 'Company',
        },
        Common.ValueListWithFixedValues : false
)};
annotate service.POStarReport with {
    MRCODE @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Material_Master',
            Parameters : [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        LocalDataProperty : MRCODE,
                        ValueListProperty : 'CODE',
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'DESC',
                    },
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'Plant_Code',
                        LocalDataProperty : PLCODE,
                    },
                ],
            Label : 'Material',
        },
        Common.ValueListWithFixedValues : false
)};
annotate service.Material_Master with {
    CODE @Common.Text : DESC
};
annotate service.POStarReport with {
    PLCODE @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'PlantMaster',
            Parameters : [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        LocalDataProperty : PLCODE,
                        ValueListProperty : 'CODE',
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'NAME',
                    },
                ],
            Label : 'Plant',
        },
        Common.ValueListWithFixedValues : false
)};
annotate service.PlantMaster with {
    NAME @Common.Text : CODE
};
