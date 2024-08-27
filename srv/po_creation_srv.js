const cds=require("@sap/cds")
const library=require("./Library/responseHandle");
const { uuid } = require("@sap/cds/lib/utils/cds-utils");
const dbClass = require("sap-hdbext-promisfied")
const hdbext = require("@sap/hdbext")
module.exports=cds.service.impl(function(srv){
    const { POHeader, POItem,PO_Attachment,Purchase_Attachment,POEvent } = this.entities;   
    var iPurchaseNum;
    // POReturn
    this.on("POReturn",async(req)=>{
        const { PO_Number } = req.data
        const aPOEvent = await SELECT .from (POEvent) .where `PO_Number = ${PO_Number}` 
        var oPOTest;
        if(aPOEvent.length!=0)   
         oPOTest={POTest:true}
        else 
         oPOTest={POTest:false}    
        return oPOTest
    });
    this.on("POCreate",async(req)=>{
        try{
            var client=dbClass.createConnectionFromEnv()
            var dbConn=new dbClass(client)
            var iPONumber,sMessage;
            var oPayload=JSON.parse(req.data.input)
            var oPOHeader=oPayload.PO_Header;
            var oPOItem=oPayload.PO_Item;
            var oPOEvent=oPayload.PO_Event;
            let aPO_Number= await SELECT .from('CAPM_TABLE_PO_HEADER',['Max(PO_Number) as PO_Number']); 
            if(aPO_Number[0].PO_Number==null){
                iPONumber=10001; 
            }else{
                iPONumber=aPO_Number[0].PO_Number+1;
            }

            oPOHeader[0].PO_Number=iPONumber;
            oPOHeader[0].Status=1;
            oPOHeader[0].CreationDate=new Date().toISOString().split('T')[0];     
            for(var i in oPOItem){
                oPOItem[i].PO_Item_Num=iLength;
                oPOItem[i].PO_Number=iPONumber;   
                var aMaterialMaster=await SELECT .from('CAPM_MASTERTABLE_MATERIAL_MASTER') .where({CODE:oPOItem[i].MCode});
                oPOItem[i].Amount=oPOItem[i].Quantity*aMaterialMaster[0].PRICE
            }

            oPOEvent[0].PO_Number=iPONumber;
            oPOEvent[0].EVENT_CODE=1;
            oPOEvent[0].EVENT_DESCRIPTION="Purchase Order Created";
            oPOEvent[0].EVENT_DATE=new Date().toISOString()  

            //Insert Queries   
                
            var qQueryInsertHeader=await INSERT(oPOHeader).into('CAPM_TABLE_PO_HEADER');
            var qQueryInsertItem=await INSERT(oPOItem).into('CAPM_TABLE_PO_ITEM');
            var qQueryInsertEvent=await UPSERT(oPOEvent).into('CAPM_TABLE_EVENT_LOG');
            sMessage=`PO Number : ${oPOEvent[0].PO_Number} Created Successfully!`;
            await library.handleResponse(req,'success',200,sMessage)

        }
        catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
    });


    this.on("POCreation",async(req)=>{
        var client= await dbClass.createConnectionFromEnv()
        var dbConn=new dbClass(client)
        try{
            var iPONumber,sMessage;
            // var oPayload=JSON.parse(req.data.input)
            var {Header}=req.data;
            const upperize = obj =>
            Object.keys(obj).reduce((acc, k) => {
                acc[k.toUpperCase()] = obj[k];
                return acc;
            }, {});
            var aHeader=upperize(Header)  
            var loadProc=await dbConn.loadProcedurePromisified(hdbext,null,'GETDATA');
            var sResponse=await dbConn.callProcedurePromisified(loadProc,[aHeader]);  
            // let aPO_Number= await SELECT .from('CAPM_TABLE_PO_HEADER',['Max(PO_Number) as PO_Number']); 
            // if(aPO_Number[0].PO_Number==null){
            //     iPONumber=10001; 
            // }else{
            //     iPONumber=aPO_Number[0].PO_Number+1;
            // }

            // oPOHeader[0].PO_Number=iPONumber;
            // oPOHeader[0].Status=1;
            // oPOHeader[0].CreationDate=new Date().toISOString().split('T')[0];     
            // for(var i in oPOItem){
            //     oPOItem[i].PO_Item_Num=iLength;
            //     oPOItem[i].PO_Number=iPONumber;   
            //     var aMaterialMaster=await SELECT .from('CAPM_MASTERTABLE_MATERIAL_MASTER') .where({CODE:oPOItem[i].MCode});
            //     oPOItem[i].Amount=oPOItem[i].Quantity*aMaterialMaster[0].PRICE
            // }

            // oPOEvent[0].PO_Number=iPONumber;
            // oPOEvent[0].EVENT_CODE=1;
            // oPOEvent[0].EVENT_DESCRIPTION="Purchase Order Created";
            // oPOEvent[0].EVENT_DATE=new Date().toISOString()  

            // //Insert Queries   
                
            // var qQueryInsertHeader=await INSERT(oPOHeader).into('CAPM_TABLE_PO_HEADER');
            // var qQueryInsertItem=await INSERT(oPOItem).into('CAPM_TABLE_PO_ITEM');
            // var qQueryInsertEvent=await UPSERT(oPOEvent).into('CAPM_TABLE_EVENT_LOG');
            // sMessage=`PO Number : ${oPOEvent[0].PO_Number} Created Successfully!`;
            await library.handleResponse(req,'success',200,sResponse)   
            // await library.handleResponse(req,'success',200,sMessage)

        }
        catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
    });

    this.before('NEW', POHeader, async req => {
        try{
            
            let iPONumber;
            let aPO_Number= await SELECT .from('CAPM_TABLE_PO_HEADER',['Max(PO_Number) as PO_Number']); 
            if(aPO_Number[0].PO_Number==null){
                req.data.PO_Number=10001; 
            }else{
                req.data.PO_Number=Number(aPO_Number[0].PO_Number)+1;
            }
            iPurchaseNum=req.data.PO_Number;
            req.data.Status=1;
            req.data.Criticality=0;   
            req.data.CreationDate=new Date().toISOString().split('T')[0];   

        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
    })

    this.before('CREATE', POHeader, async req => {
        try{
            var sMessage;
            if(iPurchaseNum){
                req.data.PO_Number=iPurchaseNum;
            }
            var aPOItem=req.data.PO_Item_Master;
            var nAmount=0;
            var iLength=aPOItem.length;
            for(var i in aPOItem){
                aPOItem[i].PO_Item_Num=iLength;        
                var aMaterialMaster=await SELECT .from('CAPM_MASTERTABLE_MATERIAL_MASTER') .where({CODE:aPOItem[i].MCode});
                aPOItem[i].Amount=aPOItem[i].Quantity*aMaterialMaster[0].PRICE
                nAmount=nAmount+aPOItem[i].Amount;
                iLength=iLength-1;           
            }
            req.data.Total_Amount=nAmount;
            var oPOEvent={   
                PO_Number:req.data.PO_Number,
                EVENT_CODE:1,
                EVENT_DESCRIPTION:'Purchase Order Created',
                EVENT_DATE:new Date().toISOString(),   
                EVENT_BY:'CDAN'  
            }   
            var aPOEvent=[];
            
            aPOEvent.push(oPOEvent);
            // await srv.send('POST','/POEvent',aPOEvent)            
            var qQueryInsertEvent=await INSERT(aPOEvent).into('CAPM_TABLE_EVENT_LOG');
            sMessage=`PO Number : ${aPOEvent[0].PO_Number} Created Successfully!`;
            await library.handleResponse(req,'success',200,sMessage)           
               

        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
        
    });

    this.before('SAVE', POHeader, async req => {
        try{
            // req.data.PO_Number=iPurchaseNum;
            

        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
        
    })
        
    this.before('NEW', POItem, async req => {
         
        try{
        
            req.data.PO_Number=iPurchaseNum;
            const { PO_Header_Master_ID } = req.data
            const { maxPOItem } = await SELECT.one `max(PO_Item_Num) as maxPOItem` .from (POItem.drafts) .where ({PO_Header_Master_ID})
            req.data.PO_Item_Num = maxPOItem + 1;              

        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
    })

    this.before('CREATE', POItem, async req => {
        try{
            req.data.PO_Number=iPurchaseNum;
            
        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
    })
    
    this.after('READ',POHeader,async req=>{
        try{
            // var oData=req.data
        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
    })

    this.after('READ',POItem,async req=>{
        try{

        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
    })

    this.before('SAVE', POItem, async req => {
        try{
            req.data.PO_Number=iPurchaseNum;   

        }catch(oError){     
            await library.handleResponse(req,'error',404,oError)
        }
    })

    this.before('CREATE',Purchase_Attachment,async req => {
        console.log('Create called')
        console.log(JSON.stringify(req.data))
        req.data.PO_Number=iPurchaseNum;      
        req.data.url = `/pocreation/Purchase_Attachment(${req.data.ID})/content`  
    })

    this.before('NEW',PO_Attachment,async req => {   
        req.data.PO_Number =iPurchaseNum;      
    })

    this.before('CREATE',PO_Attachment,async req => {   
        req.data.FileURL = `/pocreation/PO_Attachment(${req.data.ID})/File`   
    })

    //Error handler    
    this.on ('error', async (err, req) => {   
        var sMessage = 'Oh no! ' + err.message;        
    })
    
          
});
