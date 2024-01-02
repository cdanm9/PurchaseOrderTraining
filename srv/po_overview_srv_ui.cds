using PO_OverviewService from './po_overview_srv'; 

//Filters
// annotate PO_OverviewService.POHeader with @(UI : {
//     SelectionFields  : [
//     ],
//     SelectionVariant : {
//         $Type         : 'UI.SelectionVariantType',
//         SelectOptions : [{
//             $Type        : 'UI.SelectOptionType',
//             PropertyName : localCurrency,
//         }],
//     },
// });

annotate  PO_OverviewService.POHeader with {
 modifiedAt @UI.Hidden;
 modifiedBy @UI.Hidden;
 createdAt @UI.Hidden;
 createdBy @UI.Hidden ;
 };    
   
//Donut Chart
// annotate PO_OverviewService.POItem with @(UI : {
//     Chart #donut                            : {
//         $Type               : 'UI.ChartDefinitionType',
//         ChartType           : #Donut,
//         Description         : 'Donut Chart',
//         Measures            : [Amount],
//         MeasureAttributes   : [{
//             $Type     : 'UI.ChartMeasureAttributeType',
//             Measure   : Amount,
//             Role      : #Axis1,
//             DataPoint : '@UI.DataPoint#Amount'
//         }],
//         Dimensions          : [MCode],
//         DimensionAttributes : [{
//             $Type     : 'UI.ChartDimensionAttributeType',
//             Dimension : MCode,
//             Role      : #Category
//         }]
//     },
//     PresentationVariant #donutPreVar        : {
//         $Type             : 'UI.PresentationVariantType',
//         Visualizations    : ['@UI.Chart#donut'],
//         MaxItems          : 3,
//         IncludeGrandTotal : true,
//         SortOrder         : [{
//             $Type      : 'Common.SortOrderType',
//             Descending : true,
//             Property   : Amount
//         }]
//     },
//     DataPoint #Amount : {
//         $Type                  : 'UI.DataPointType',
//         Value                  : Amount,
//         Title                  : 'Amount',
//         CriticalityCalculation : {
//             $Type                   : 'UI.CriticalityCalculationType',
//             ImprovementDirection    : #Maximize,
//             DeviationRangeHighValue : 1000000,
//             DeviationRangeLowValue  : 3000000
//         },
//         TrendCalculation       : {
//             $Type                : 'UI.TrendCalculationType',
//             ReferenceValue       : 1000,
//             UpDifference         : 10,
//             StrongUpDifference   : 100,
//             DownDifference       : -10,
//             StrongDownDifference : -100
//         },
//     },
//     Identification                          : [{
//         $Type : 'UI.DataField',
//         Value : Amount
//     }]
// });



// annotate PO_OverviewService.POItem with @(UI : {
//     Chart #donut                            : {
//         $Type               : 'UI.ChartDefinitionType',
//         ChartType           : #Donut,
//         Description         : 'Donut Chart',
//         Measures            : [Amount],
//         MeasureAttributes   : [{
//             $Type     : 'UI.ChartMeasureAttributeType',
//             Measure   : Amount,
//             Role      : #Axis1,
//             DataPoint : '@UI.DataPoint#Amount'
//         }],
//         Dimensions          : [MCode],
//         DimensionAttributes : [{
//             $Type     : 'UI.ChartDimensionAttributeType',
//             Dimension : MCode,
//             Role      : #Category
//         }]
//     },
//     PresentationVariant #donutPreVar        : {
//         $Type             : 'UI.PresentationVariantType',
//         Visualizations    : ['@UI.Chart#donut'],
//         MaxItems          : 3,
//         IncludeGrandTotal : true,
//         SortOrder         : [{
//             $Type      : 'Common.SortOrderType',
//             Descending : true,
//             Property   : Amount
//         }]
//     },
//     DataPoint #Amount : {
//         $Type                  : 'UI.DataPointType',
//         Value                  : Amount,
//         Title                  : 'Amount',
//         CriticalityCalculation : {
//             $Type                   : 'UI.CriticalityCalculationType',
//             ImprovementDirection    : #Maximize,
//             DeviationRangeHighValue : 1000000,
//             DeviationRangeLowValue  : 3000000
//         },
//         TrendCalculation       : {
//             $Type                : 'UI.TrendCalculationType',
//             ReferenceValue       : 1000,
//             UpDifference         : 10,
//             StrongUpDifference   : 100,
//             DownDifference       : -10,
//             StrongDownDifference : -100
//         },
//     },
//     Identification                          : [{
//         $Type : 'UI.DataField',
//         Value : Amount
//     }]
// });

