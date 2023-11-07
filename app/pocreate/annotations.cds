using POCreationService as service from '../../srv/po_creation_srv';
using from '../../srv/po_creation_srv_ui';
using from '../../db/potables';



annotate service.POHeader with @(
    UI.SelectionFields : [
        PO_Number,
        PCode,
        CompanyCode,
        Status,
    ]
);
annotate service.POHeader with {
    PCode @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'PlantMaster',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PCode,
                    ValueListProperty : 'CODE',
                },
            ],
            Label : 'Plant Code',
        },
        Common.ValueListWithFixedValues : true
)};

annotate service.PlantMaster with {
    CODE @Common.Text : NAME
};
annotate service.POHeader with {
    CompanyCode @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'CompanyMaster',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : CompanyCode,
                    ValueListProperty : 'CODE',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'NAME',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'DESC',
                },
            ],
            Label : 'Company Code',
        },
        Common.ValueListWithFixedValues : false
)};
annotate service.CompanyMaster with {
    CODE @Common.Text : NAME
};
annotate service.POHeader with {
    PO_Number @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'POHeader',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : PO_Number,
                    ValueListProperty : 'PO_Number',
                },
            ],
            Label : 'PO Number',
        },
        Common.ValueListWithFixedValues : true
)};

annotate service.POItem with {
    MCode @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Material_Master',
            Parameters : [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        LocalDataProperty : MCode,
                        ValueListProperty : 'CODE',
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'DESC',
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'Price',
                    },
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'Plant_Code',
                        LocalDataProperty : PO_Header_Master.PCode,
                    },
                ],
            Label : 'Material ',
        },
        Common.ValueListWithFixedValues : false
)};
annotate service.Material_Master with {
    CODE @Common.Text : DESC
};
annotate service.POHeader with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_Number,
        },
        {
            $Type : 'UI.DataField',
            Value : PCode,
        },
        {
            $Type : 'UI.DataField',
            Value : CompanyCode,
        },
        {
            $Type : 'UI.DataField',
            Value : CreationDate,
        },
        {
            $Type : 'UI.DataField',
            Value : DeliveryDate,
        },
        {
            $Type : 'UI.DataField',
            Value : Status,
            Label : 'Status Code',
        },
        {
            $Type : 'UI.DataField',
            Value : MadeBy,
        },
        {
            $Type : 'UI.DataField',
            Value : S_Master.DESC,
            Label : 'Status',
            Criticality : Criticality,
            CriticalityRepresentation : #WithIcon,
        },
        {
            $Type : 'UI.DataField',
            Value : Cp_Master.NAME,
            Label : 'Company',
        },
        {
            $Type : 'UI.DataField',
            Value : Pl_Master.NAME,
            Label : 'Plant',
        },
        {
            $Type : 'UI.DataField',
            Value : Total_Amount,
            Label : 'Total_Amount',
        },
    ]
);





annotate service.POHeader with @(
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View',
    },
    UI.LineItem #tableView : [
    ],
    UI.SelectionPresentationVariant #tableView1 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View 1',
    }
);
annotate service.POHeader with {
    Status @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'StatusMaster',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Status,
                    ValueListProperty : 'CODE',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.StatusMaster with {
    CODE @Common.Text : DESC
};
annotate service.POHeader with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Header',
            Target : '@UI.FieldGroup#Main',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Items',
            Target : 'PO_Item_Master/@UI.LineItem',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Attachments',
            ID : 'POAttachments',
            Target : 'PO_Attach_Master/@UI.LineItem#POAttachments2',
        },
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     Label : 'PO Test Attachments',
        //     ID : 'POTestAttachments',
        //     Target : 'PO_Asso_Master/@UI.LineItem#POTestAttachments',
        // },
    ]
);
annotate service.POEvent with @(
    UI.LineItem #POEvents : [
        {
            $Type : 'UI.DataField',
            Value : EVENT_BY,
            Label : 'EVENT_BY',
        },{
            $Type : 'UI.DataField',
            Value : EVENT_CODE,
            Label : 'EVENT_CODE',
        },{
            $Type : 'UI.DataField',
            Value : EVENT_DATE,
            Label : 'EVENT_DATE',
        },{
            $Type : 'UI.DataField',
            Value : EVENT_DESCRIPTION,
            Label : 'EVENT_DESCRIPTION',
        },]
);
annotate service.PO_Attachment with @(
    UI.LineItem #POAttachments : [
        {
            $Type : 'UI.DataField',
            Value : PO_Number,
            Label : 'PO_Number',
        },{
            $Type : 'UI.DataField',
            Value : File_Type,
            Label : 'File_Type',
        },{
            $Type : 'UI.DataField',
            Value : FileChk,
            Label : 'FileChk',
        },{
            $Type : 'UI.DataField',
            Value : FileName,
            Label : 'FileName',
        },{
            $Type : 'UI.DataField',
            Value : MimeType,
            Label : 'MimeType',
        },
        {
            $Type : 'UI.DataField',
            Value : File,
            Label : 'File',
        },]
);
annotate service.POHeader with @(
    UI.FieldGroup #POEvents : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PO_Event_Master.EVENT_BY,
                Label : 'EVENT_BY',
            },{
                $Type : 'UI.DataField',
                Value : PO_Event_Master.EVENT_CODE,
                Label : 'EVENT_CODE',
            },{
                $Type : 'UI.DataField',
                Value : PO_Event_Master.EVENT_DATE,
                Label : 'EVENT_DATE',
            },{
                $Type : 'UI.DataField',
                Value : PO_Event_Master.EVENT_DESCRIPTION,
                Label : 'EVENT_DESCRIPTION',
            },],
    }
);
annotate service.PO_Attachment with @(
    UI.LineItem #POAttachments1 : [
    ]
);
annotate service.Purchase_Attachment with @(
    UI.LineItem #POTestAttachments : [
        {
            $Type : 'UI.DataField',
            Value : PO_Number,
            Label : 'PO_Number',
        },{
            $Type : 'UI.DataField',
            Value : fileName,
            Label : 'fileName',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'POCreationService.EntityContainer/POCreate',
            Label : 'POCreate',
            Inline : true,
        },]
);
annotate service.PO_Attachment with @(
    UI.LineItem #POAttachments2 : [
        {
            $Type : 'UI.DataField',
            Value : File,
            Label : 'File',
        },{
            $Type : 'UI.DataField',
            Value : FileName,
            Label : 'FileName',
        },{
            $Type : 'UI.DataField',
            Value : PO_Number,
            Label : 'PO_Number',
        },]
);
