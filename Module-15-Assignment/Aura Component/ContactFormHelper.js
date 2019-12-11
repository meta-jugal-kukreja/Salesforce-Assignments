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
                alert('Contact Created Successfully' + newContact.Id);
                window.location.href = '/lightning/r/Contact/' + newContact.Id + '/view';
            }
            else
            {
                alert('There was an error while creating a contact');
            }
        });
        $A.enqueueAction(action);
	}
})