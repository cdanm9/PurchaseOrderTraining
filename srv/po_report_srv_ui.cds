using POReportService from './po_report_srv';     

//Annotations Normal Naming
annotate POReportService.POHeader with{
    PCode          @title : 'Plant Code';
    CompanyCode    @title : 'Company Code';
    PO_Number      @title : 'PO Number';
    CreationDate   @title : 'Creation Date';
    DeliveryDate   @title : 'Delivery Date';
    Status         @title : 'Status';
    MadeBy         @title: 'Created By';
    PO_Item_Master @title: 'Purchase Order Items';  
    Delete         @title: 'Delete';
}

//For Chart In Analytical List Page
annotate POReportService.POHeader with @(
    Aggregation.ApplySupported : {
        Transformations          : [
            'aggregate',
            'topcount',
            'bottomcount',
            'identity',
            'concat',
            'groupby',
            'filter',
            'expand',
            'search'
        ],
        GroupableProperties : [
            PO_Number,
            PCode,
            CompanyCode,
            CreationDate,
            MadeBy
        ],
        AggregatableProperties: [{
            $Type : 'Aggregation.AggregatablePropertyType',
            Property: Status
        },
        {
          $Type:'Aggregation.AggregatablePropertyType',
          Property: Total_Amount
        }]
    },
    Analytics.AggregatedProperty #totalStatus: {
    $Type : 'Analytics.AggregatedPropertyType',
    AggregatableProperty : Status,
    AggregationMethod : 'max',               
    Name : 'totalStatus',
    ![@Common.Label]: 'Max Status'
  },
  Analytics.AggregatedProperty #totalAmount: {
    $Type : 'Analytics.AggregatedPropertyType',
    AggregatableProperty : Total_Amount,
    AggregationMethod : 'max',          
    Name : 'totalAmount',
    ![@Common.Label]: 'Max Amount'   
  }
);

//Combining All For Headers In Analytical List Page
// annotate POReportService.POHeader with @(
//   UI.Chart: {
//     $Type : 'UI.ChartDefinitionType',
//     Title: 'Status',
//     ChartType : #Column,
//     Dimensions: [
//       PCode,
//       CompanyCode
//     ],
//     DimensionAttributes: [{
//       $Type : 'UI.ChartDimensionAttributeType',
//       Dimension: PCode,
//       Role: #Category
//     },{
//       $Type : 'UI.ChartDimensionAttributeType',
//       Dimension: CompanyCode,
//       Role: #Category2
//     }],
//     DynamicMeasures: [
//       ![@Analytics.AggregatedProperty#totalStatus]
//     ],
//     MeasureAttributes: [{
//       $Type: 'UI.ChartMeasureAttributeType',
//       DynamicMeasure: ![@Analytics.AggregatedProperty#totalStatus],
//       Role: #Axis1
//     }]
//   },
//   UI.PresentationVariant: {
//     $Type : 'UI.PresentationVariantType',
//     Visualizations : [
//         '@UI.Chart',
//     ],
//   }
// );

//For PCODE vs Total Status Graph
annotate POReportService.POHeader with @(
  UI.Chart #PCode: {
    $Type : 'UI.ChartDefinitionType',
    ChartType: #Bar,
    Dimensions: [
      PCode
    ],
    DynamicMeasures: [
      ![@Analytics.AggregatedProperty#totalStatus]
    ]
  },
  UI.PresentationVariant #prevPCode: {
    $Type : 'UI.PresentationVariantType',
    Visualizations : [
        '@UI.Chart#PCode',
    ],
  }
){
  PCode @Common.ValueList #vlPCode: {
    $Type : 'Common.ValueListType',
    CollectionPath : 'POHeader',
    Parameters: [{
      $Type : 'Common.ValueListParameterInOut',
      ValueListProperty : 'PCode',
      LocalDataProperty: PCode   
    }],
    PresentationVariantQualifier: 'prevPCode'
  }
}

//For Company Code Vs Total Status Graph  
// annotate POReportService.POHeader with @(
//   UI.Chart #CompanyCode: {
//     $Type : 'UI.ChartDefinitionType',
//     ChartType: #Bar,
//     Dimensions: [
//       CompanyCode
//     ],
//     DynamicMeasures: [
//       ![@Analytics.AggregatedProperty#totalStatus]
//     ]
//   },
//   UI.PresentationVariant #prevCompanyCode: {
//     $Type : 'UI.PresentationVariantType',
//     Visualizations : [
//         '@UI.Chart#CompanyCode',
//     ],
//   }
// ){
//   CompanyCode @Common.ValueList #vlCompanyCode: {
//     $Type : 'Common.ValueListType',
//     CollectionPath : 'POHeader',
//     Parameters: [{
//       $Type : 'Common.ValueListParameterInOut',
//       ValueListProperty : 'CompanyCode',   
//       LocalDataProperty: CompanyCode
//     }],
//     PresentationVariantQualifier: 'prevCompanyCode'
//   }   
// }



annotate POReportService.POHeader with@(
    UI: {
        SelectionFields  : [
            PCode,
            CompanyCode,
            CreationDate
        ],    
        LineItem: [
            {  $Type : 'UI.DataField', Value : PO_Number, },
            {  $Type : 'UI.DataField', Value : MadeBy, },
            {  $Type : 'UI.DataField', Value : PCode, },
            {  $Type : 'UI.DataField', Value : CompanyCode, },
            {  $Type : 'UI.DataField', Value : Status, },
            {  $Type : 'UI.DataField', Value : CreationDate, },

        ],
    }
);
