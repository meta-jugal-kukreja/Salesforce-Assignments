import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { NavigationMixin } from "lightning/navigation";

export default class CreateContact extends NavigationMixin(LightningElement) {
  handleSuccess(event) {
    this.recordId = event.detail.id;
    const toastEvent = new ShowToastEvent({
      title: "Success Message",
      message: "Contact saved successfully!!",
      variant: "successs",
      mode: "dismissable"
    });
    this.accountHomePageRef = {
        type: "standard__objectPage",
        attributes: {
          recordId: this.recordId,
          objectApiName: "Contact",
          actionName: "view"
        }
      };
    this[NavigationMixin.GenerateUrl](this.accountHomePageRef);
    this.dispatchEvent(toastEvent);
  }

  handleError(event) {
    const toastEvent = new ShowToastEvent({
      title: "Error Message",
      message: event.detail.message,
      variant: "error",
      mode: "dismissable"
    });
    this.dispatchEvent(toastEvent);
  }
}