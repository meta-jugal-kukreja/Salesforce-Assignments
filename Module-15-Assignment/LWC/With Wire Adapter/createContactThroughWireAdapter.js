/* eslint-disable no-unused-vars */
import { LightningElement } from "lwc";
import { createRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import CONTACT_OBJECT from "@salesforce/schema/Contact";
import FIRSTNAME_FIELD from "@salesforce/schema/Contact.FirstName";
import LASTNAME_FIELD from "@salesforce/schema/Contact.LastName";
import EMAIL_FIELD from "@salesforce/schema/Contact.Email";
import PHONE_FIELD from "@salesforce/schema/Contact.Phone";
import FAX_FIELD from "@salesforce/schema/Contact.Fax";

export default class CreateContactThroughWireAdapter extends LightningElement {
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
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Success",
            message: "Contact created with Id : ",
            variant: "success"
          })
        );
      })
      .catch(error => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error creating record",
            message: error.body.message,
            variant: "error"
          })
        );
      });
  }
}
