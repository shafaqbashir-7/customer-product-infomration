import { LightningElement, wire, track, api } from 'lwc';
import getProductInfo from '@salesforce/apex/CustomerProductInformationController.getProductInfo';
import PRODUCTNAME from '@salesforce/schema/PricebookEntry.Name';
import ATMFEE from '@salesforce/schema/PricebookEntry.ATM_Fee_in_other_currencies__c';
import CARDREPLACEMENT from '@salesforce/schema/PricebookEntry.Card_Replacement_Cost__c';
import CALENDARMONTH from '@salesforce/schema/PricebookEntry.Cost_per_Calendar_Month__c';


export default class CustomerProductInformation extends LightningElement {
  @api recordId;
  @track error;
  @track pricebookid;
  fields = [PRODUCTNAME, ATMFEE, CARDREPLACEMENT, CALENDARMONTH];

    @wire(getProductInfo, {recordId: '$recordId'})
    wiredResult(result, error) { 
      if (result.data) {
         this.pricebookid = result.data;
      }  else if(error){
        console.log(error);
      }
    }
}