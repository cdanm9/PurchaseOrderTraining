using POODataService from './po_odata_srv';

annotate POODataService.POHeader with @(
  sap.semantics: 'aggregate'
){
  PO_Number @sap.aggregation.role: 'dimension';
  PCode @sap.aggregation.role: 'dimension';
  CompanyCode @sap.aggregation.role: 'dimension';
  MadeBy @sap.aggregation.role: 'dimension';
  Total_Amount @sap.aggregation.role: 'measure';         
};      

// annotate POODataService.POHeader with @(
//   UI.Chart #PCode: {
//     $Type : 'UI.ChartDefinitionType',
//     ChartType: #Bar,
//     Dimensions: [
//       PCode
//     ],
//     Measures: [
//       Total_Amount
//     ]
//   },
//   UI.PresentationVariant #prevPCode: {
//     $Type : 'UI.PresentationVariantType',
//     Visualizations : [
//         '@UI.Chart#PCode',
//     ],
//   }
// ){
//   PCode @Common.ValueList #vlPCode: {
//     $Type : 'Common.ValueListType',
//     CollectionPath : 'POHeader',
//     Parameters: [{
//       $Type : 'Common.ValueListParameterInOut',
//       ValueListProperty : 'PCode',   
//       LocalDataProperty: PCode
//     }],
//     PresentationVariantQualifier: 'prevPCode'
//   }   
// }    


// annotate POODataService.POHeader with @(
//   UI.Chart #CompanyCode: {
//     $Type : 'UI.ChartDefinitionType',
//     ChartType: #Bar,
//     Dimensions: [
//       CompanyCode
//     ],
//     Measures: [
//       Total_Amount
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

// annotate POODataService.POHeader with{
//     PCode          @title : 'Plant Code';
//     CompanyCode    @title : 'Company Code';
//     PO_Number      @ID : 'PO Number';  
//     CreationDate   @title : 'Creation Date';
//     DeliveryDate   @title : 'Delivery Date';
//     Status         @title : 'Status';
//     MadeBy      @title: 'Created By';
//     Delete         @title: 'Delete';
//     Pl_Master      @title: 'Plant Master';
//     Cp_Master       @title: 'Company Master';
//     S_Master        @title : 'Status Master';
//     PO_Item_Master  @title: 'Purchase Order Items';
//     PO_Event_Master @title: 'Purchase Order Events';   
// }   