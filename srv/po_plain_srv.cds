using capm.table as prc from '../db/potables';
using capm.mastertable as masters from '../db/master_tables';


service POPlainService {

     entity POHeader as projection on prc.PO_Header;
     entity POItem as projection on prc.PO_Item;
     entity PlantMaster as projection on masters.Plant_Master;
     entity CompanyMaster as projection on masters.Company_Master;
     entity POEvent as projection on prc.Event_Log;   
     entity Material_Master as projection on masters.Material_Master;   
     entity StatusMaster as projection on masters.Status_Master; 
   
} 
