using POReportService as service from '../../srv/po_report_srv';
using from '../../srv/po_report_srv_ui';



annotate service.POHeader with @(
    UI.Chart #CreationDate : {
        $Type : 'UI.ChartDefinitionType',
        Title : 'Creation Date',
        ChartType : #Line,
        Dimensions : [
            CreationDate,
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#totalAmount',
        ],
    }
);
annotate service.POHeader with @(
    UI.PresentationVariant #prevCreationDate : {
        $Type : 'UI.PresentationVariantType',
        Visualizations : [
            '@UI.Chart#CreationDate',
        ],
    }
);
annotate service.POHeader with {
    CreationDate @Common.ValueList #vlCreationDate : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'POHeader',
        PresentationVariantQualifier : 'prevCreationDate',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : CreationDate,
                ValueListProperty : 'CreationDate',   
            },
        ],
    }
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
    CODE @Common.Text : NAME
};
annotate service.CompanyMaster with {
    CODE @Common.Text : NAME
};
annotate service.POHeader with @(
    UI.Chart #Analysis : {
        $Type : 'UI.ChartDefinitionType',
        Title : 'Analysis',
        ChartType : #Bar,
        Dimensions : [
            CompanyCode,
            PCode,
        ],
        DimensionAttributes : [   
            {
                $Type : 'UI.ChartDimensionAttributeType',
                Dimension : CompanyCode,
                Role : #Category,
            },
            {
                $Type : 'UI.ChartDimensionAttributeType',
                Dimension : PCode,
                Role : #Category2,
            },
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#totalStatus',
            '@Analytics.AggregatedProperty#totalAmount',
        ],
        MeasureAttributes : [
            {
                $Type : 'UI.ChartMeasureAttributeType',
                DynamicMeasure : '@Analytics.AggregatedProperty#totalStatus',
                Role : #Axis1,
            },
            {
                $Type : 'UI.ChartMeasureAttributeType',
                DynamicMeasure : '@Analytics.AggregatedProperty#totalAmount',
                Role : #Axis2,
            },
            {
                $Type : 'UI.ChartMeasureAttributeType',
                DynamicMeasure,
                Role : #Axis1,
            },
        ],   
    }
);
annotate service.POHeader with @(
    UI.PresentationVariant : {
        $Type : 'UI.PresentationVariantType',
        Visualizations : [
            '@UI.LineItem',
            '@UI.Chart#Analysis',
        ],
    }
);
annotate service.POHeader with @(
    UI.Chart #AmountVisual : {
        $Type : 'UI.ChartDefinitionType',
        Title : 'Amount vs Company',
        ChartType : #Bar,  
        Dimensions : [
            CompanyCode,
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#totalAmount',
        ],
    }
);
annotate service.POHeader with @(
    UI.PresentationVariant #Amountprev : {
        $Type : 'UI.PresentationVariantType',
        Visualizations : [
            '@UI.Chart#AmountVisual',
        ],
    }
);
annotate service.POHeader with {
    CompanyCode @Common.ValueList #vlCompany : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'POHeader',
        PresentationVariantQualifier : 'Amountprev',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : CompanyCode,
                ValueListProperty : 'CompanyCode',
            },
        ],
    }
};
annotate service.POHeader with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_Number,
        },
        {
            $Type : 'UI.DataField',
            Value : MadeBy,
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
            Value : Status,
        },
        {
            $Type : 'UI.DataField',
            Value : CreationDate,
        },
        {
            $Type : 'UI.DataField',
            Value : Total_Amount,
            Label : 'Total_Amount',
        },
    ]
);
annotate service.POHeader with @(
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'DESC',
            Target : 'S_Master/@UI.DataPoint#DESC1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'NAME',
            Target : 'Pl_Master/@UI.DataPoint#NAME1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'NAME1',
            Target : 'Cp_Master/@UI.DataPoint#NAME1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'S_MasterCODE',
            Target : 'S_Master/@UI.Chart#CODE',
        },],
    UI.FieldGroup #POHeader : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : Cp_Master.NAME,
                Label : 'Company',
            },{
                $Type : 'UI.DataField',
                Value : Pl_Master.NAME,
                Label : 'Plant',
            },{
                $Type : 'UI.DataField',
                Value : S_Master.DESC,
                Label : 'Status',
                Criticality : Criticality,
            },{
                $Type : 'UI.DataField',
                Value : createdAt,
            },{
                $Type : 'UI.DataField',
                Value : CreationDate,
            },{
                $Type : 'UI.DataField',
                Value : DeliveryDate,
            },{
                $Type : 'UI.DataField',
                Value : MadeBy,
            },{
                $Type : 'UI.DataField',
                Value : PO_Number,
            },],
    }
);
annotate service.POHeader with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase Order Header',
            ID : 'PurchaseOrderHeader',
            Target : '@UI.FieldGroup#PurchaseOrderHeader1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase Order Items',
            ID : 'PurchaseOrderItems',
            Target : 'PO_Item_Master/@UI.LineItem#PurchaseOrderItems',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase Order Event',
            ID : 'PurchaseOrderEvent',
            Target : 'PO_Event_Master/@UI.LineItem#PurchaseOrderEvent',
        },
    ]
);
annotate service.POItem with @(
    UI.LineItem #PurchaseOrderItems : [
        {
            $Type : 'UI.DataField',
            Value : PO_Header_Master.PO_Item_Master.Amount,
            Label : 'Amount',
        },{
            $Type : 'UI.DataField',
            Value : PO_Header_Master.PO_Item_Master.MCode,
            Label : 'MCode',
        },{
            $Type : 'UI.DataField',
            Value : PO_Header_Master.PO_Item_Master.PO_Item_Num,
            Label : 'PO_Item_Num',
        },{
            $Type : 'UI.DataField',
            Value : PO_Header_Master.PO_Item_Master.PO_Number,
            Label : 'PO_Number',
        },{
            $Type : 'UI.DataField',
            Value : PO_Header_Master.PO_Item_Master.Quantity,
            Label : 'Quantity',
        },]
);
annotate service.StatusMaster with @(
    UI.DataPoint #DESC : {
        $Type : 'UI.DataPointType',
        Value : DESC,
        Title : 'DESC',
    }
);
annotate service.PlantMaster with @(
    UI.DataPoint #NAME : {
        $Type : 'UI.DataPointType',
        Value : NAME,
        Title : 'NAME',
    }
);
annotate service.CompanyMaster with @(
    UI.DataPoint #NAME : {
        $Type : 'UI.DataPointType',
        Value : NAME,
        Title : 'NAME',
    }
);
annotate service.StatusMaster with @(
    UI.DataPoint #DESC1 : {
        $Type : 'UI.DataPointType',
        Value : DESC,
        Title : 'Status',
    }
);
annotate service.PlantMaster with @(
    UI.DataPoint #NAME1 : {
        $Type : 'UI.DataPointType',
        Value : NAME,
        Title : 'Plant',
    }
);
annotate service.CompanyMaster with @(
    UI.DataPoint #NAME1 : {
        $Type : 'UI.DataPointType',
        Value : NAME,
        Title : 'Company',
    }
);
annotate service.POItem with @(
    UI.DataPoint #Amount : {
        Value : Amount,
    },
    UI.Chart #Amount : {
        ChartType : #Area,
        Title : 'Amount',
        Measures : [
            Amount,
        ],
        MeasureAttributes : [
            {
                DataPoint : '@UI.DataPoint#Amount',
                Role : #Axis1,
                Measure : Amount,
            },
        ],
        Dimensions : [
            PO_Item_Num,
        ],
    }
);
annotate service.POItem with @(
    UI.DataPoint #Amount1 : {
        Value : Amount,
    },
    UI.Chart #Amount1 : {
        ChartType : #Line,
        Title : 'Amount',
        Measures : [
            Amount,
        ],
        MeasureAttributes : [
            {
                DataPoint : '@UI.DataPoint#Amount1',
                Role : #Axis1,
                Measure : Amount,
            },
        ],
        Dimensions : [
            PO_Item_Num,
        ],
    }
);
annotate service.POItem with @(
    UI.DataPoint #Amount2 : {
        Value : Amount,
    },
    UI.Chart #Amount2 : {
        ChartType : #Area,
        Title : 'Amount',
        Measures : [
            Amount,
        ],
        MeasureAttributes : [
            {
                DataPoint : '@UI.DataPoint#Amount2',
                Role : #Axis1,
                Measure : Amount,
            },
        ],
        Dimensions : [
            PO_Item_Num,
        ],
    }
);
annotate service.POHeader with @(
    UI.DataPoint #PO_Number : {
        Value : PO_Number,
        TargetValue : Status,
    },
    UI.Chart #PO_Number : {
        ChartType : #Donut,
        Title : 'PO Number',
        Measures : [
            PO_Number,
        ],
        MeasureAttributes : [
            {
                DataPoint : '@UI.DataPoint#PO_Number',
                Role : #Axis1,
                Measure : PO_Number,
            },
        ],
    }
);
annotate service.StatusMaster with @(
    UI.DataPoint #CODE : {
        Value : CODE,
        MinimumValue : 0,
        MaximumValue : 5,
        CriticalityCalculation : {
            ImprovementDirection : #Minimize,
            DeviationRangeHighValue : CODE,
            ToleranceRangeHighValue : CODE,
        },
    },
    UI.Chart #CODE : {
        ChartType : #Bullet,
        Title : 'CODE',
        Measures : [
            CODE,
        ],
        MeasureAttributes : [
            {
                DataPoint : '@UI.DataPoint#CODE',
                Role : #Axis1,
                Measure : CODE,
            },
        ],
    }
);
annotate service.POHeader with @(
    UI.FieldGroup #PurchaseOrderHeader : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    }
);
annotate service.POHeader with @(
    UI.FieldGroup #PurchaseOrderHeader1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CompanyCode,
            },{
                $Type : 'UI.DataField',
                Value : createdAt,
            },{
                $Type : 'UI.DataField',
                Value : CreationDate,
            },{
                $Type : 'UI.DataField',
                Value : DeliveryDate,
            },{
                $Type : 'UI.DataField',
                Value : MadeBy,
            },{
                $Type : 'UI.DataField',
                Value : PCode,
            },{
                $Type : 'UI.DataField',
                Value : PO_Number,
            },{
                $Type : 'UI.DataField',
                Value : Total_Amount,
                Label : 'Total_Amount',
            },],
    }
);
annotate service.POEvent with @(
    UI.LineItem #PurchaseOrderEvent : [
        {
            $Type : 'UI.DataField',
            Value : PO_Number,
            Label : 'PO_Number',
        },
        {
            $Type : 'UI.DataField',
            Value : EVENT_BY,
            Label : 'EVENT_BY',
        },{
            $Type : 'UI.DataField',
            Value : EVENT_DATE,
            Label : 'EVENT_DATE',
        },
        {
            $Type : 'UI.DataField',
            Value : EVENT_CODE,
            Label : 'EVENT_CODE',
        },{
            $Type : 'UI.DataField',
            Value : EVENT_DESCRIPTION,
            Label : 'EVENT_DESCRIPTION',
        },]
);
