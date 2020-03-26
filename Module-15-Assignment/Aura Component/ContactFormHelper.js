({
    saveContact : function(component, contact) 
    {
        var action = component.get("c.saveContact");
        action.setParams({
            "newContact": contact
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") 
            {
                var newContact = response.getReturnValue();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "variant": "info",
                    "title": "Success!",
                    "message": "The record has been updated successfully.",
                    "mode" : "dismissed"
                });
                toastEvent.fire();
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": '/lightning/r/Contact/' + newContact.Id + '/view'
                });
                urlEvent.fire();
            }
            else
            {
                var errors = response.getError();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "variant": "error",
                    "title": "Error!",
                    "message": errors[0].message,
					"mode" : "dismissed"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})