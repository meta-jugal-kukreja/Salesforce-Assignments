/* eslint-disable no-unused-vars */
import { LightningElement } from "lwc";
import { createRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { NavigationMixin } from "lightning/navigation";
import CONTACT_OBJECT from "@salesforce/schema/Contact";
import FIRSTNAME_FIELD from "@salesforce/schema/Contact.FirstName";
import LASTNAME_FIELD from "@salesforce/schema/Contact.LastName";
import EMAIL_FIELD from "@salesforce/schema/Contact.Email";
import PHONE_FIELD from "@salesforce/schema/Contact.Phone";
import FAX_FIELD from "@salesforce/schema/Contact.Fax";

export default class CreateContactThroughWireAdapter extends NavigationMixin(LightningElement) {
  FirstName = "";
  LastName = "";
  Email = "";
  Phone = "";
  Fax = "";
  handleFirstNameChange(event) {
    this.FirstName = event.target.value;
  }
  handleLastNameChange(event) {
    this.LastName = event.target.value;
  }
  handleEmailChange(event) {
    this.Email = event.target.value;
  }
  handlePhoneChange(event) {
    this.Phone = event.target.value;
  }
  handleFaxChange(event) {
    this.Fax = event.target.value;
  }

  createContact() {
    const fields = {};
    fields[FIRSTNAME_FIELD.fieldApiName] = this.FirstName;
    fields[LASTNAME_FIELD.fieldApiName] = this.LastName;
    fields[EMAIL_FIELD.fieldApiName] = this.Email;
    fields[PHONE_FIELD.fieldApiName] = this.Phone;
    fields[FAX_FIELD.fieldApiName] = this.Fax;
    const recordInput = { apiName: CONTACT_OBJECT.objectApiName, fields };
    createRecord(recordInput)
      .then(contact => {
        this.contactId = contact.id;
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Success",
            message: "Contact Created Successfully.",
            variant: "success"
          })
        );
        this.contactHomePageRef = {
          type: "standard__recordPage",
          attributes: {
            recordId: this.contactId,
            objectApiName: "Contact",
            actionName: "view"
          }
        };
      this[NavigationMixin.Navigate](this.contactHomePageRef);
      })
      .catch(error => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error Creating Record",
            message: error.body.message,
            variant: "error"
          })
        );
      });
  }
}