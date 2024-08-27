using capm.table as prc from '../db/potables';
using {PO_STAR_JOIN,POHEADERITEMS} from '../db/potables';
using capm.mastertable as masters from '../db/master_tables';


service PODashboardService@(requires:'authenticated-user'){
     @requires:['ZPO_ADMIN']
     entity POHeader as projection on prc.PO_Header;
     entity POItem as projection on prc.PO_Item;
     entity PlantMaster as projection on masters.Plant_Master;
     entity CompanyMaster as projection on masters.Company_Master;
     @restrict:[{grant:'*',to:'ZPO_INITIATOR'}]   
     entity POEvent as projection on prc.Event_Log;   
     @restrict:[{grant:'READ',to:'ZPO_ADMIN'}]
     entity Material_Master as projection on masters.Material_Master;
     @restrict:[{grant:'WRITE',to:'ZPO_ADMIN'}]
     entity StatusMaster as projection on masters.Status_Master;
     @readonly
     entity POStarReport as projection on PO_STAR_JOIN;
     @readonly  
     entity PO_Header_Items as projection on POHEADERITEMS;  

     type oPOHeader:many{
          PO_NUMBER: Integer64; 
          CREATIONDATE: Date;   
          DELIVERYDATE: Date;
          STATUS: Integer; 
          MADEBY: String(20); 
          PCODE: String(20); 
          COMPANYCODE: String(20); 
          DELETE: String(1);               
     }       
     function POCancelled() returns oPOHeader;
   
} 