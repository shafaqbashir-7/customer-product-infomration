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
public class ProductInformationControllerTest {
  @TestSetup
  static void setup(){
      TestSetup.setupCustomerProductInformation();
  }
  
  @isTest
  static void getProductInfo() {
    Contact con = [SELECT Id, Product__c, Home_Country__c, UUID__c FROM Contact LIMIT 1];
    Id priceBookEntryId = ProductInformationController.getProductInfo(con.Product__c, con.Home_Country__c);
    
    System.assertEquals([SELECT Id, Product2Id, Pricebook2.Name FROM PricebookEntry WHERE Pricebook2.Name  = : con.Home_Country__c AND Product2Id = : con.Product__c LIMIT 1].Id, priceBookEntryId);
  }

}