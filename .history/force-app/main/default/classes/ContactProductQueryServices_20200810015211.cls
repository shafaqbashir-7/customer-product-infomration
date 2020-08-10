public class ContactProductQueryServices {
   
  public static Id getProductEntry(String productId, String homeCountry) {

    return [SELECT Id, Product2.Name, ATM_Fee_in_other_currencies__c, Card_Replacement_Cost__c, Cost_per_Calendar_Month__c, Pricebook2.Name, CurrencyIsoCode FROM PricebookEntry WHERE Pricebook2.Name  = : homeCountry AND Product2Id = : productId LIMIT 1].Id;
  }
}