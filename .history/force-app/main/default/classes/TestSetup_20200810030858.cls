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

public class TestSetup {
  public static void setupCustomerProductInformation() {
    ID standardPBID = Test.getStandardPricebookId();
    Pricebook2  priceBook = new Pricebook2 (Name = 'DE', isActive=true);	
    insert priceBook;
    Product2 myProduct = new Product2(Name = 'Test', ProductCode = 'Test', Family = 'Test', IsActive = true);
    insert myProduct;
    PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = standardPBID, Product2Id = myProduct.Id, UnitPrice = 100, IsActive = true,  currencyISOCode = 'EUR');
    insert standardPrice;
    PricebookEntry pricebe = new PricebookEntry(Pricebook2Id = priceBook.Id, Product2Id = myProduct.Id, UnitPrice = 150, IsActive = true, ATM_Fee_in_other_currencies__c = 0.01, Card_Replacement_Cost__c = 5,Cost_per_Calendar_Month__c = 6, CurrencyIsoCode = 'EUR' );
    insert pricebe;
    Account acc = new Account(Name = 'Test Account');
    insert acc;
    Contact con = new Contact(FirstName = 'John', LastName = 'Doe', AccountId = acc.Id, UUID__c = '2345', Product__c = myProduct.Id, Home_Country__c = 'DE');
    insert con;
    Case c = new Case(ContactId = con.Id);
    insert c;    
  }

}