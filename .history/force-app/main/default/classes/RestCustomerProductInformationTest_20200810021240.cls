/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-10-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   08-10-2020   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
@isTest
public class RestCustomerProductInformationTest {
  @TestSetup
  static void setup(){
      TestSetup.setupCustomerProductInformation();
  }

  @isTest
  static void testProducInformationWithRecords() {
    RestRequest req = new RestRequest();
    RestContext.request = req;
    RestResponse res = new RestResponse();
    RestContext.response = res;
    
    Contact con = [SELECT Id, Product__c, Home_Country__c, UUID__c FROM Contact LIMIT 1];
    
    RestCustomerProductInformation.CustomerProductInformationResponse customerProductRepsonse = RestCustomerProductInformation.getCustomerProductInformation(new List<String>{con.UUID__c});
    
    PricebookEntry priceBookEntryItem = [SELECT Id, Product2Id, Product2.Name, ATM_Fee_in_other_currencies__c, Card_Replacement_Cost__c, Cost_per_Calendar_Month__c, Pricebook2.Name, CurrencyIsoCode FROM PricebookEntry WHERE Pricebook2.Name = : con.Home_Country__c AND Product2Id = : con.Product__c];
    System.assertEquals('success', customerProductRepsonse.message);
    
    System.assertEquals(con.UUID__c, customerProductRepsonse.customerProductInfoList.get(0).uuid);
    System.assertEquals(con.Home_Country__c, customerProductRepsonse.customerProductInfoList.get(0).home_country);
    
    System.assertEquals(priceBookEntryItem.Product2.Name, customerProductRepsonse.customerProductInfoList.get(0).product_name);
    System.assertEquals(priceBookEntryItem.ATM_Fee_in_other_currencies__c, customerProductRepsonse.customerProductInfoList.get(0).atm_fee_in_other_currencies);
    System.assertEquals(priceBookEntryItem.Cost_per_Calendar_Month__c, customerProductRepsonse.customerProductInfoList.get(0).cost_per_calendar_month);
    System.assertEquals(priceBookEntryItem.Card_Replacement_Cost__c, customerProductRepsonse.customerProductInfoList.get(0).card_replacement_cost);
    System.assertEquals(priceBookEntryItem.CurrencyIsoCode, customerProductRepsonse.customerProductInfoList.get(0).currency_iso_code);   
  }
    
  @isTest
  static void testProducInformationWithNoRecords() {
    RestRequest req = new RestRequest();
    RestContext.request = req;
    RestResponse res = new RestResponse();
    RestContext.response = res;

    RestCustomerProductInformation.CustomerProductInformationResponse customerProductRepsonse = RestCustomerProductInformation.getCustomerProductInformation(new List<String>());
    System.assertEquals('error', customerProductRepsonse.message);
      
  }
}