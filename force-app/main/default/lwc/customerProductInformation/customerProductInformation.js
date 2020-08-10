import { LightningElement, wire, track, api } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import PRODUCTID from '@salesforce/schema/Case.Contact.Product__c';
import getProductInfo from '@salesforce/apex/CustomerProductInformationController.getProductInfo';
import HOMECOUNTRY from '@salesforce/schema/Case.Contact.Home_Country__c';

import PRODUCTNAME from '@salesforce/schema/PricebookEntry.Name';
import ATMFEE from '@salesforce/schema/PricebookEntry.ATM_Fee_in_other_currencies__c';
import CARDREPLACEMENT from '@salesforce/schema/PricebookEntry.Card_Replacement_Cost__c';
import CALENDARMONTH from '@salesforce/schema/PricebookEntry.Cost_per_Calendar_Month__c';


export default class CustomerProductInformation extends LightningElement {
  @api recordId;
  @track error;
  @track prodId;
  @track h_country;
  @track pricebookid;
  fields = [PRODUCTNAME, ATMFEE, CARDREPLACEMENT, CALENDARMONTH];

  @wire(getRecord, { recordId: '$recordId', fields: [PRODUCTID, HOMECOUNTRY] })
    case({error, data}) {
      if(data) {
          
        this.prodId = getFieldValue(data, PRODUCTID);
        this.h_country = getFieldValue(data, HOMECOUNTRY);
        

      } else if (error) {
          // Log Error
        console.log(error);
      }
    }

    @wire(getProductInfo, {ProductId: '$prodId', homeCountry: '$h_country'}) 
    wiredResult(result, error) { 
      if (result.data) {
         this.pricebookid = result.data;
      }  else if(error){
        console.log(error);
      }
    }
}