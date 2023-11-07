sap.ui.define(["sap/m/MessageBox"], function(MessageBox) {
    "use strict";
    var that,oUploadSet,_fileName;  
    async function _download(item) {
        var settings = {
            url: item.getUrl(),
            method: "GET",
            xhrFields:{
                responseType: "blob"
            }
        }	

        return new Promise((resolve, reject) => {
            $.ajax(settings)
            .done((result, textStatus, request) => {
                resolve(result);
            })
            .fail((err) => {
                reject(err);
            })
        });						
    }
    async function _uploadContent(item, id) {
        var url = `/pocreation/Purchase_Attachment(${id})/content`
        item.setUploadUrl(url);	   
        oUploadSet.setHttpRequestMethod("PUT")
        oUploadSet.uploadItem(item);      
    }	
    async function _createEntity(item){       
        var data = {
            mediaType: item.getMediaType(),
            fileName: item.getFileName(),
            size: item.getFileObject().size
        };   
           
        var settings = {
            url: "/pocreation/Purchase_Attachment",
            method: "POST",
            headers: {
                "Content-type": "application/json"
            },
            data: JSON.stringify(data)   
        }

    return new Promise((resolve, reject) => {
        $.ajax(settings)
            .done((results, textStatus, request) => {
                resolve(results.ID);
            })
            .fail((err) => {
                reject(err);
            })
        })				
    }    
    return {      
        onAfterItemAdded: async function (oEvent) {
            oUploadSet=oEvent.getSource()
            var item = oEvent.getParameter("item")
            var id=await _createEntity(item)
            await _uploadContent(item, id);
        },
         
        onUploadCompleted: function (oEvent) {
            // var oUploadSet = this.byId("uploadSet");
            oUploadSet.removeAllIncompleteItems();
            oUploadSet.getBinding("items").refresh();
        },
          
        onOpenPressed:async function (oEvent) {	
            oEvent.preventDefault();
            var item = oEvent.getSource();
            var _fileName = item.getFileName();
            var blob=await _download(item)
            var url = window.URL.createObjectURL(blob);
            var link = document.createElement('a');
            link.href = url;
            link.setAttribute('download', _fileName);
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);					
        }		
    };
});