({
    clickCreate: function(component, event, helper) {
        var validContact = component.find('contactform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validContact){
            // Create the new expense
            var newContact = component.get("v.newContact");
            helper.saveContact(component, newContact);
            component.set("v.newContact", {sobjectType: 'Contact', FirstName: '', LastName: '', Email: '', Phone: '', Fax: ''});
        }
    }
})