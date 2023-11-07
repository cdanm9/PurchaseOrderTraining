using POApprovalService as service from '../../srv/po_approval_srv';
using from '../../db/potables';

annotate service.POHeader with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_Number,
            Label : 'PO Number  ',
        },
        {
            $Type : 'UI.DataField',
            Value : Pl_Master.NAME,
            Label : 'Plant',
        },
        {
            $Type : 'UI.DataField',
            Value : Cp_Master.NAME,
            Label : 'Company',
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
        },
        {
            $Type : 'UI.DataField',
            Value : DeliveryDate,
            Label : 'DeliveryDate',
        },
        {
            $Type : 'UI.DataField',
            Value : S_Master.DESC,
            Label : 'Status',
        },
        {
            $Type : 'UI.DataField',
            Value : MadeBy,
            Label : 'Made By',
        },
        {
            $Type : 'UI.DataField',
            Value : Total_Amount,
            Label : 'Total Amount',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'POApprovalService.PurchaseApprove',
            Label : 'Purchase Order Approve',
            Criticality : #Positive,      
        },
              
    ]
);
annotate service.POHeader with @(
    UI.SelectionFields : [
        CompanyCode,
        PCode,
        Status,
        PO_Number,
        MadeBy,
    ]
);
annotate service.POHeader with {
    CompanyCode @Common.Label : 'Company Code'
};
annotate service.POHeader with {
    PCode @Common.Label : 'PCode'
};
annotate service.POHeader with {
    Status @Common.Label : 'Status'
};
annotate service.POHeader with {
    PO_Number @Common.Label : 'PO Number'
};
annotate service.POHeader with {
    MadeBy @Common.Label : 'MadeBy'
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
                    ValueListProperty : 'DESC',
                },
            ],
            Label : 'Company ',
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.CompanyMaster with {
    CODE @Common.Text : NAME
};
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
            Label : 'Status',
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.StatusMaster with {
    CODE @Common.Text : DESC
};
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
            Label : 'Plant',
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.PlantMaster with {
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
annotate service.POHeader with {
    MadeBy @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'POHeader',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : MadeBy,
                    ValueListProperty : 'MadeBy',
                },
            ],
            Label : 'Made By',
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.POHeader with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Header',
            ID : 'POHeader',
            Target : '@UI.FieldGroup#POHeader',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Item',
            ID : 'POItem',
            Target : 'PO_Item_Master/@UI.LineItem#POItem',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Attachments',
            ID : 'POAttachments',
            Target : 'PO_Attach_Master/@UI.LineItem#POAttachments',
        },
    ],
    UI.FieldGroup #POHeader : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : createdAt,
            },{
                $Type : 'UI.DataField',
                Value : MadeBy,
                Label : 'Made By',
            },{
                $Type : 'UI.DataField',
                Value : PO_Number,
            },{
                $Type : 'UI.DataField',
                Value : Status,
            },{
                $Type : 'UI.DataField',
                Value : Total_Amount,
                Label : 'Total Amount',
            },{
                $Type : 'UI.DataField',
                Value : Cp_Master.NAME,
                Label : 'Company',
            },{
                $Type : 'UI.DataField',
                Value : Pl_Master.NAME,
                Label : 'Plant',
            },],
    }
);
annotate service.POItem with @(
    UI.LineItem #POItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_Item_Num,
            Label : 'PO_Item_Num',
        },{
            $Type : 'UI.DataField',
            Value : PO_Number,
            Label : 'PO_Number',
        },{
            $Type : 'UI.DataField',
            Value : MCode,
            Label : 'MCode',
        },{
            $Type : 'UI.DataField',
            Value : Quantity,
            Label : 'Quantity',
        },{
            $Type : 'UI.DataField',
            Value : Amount,
            Label : 'Amount',
        },]
);
annotate service.PO_Attachment with @(
    UI.LineItem #POAttachments : [
        {
            $Type : 'UI.DataField',
            Value : File,
            Label : 'File',
        },{
            $Type : 'UI.DataField',
            Value : File_Type,
            Label : 'File Type',
        },{
            $Type : 'UI.DataField',
            Value : FileName,
            Label : 'FileName',
        },]
);
annotate service.POHeader with @(
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'POApprovalService.PurchaseApprove',
            Label : 'Purchase Approve',
            Determining : true,
            Criticality:#Positive,  
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'POApprovalService.PurchaseReject',
            Label : 'Purchase Reject',
            Determining : true,
            Criticality:#Negative,    
        },]
);

annotate service.POHeader with actions {
 PurchaseApprove @(
   Core.OperationAvailable : {
     $edmJson: { $Eq: [{ $Path: 'in/Status'}, 1]}
   },
   Common.SideEffects.TargetProperties : ['in/Status'],
 ) 
};  

annotate service.POHeader with actions {
 PurchaseReject @(
   Core.OperationAvailable : {
     $edmJson: { $Eq: [{ $Path: 'in/Status'}, 1]}       
   },
   Common.SideEffects.TargetProperties : ['in/Status'],
 ) 
}; 
annotate service.POHeader with @(
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : PO_Label,
        },
        TypeName : '',
        TypeNamePlural : '',
    }
);
