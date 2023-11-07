const cds=require("@sap/cds")
const library=require("./Library/responseHandle")
module.exports=cds.service.impl(function(srv){
    this.on("POApprove",async(req)=>{
        try{
            var iApproveCode=2,sMessage;
            var oPayload=JSON.parse(req.data.input)    
            let uQuery=await UPDATE('CAPM_TABLE_PO_HEADER') .set({'Status':{'=':iApproveCode}}) .where({'PO_Number':oPayload.PO_Number});

            let dCreationDate=new Date()
            let dCrDate=dCreationDate.toISOString()
            let aEvent=[
                {
                    PO_Number:oPayload.PO_Number,
                    EVENT_BY:oPayload.PO_Events.EVENT_BY,
                    EVENT_DATE:dCrDate,
                    EVENT_CODE: iApproveCode,
                    EVENT_DESCRIPTION:oPayload.PO_Events.EVENT_DESCRIPTION,
                }
            ]         
            var qQueryInsertEvent=await UPSERT(aEvent).into('CAPM_TABLE_EVENT_LOG');
            req.reply(`PO Number : ${oPayload.PO_Number} Approved Successfully!`);
            sMessage=`PO Number : ${oPayload.PO_Number} Approved Successfully!`
            await library.handleResponse(req,'success',200,sMessage)

        }
        catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }
    });

    this.on("POComplete",async(req)=>{
        try{
            var iCompleteCode=5,sMessage;
            var oPayload=JSON.parse(req.data.input)    
            let uQuery=await UPDATE('CAPM_TABLE_PO_HEADER') .set({'Status':{'=':iCompleteCode}}) .where({'PO_Number':oPayload.PO_Number});

            let dCreationDate=new Date()
            let dCrDate=dCreationDate.toISOString()
            let aEvent=[
                {
                    PO_Number:oPayload.PO_Number,
                    EVENT_BY:oPayload.PO_Events.EVENT_BY,
                    EVENT_DATE:dCrDate,
                    EVENT_CODE: iCompleteCode,
                    EVENT_DESCRIPTION:oPayload.PO_Events.EVENT_DESCRIPTION,
                }
            ]         
            var qQueryInsertEvent=await UPSERT(aEvent).into('CAPM_TABLE_EVENT_LOG');
            sMessage=`PO Number : ${oPayload.PO_Number} Completed Successfully!`;
            await library.handleResponse(req,'success',200,sMessage)

        }
        catch(oError){
            // return oError;
            await library.handleResponse(req,'error',404,oError)
        }
    });

    this.on("POReject",async(req)=>{
        try{
            var sMessage;
            var iRejectCode=3;
            var oPayload=JSON.parse(req.data.input)    
            let uQuery=await UPDATE('CAPM_TABLE_PO_HEADER') .set({'Status':{'=':iRejectCode}}) .where({'PO_Number':oPayload.PO_Number});

            let dCreationDate=new Date()
            let dCrDate=dCreationDate.toISOString()
            let aEvent=[
                {
                    PO_Number:oPayload.PO_Number,
                    EVENT_BY:oPayload.PO_Events.EVENT_BY,
                    EVENT_DATE:dCrDate,
                    EVENT_CODE: iRejectCode,
                    EVENT_DESCRIPTION:oPayload.PO_Events.EVENT_DESCRIPTION,
                }
            ]         
            var qQueryInsertEvent=await UPSERT(aEvent).into('CAPM_TABLE_EVENT_LOG');
            sMessage=`PO Number : ${oPayload.PO_Number} Rejected Successfully!`
            await library.handleResponse(req,'success',200,sMessage);

        }
        catch(oError){
            // return oError;
            await library.handleResponse(req,'error',404,oError)
        }
    });

    this.on ('PurchaseApprove',async req => {
        await UPDATE (req.subject) .with ({Status:2,Criticality:3})      
    })
    
    this.on ('PurchaseReject',async req => {
        await UPDATE (req.subject) .with ({Status:3,Criticality:1})
    })

    this.on ('PurchaseComplete',async req => {
        await UPDATE (req.subject) .with ({Status:5})        
    })   

})