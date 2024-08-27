context capm.mastertable{
  entity Plant_Master{
    key CODE: String(20);     
    NAME: String(100);
    CITY: String(100);   
  }

  entity Company_Master{
    key CODE : String(20);
    DESC: String(500);
    WEBSITE: String(500);
    NAME: String(500);
  }

  entity Material_Master{
    key CODE: String(20);
    DESC: String(500);
    Plant_Code: String(20);
    Price:Double default 0.0;
    Material_Image:String @UI : {IsImageURL : true};    
    Pl_Master: Association to Plant_Master on Pl_Master.CODE=Plant_Code;  
    Phone: String(20) @Communication.IsPhoneNumber;
    Fax:String(20);
    Email      : String(240) @Communication.IsEmailAddress; 
    LandLine: String(20);                
  }

  entity Status_Master{
    key CODE: Integer;
    DESC: String(500);
  }

  entity Approver_Master{
    key USER_NAME: String(20);
    NAME: String(100);   
    PASSCODE: String(20);
    LEVEL: Integer;  
  }

  entity MasterUser{
    key user_id: String(30);
    user_name:String(100);
    email:String(500);
  }
}