// annotate  PO_OverviewService.POEvent with {
//  modifiedAt @UI.Hidden;
//  modifiedBy @UI.Hidden;
//  createdAt @UI.Hidden;
//  createdBy @UI.Hidden;
//  companyCurrency @title : 'Currency' @Measures.ISOCurrency : 'Currency';
//  companyCurrency_Text @title : '';
//  creationMonthAsDate @title : 'Creation Date';
//  creationMonth @title : 'Month';
//  creationMonth_Text @title : 'Month' @Common.QuickInfo : 'Month Long text';
//  referenceAmount @title : 'Amount' ; 
//  };
//Line Chart
// annotate PO_OverviewService.POEvent with @(
//     UI.Chart #Line                             : {
//         $Type               : 'UI.ChartDefinitionType',
//         ChartType           : #Line,
//         Description         : 'Line Chart',
//         Measures            : [Amount],
//         MeasureAttributes   : [{
//             $Type     : 'UI.ChartMeasureAttributeType',
//             Measure   : Amount,
//             Role      : #Axis1,
//             DataPoint : '@UI.DataPoint#Amount'
//         }],
//         Dimensions          : [creationMonth],
//         DimensionAttributes : [{
//             $Type     : 'UI.ChartDimensionAttributeType',
//             Dimension : creationMonth,
//             Role      : #Category
//         }]
//     },
//     UI.PresentationVariant #Line               : {
//         $Type             : 'UI.PresentationVariantType',
//         Visualizations    : ['@UI.Chart#Line'],
//         MaxItems          : 3,
//         IncludeGrandTotal : true,
//         SortOrder         : [{
//             $Type      : 'Common.SortOrderType',
//             Descending : true,
//             Property   : creationMonthAsDate
//         }]
//     },
//     UI.DataPoint #Amount : {
//         $Type                  : 'UI.DataPointType',
//         Value                  : Amount,
//         Title                  : 'Amount',
//         CriticalityCalculation : {
//             $Type                   : 'UI.CriticalityCalculationType',
//             ImprovementDirection    : #Maximize,
//             DeviationRangeHighValue : 1000000,
//             DeviationRangeLowValue  : 3000000
//         },
//         TrendCalculation       : {
//             $Type                : 'UI.TrendCalculationType',
//             ReferenceValue       : referenceAmount,
//             UpDifference         : 10,
//             StrongUpDifference   : 100,
//             DownDifference       : -10,
//             StrongDownDifference : -100
//         }
//     }
// );


annotate PO_OverviewService.POItem with @(
  Aggregation: {
    ApplySupported: {
      PropertyRestrictions: true
    }
  },
  UI: {
    SelectionFields: [MCode],
    PresentationVariant #Chart1: {Visualizations: ['@UI.Chart#MCodeByQuantity']},
    Chart #MCodeByQuantity : {
      ChartType                 : #Bar,   
      Dimensions                : ['MCode'],
      DimensionAttributes       : [{
        Dimension               : 'MCode',
        Role                    : #Category
      }],
      Measures                  : ['Quantity'],
      MeasureAttributes         : [{
        Measure                 : 'Quantity',
        Role                    : #Axis1
      }]
    }
  }
);

annotate PO_OverviewService.POItem with @(
//   Aggregation: {
//     ApplySupported: {
//       PropertyRestrictions: true
//     }
//   },
  UI: {
    // SelectionFields: [MCode],
    // PresentationVariant #Chart1: {Visualizations: ['@UI.Chart#MCodeByAmount']},
    Chart #MCodeByAmount : {
      ChartType                 : #Column,
      Dimensions                : ['MCode'],
      DimensionAttributes       : [{
        Dimension               : 'MCode',
        Role                    : #Category
      }],
      Measures                  : ['Amount'],
      MeasureAttributes         : [{
        Measure                 : 'Amount',
        Role                    : #Axis1
      }]
    }
  }
);


annotate PO_OverviewService.POItem with {
  @Analytics.Dimension      : true
  MCode @(title  : 'Material Code');
  @Analytics.Measure        : true   
  @Core.Computed
  Quantity @(title                   : 'Quantity');     
    @Analytics.Measure        : true   
  @Core.Computed
  Amount @(title                   : 'Amount');   
}

annotate PO_OverviewService.POHeader with {
  @Analytics.Dimension      : true
  MadeBy @(title  : 'Made By');
  @Analytics.Measure        : true   
  @Core.Computed   
  Total_Amount @(title : 'Total Amount');    
  @Analytics.Dimension      : true
  PCode @(title  : 'Plant'); 
  @Analytics.Dimension      : true
  CompanyCode @(title  : 'Company');    
  @Analytics.Measure        : true   
  CreationDate @(title : 'Creation Date');   
   @Analytics.Measure        : true   
  DeliveryDate @(title : 'Delivery Date');             
}  

annotate PO_OverviewService.StatusMaster with {
  @Analytics.Dimension      : true
  CODE @(title  : 'Status Code');   
  @Analytics.Measure        : true   
  DESC @(title : 'Status');                 
}  