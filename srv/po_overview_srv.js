const cds=require("@sap/cds")
const library=require("./Library/responseHandle")

module.exports=cds.service.impl(function(srv){
    const { POHeader, POItem } = this.entities;
    
    this.on("POCancelled",async(req)=>{
        try{
            var iRejectCode=3;
            var iCancelledCode=4;
            var qUpdateQuery=await UPDATE('CAPM_TABLE_PO_HEADER') .set({'Status':iCancelledCode}) .where({'Status':iRejectCode});
            var aQuery=await SELECT .from('CAPM_TABLE_PO_HEADER') .where({'Status':iCancelledCode});
            var aEvent=[];
            let dCreationDate=new Date()
            let dCrDate=dCreationDate.toISOString()
            for(var i in aQuery){
                var iPO_Number=aQuery[i].PO_NUMBER;
                var oPOEvent={
                    PO_Number:iPO_Number,
                    EVENT_BY:"SYSTEM",
                    EVENT_DATE:dCrDate,
                    EVENT_CODE: iCancelledCode,
                    EVENT_DESCRIPTION:"Purchase Order Cancelled",
                } 
                aEvent.push(oPOEvent);
            }       
                
            var qQueryInsertEvent=await UPSERT(aEvent).into('CAPM_TABLE_EVENT_LOG');
            await library.handleResponse(req,'success',200,sMessage)
            req.reply(aQuery);     
        }catch(oError){
            await library.handleResponse(req,'error',404,oError)
        }   
    });

    this.before('NEW', POHeader, async req => {
        try{

        }catch(oError){

        }
    })

    this.before('NEW', POItem, async req => {
        try{

        }catch(oError){

        }
    })

})