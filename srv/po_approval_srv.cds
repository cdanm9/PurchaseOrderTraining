using capm.table as prc from '../db/potables';
using capm.mastertable as masters from '../db/master_tables';

service POApprovalService {
     @odata.draft.enabled
     entity POHeader as projection on prc.PO_Header{
          *,
          'Purchase Order : ' || PO_Number as PO_Label:String   
     } actions{   
          action PurchaseApprove();   
          action PurchaseReject();   
          action PurchaseComplete();    
     };  
     entity POItem as projection on prc.PO_Item;
     entity PlantMaster as projection on masters.Plant_Master;
     entity CompanyMaster as projection on masters.Company_Master;
     entity POEvent as projection on prc.Event_Log;
     entity Material_Master as projection on masters.Material_Master;   
     entity StatusMaster as projection on masters.Status_Master;
     entity ApproverMaster as projection on masters.Approver_Master;
     entity PO_Attachment as projection on prc.PO_Attachment;    
     action POApprove(input:String) returns many String;
     action POComplete(input:String) returns many String;
     action POReject(input:String) returns many String;
} 