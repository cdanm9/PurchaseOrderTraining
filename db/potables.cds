using {cuid,managed,temporal,sap.common} from '@sap/cds/common';
using capm.mastertable as masters from './master_tables';   
context capm.table{

  entity PO_Header: managed,cuid{
    // key POH_Unique: UUID; 
    @readonly @mandatory PO_Number: Integer64 not null; 
    CreationDate: Date;
    DeliveryDate: Date;
    Status: Integer; 
    MadeBy: String(20) default 'CDAN';    
    @mandatory PCode: String(20); 
    @mandatory CompanyCode: String(20); 
    Delete: String(1) default '';
    Criticality: Integer default 0;    
    Total_Amount: Decimal default 0;          
    Pl_Master: Association to masters.Plant_Master on Pl_Master.CODE=PCode;
    Cp_Master: Association to masters.Company_Master on Cp_Master.CODE=CompanyCode;
    S_Master: Association to masters.Status_Master on S_Master.CODE=Status;
    PO_Item_Master: Composition of many PO_Item on PO_Item_Master.PO_Header_Master=$self;                       
    PO_Attach_Master: Composition of many PO_Attachment on PO_Attach_Master.AttachPOHeader=$self;                       
    PO_Event_Master: Association to many Event_Log on PO_Event_Master.PO_Number=PO_Number;       
    PO_Asso_Master: Association to many Purchase_Attachment on PO_Number=PO_Asso_Master.PO_Number;   
  };

  entity PO_Item: cuid{         
    // key POI_Unique: UUID;
    @readonly PO_Number: Integer64 not null;
    @readonly PO_Item_Num:Integer not null; 
    MCode: String(20);    
    Quantity: Integer @assert.range:[1,100];
    Amount: Decimal; 
    M_Master: Association to masters.Material_Master on M_Master.CODE=MCode;   
    PO_Header_Master: Association to PO_Header;    
  }    
  
  entity Event_Log{
    key PO_Number: Integer64;
    key EVENT_CODE: Integer;   
    EVENT_DESCRIPTION: String(100);
    EVENT_DATE:Timestamp @cds.on.insert : $now;  
    EVENT_BY:String(500);
  }

  entity PO_Attachment: cuid,managed{
    PO_Number: Integer64; @readonly
    @Core.IsMediaType: true File_Type:String;
    @Core.MediaType:File_Type File:LargeBinary @Core.ContentDisposition.Filename: FileName;    
    FileName: String;
    AttachPOHeader: Association to PO_Header;     
  }

  entity Purchase_Attachment: cuid,managed{
    PO_Number: Integer64;
    @Core.MediaType: mediaType
    content: LargeBinary;   
    @Core.IsMediaType: true
    mediaType: String;
    fileName: String;
    size: Integer;
    url: String;
  }
      
}

@cds.persistence.exists 
@cds.persistence.calcview 
Entity POHEADERITEMS {
        PO_NUMBER: Integer64  @title: 'PO_NUMBER: PO_NUMBER' ; 
key     CREATIONDATE: Date  @title: 'CREATIONDATE: CREATIONDATE' ; 
key     DELIVERYDATE: Date  @title: 'DELIVERYDATE: DELIVERYDATE' ; 
        STATUS: Integer  @title: 'STATUS: STATUS' ; 
key     CREATEDBY: String(20)  @title: 'CREATEDBY: CREATEDBY' ; 
        PO_ITEM_NUM: Integer  @title: 'PO_ITEM_NUM: PO_ITEM_NUM' ; 
        QUANTITY: Integer  @title: 'QUANTITY: QUANTITY' ; 
        AMOUNT: Decimal(34)  @title: 'AMOUNT: AMOUNT' ; 
}  

@cds.persistence.exists 
@cds.persistence.calcview 
Entity PO_HEADER_REPORT {
key     PO_NUMBER: Integer64  @title: 'PO_NUMBER: PO_NUMBER' ; 
key     CREATIONDATE: Date  @title: 'CREATIONDATE: CREATIONDATE' ; 
key     DELIVERYDATE: Date  @title: 'DELIVERYDATE: DELIVERYDATE' ; 
        STATUS: Integer  @title: 'STATUS: STATUS' ; 
key     CREATEDBY: String(255)  @title: 'CREATEDBY: CREATEDBY' ; 
key     PCODE: String(20)  @title: 'PCODE: PCODE' ; 
key     COMPANYCODE: String(20)  @title: 'COMPANYCODE: COMPANYCODE' ; 
        PO_ITEM_NUM: Integer  @title: 'PO_ITEM_NUM: PO_ITEM_NUM' ; 
        QUANTITY: Integer  @title: 'QUANTITY: QUANTITY' ; 
        AMOUNT: Decimal(34)  @title: 'AMOUNT: AMOUNT' ; 
}

@cds.persistence.exists 
@cds.persistence.calcview 
Entity PO_STAR_JOIN {
key     PLCODE: String(20)  @title: 'Plant Code' ; 
        PLANT: String(100)  @title: 'Plant' ; 
        PCITY: String(100)  @title: 'Plant City' ; 
key     CCODE: String(20)  @title: 'Company Code' ; 
        CDESC: String(500)  @title: 'Company Description' ; 
        CWEB: String(500)  @title: 'Company Website' ; 
        COMPANY: String(500)  @title: 'Company' ; 
key     SCODE: Integer  @title: 'Status Code' ; 
        STATUS: String(500)  @title: 'Status' ; 
key     MRCODE: String(20)  @title: 'Material Code' ; 
        MDESC: String(500)  @title: 'Material' ; 
        PLANT_CODE: String(20)  @title: 'Material Plant Code' ; 
        MPRICE: Double  @title: 'Material Price' ; 
key     CREATEDBY: String(255)  @title: 'Created By' ; 
        MODIFIEDAT: Timestamp  @title: 'Modified By' ; 
        PO_NUMBER: Integer64  @title: 'PO Number' ; 
key     CREATIONDATE: Date  @title: 'Creation Date' ; 
key     DELIVERYDATE: Date  @title: 'Delivery Date' ; 
key     MADEBY: String(20)  @title: 'Made By' ; 
key     DELETE: String(1)  @title: 'Delete' ; 
        TOTAL_AMOUNT: Decimal(34)  @title: 'Total Amount' ; 
key     PO_ITEM_NUM: Integer  @title: 'PO Item Number' ; 
key     QUANTITY: Integer  @title: 'Quantity' ; 
key     AMOUNT: Decimal(34)  @title: 'Amount' ; 
}

