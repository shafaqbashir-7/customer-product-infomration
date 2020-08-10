({
    handleRecordChanged: function(component, event, helper) {
    switch(event.getParams().changeType) {
      case "ERROR":
        // handle erro
        break;
      case "LOADED":
            
        var productId = component.get("v.caseRecord.Contact.Product__c");
        var homeCountry = component.get("v.caseRecord.Contact.Home_Country__c");
            
        var action;
        action = component.get("c.getProductInfo");
        action.setParams({ProductId : productId, homeCountry : homeCountry});
        
        action.setCallback(this, function(response) {
        if(response.getState() === "SUCCESS") {
          console.log('SUCCESS');  
          component.set("v.priceBookId", response.getReturnValue());
            
        } else {
           console.log('not working'); 
        }
      });
          $A.enqueueAction(action);
        break; 
    }
  }
  })