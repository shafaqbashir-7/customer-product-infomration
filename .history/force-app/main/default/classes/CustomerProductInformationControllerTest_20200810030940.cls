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

@isTest
public class CustomerProductInformationControllerTest {
  @TestSetup 
  static void setup(){
    TestSetup.setupCustomerProductInformation();
    
  }

  @isTest
  static void getProductInfo() {
    Case c = [SELECT Id FROM Case LIMIT 1];
    Id priceBookEntryId = CustomerProductInformationController.getProductInfo(c.Id);
    
    System.assertEquals([SELECT Id, Product2Id, Pricebook2.Name FROM PricebookEntry WHERE Pricebook2.Name  = : con.Home_Country__c AND Product2Id = : con.Product__c LIMIT 1].Id, priceBookEntryId);
  }
}