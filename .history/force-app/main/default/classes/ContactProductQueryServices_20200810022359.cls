/**
 * @description       : 
 * @author            : shafaqbashir
 * @group             : 
 * @last modified on  : 08-10-2020
 * @last modified by  : shafaqbashir
 * Modifications Log 
 * Ver   Date         Author         Modification
 * 1.0   08-10-2020   shafaqbashir   Initial Version
**/

public class ContactProductQueryServices {
  public static Id getProductEntry(String productId, String homeCountry) {

    return [SELECT Id, Product2.Name, ATM_Fee_in_other_currencies__c, Card_Replacement_Cost__c, Cost_per_Calendar_Month__c, Pricebook2.Name, CurrencyIsoCode FROM PricebookEntry WHERE Pricebook2.Name  = : homeCountry AND Product2Id = : productId LIMIT 1].Id;
  }

  public static List<PricebookEntry> getProductEntries(Set<Id> productList, Set<String> homeCountryList) {

    return [SELECT Id, Product2Id, Product2.Name, ATM_Fee_in_other_currencies__c, Card_Replacement_Cost__c, Cost_per_Calendar_Month__c, Pricebook2.Name, CurrencyIsoCode FROM PricebookEntry WHERE Pricebook2.Name  In : homeCountryList AND Product2Id In : productList];
  }
  public static List<Contact> getContacts(Set<String> uuidList) {

    return [SELECT Id, Product__c, UUID__c, Home_Country__c FROM Contact WHERE UUID__c IN :uuidList];
  }

}