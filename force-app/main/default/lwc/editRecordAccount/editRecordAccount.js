/* 
____________________________________________________________    
@author: Lucas Araujo.
@description: Component for fast edit in account record. 
____________________________________________________________
*/
import { LightningElement,  api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class EditRecordAccount extends LightningElement {
    @api recordId;
    
    handleSuccess() {

        const toastEvent = new ShowToastEvent({
            title: 'Toast message',
            message: 'Account Record has been updated',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(toastEvent);   
    }
}