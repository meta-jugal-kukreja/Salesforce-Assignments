import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateContact extends LightningElement {

    @api recordId;
    @track contactId;
    handleSuccess(event) {
        this.contactId = event.detail.id;
        this.recordId = this.contactId;
        const toastEvent = new ShowToastEvent({
            title : 'Success Message',
            message : 'Contact saved successfully!!',
            variant : 'successs',
            mode : 'dismissable'
        });
        this.dispatchEvent(toastEvent);
    }


    handleError() {
        const toastEvent = new ShowToastEvent({
            title : 'Error Message',
            message : 'Some error occurred!!',
            variant : 'error',
            mode : 'dismissable'
        });
        this.dispatchEvent(toastEvent);
    }
}