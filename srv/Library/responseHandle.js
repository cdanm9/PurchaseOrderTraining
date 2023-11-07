const cds=require('@sap/cds')
exports.handleResponse = async function (req, sPart, sCode, sMessage) {
    var sStringifiedMessage;
    if(sPart=='success'){
        if(typeof(sMessage)=='object'){
            req.reply(sMessage);
        }else{
            req.reply(sMessage);
        }   
    }
    else if(new RegExp('error|warn|info|notify|reject').test(sPart)){
        if((typeof(sMessage)=='object')&&(sMessage.message!='undefined'||sMessage.messages!='undefined')){
            sCode=sMessage.code
            sMessage=sMessage.message||sMessage.messages;
        }else{
            sMessage=sMessage;
        }

        var oErrorObject = JSON.stringify({ code: sCode, message: sMessage })

        if (sPart === 'error')
            req.error(oErrorObject);
        else if (sPart === 'warn')
            req.warn(oErrorObject);
        else if (sPart === 'info')
            req.info(oErrorObject);
        else if (sPart === 'notify')
            req.notify(oErrorObject);
        else if (sPart === 'reject')
            req.reject(oErrorObject);
    }
}