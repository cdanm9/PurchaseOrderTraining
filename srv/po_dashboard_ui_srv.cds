using PODashboardService from './po_dashboard_srv'; 

annotate PODashboardService.POItem with {    
  @Analytics.Dimension      : true
  MCode @(title  : 'Material Code');
  @Analytics.Measure        : true   
  @Core.Computed
  Quantity @(title                   : 'Quantity');     
    @Analytics.Measure        : true   
  @Core.Computed
  Amount @(title                   : 'Amount');   
}

annotate PODashboardService.POHeader with {
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

annotate PODashboardService.StatusMaster with {
  @Analytics.Dimension      : true
  CODE @(title  : 'Status Code');   
  @Analytics.Measure        : true   
  DESC @(title : 'Status');                 
}  