/**
 * @description       : RestApi class for getting productInformation basedon UUIDList
 * @author            : shafaqbashir
 * @group             : 
 * @last modified on  : 08-10-2020
 * @last modified by  : shafaqbashir
 * Modifications Log 
 * Ver   Date         Author         Modification
 * 1.0   08-10-2020   shafaqbashir   Initial Version
**/

@RestResource(urlMapping='/customerproductinformation/*')
  global class RestCustomerProductInformation {
    //defining rest response statuses
  global static final Integer SUCCESS = 200;
  global static final Integer NOT_FOUND = 404;
  global static final Integer BAD_REQUEST = 400;
  global static final Integer SERVER_ERROR = 500;

  @HttpPost
  global static CustomerProductInformationResponse getCustomerProductInformation(List<String> uuidList) {
    RESTRequest req  = RESTContext.request;
    RESTResponse res = RESTContext.response;	

    try {
      if(uuidList.isEmpty()) { // return Bad request in the begining if list is empty
        res.statusCode = BAD_REQUEST;
        return new CustomerProductInformationResponse('error');
      }
      //getting required pricebookenttries for uuidList
      List<ProductInformationWrapper> customerProductInfoList = new List<ProductInformationWrapper>();
      Map<Id, Map<String, PricebookEntry>> priceBookEntryMap  = new Map<Id, Map<String, PricebookEntry>>();
      Set<Id> productList         = new Set<Id>();
      Set<String> homeCountryList = new Set<String>();
        
      List<Contact> contactList = ContactProductQueryServices.getContacts(uuidList);
            
      for (Contact contactRecord : contactList) {
        if (contactRecord.Product__c != null && contactRecord.Home_Country__c != null) {
          productList.add(contactRecord.Product__c);
          homeCountryList.add(contactRecord.Home_Country__c);
        }
      }
    
      List<PricebookEntry> priceBookEntryList = ContactProductQueryServices.getProductEntries(productList, homeCountryList);
      
      for (PricebookEntry priceBookEntry : priceBookEntryList) {
        if (priceBookEntryMap.containsKey(priceBookEntry.Product2Id)) {
          if (!priceBookEntryMap.get(priceBookEntry.Product2Id).containsKey(priceBookEntry.Pricebook2.Name)) {
            priceBookEntryMap.get(priceBookEntry.Product2Id).put(priceBookEntry.Pricebook2.Name, priceBookEntry);
          }
        } else {
          priceBookEntryMap.put(priceBookEntry.Product2Id, new Map<String, PricebookEntry>{priceBookEntry.Pricebook2.Name => priceBookEntry});
        }
      }

      for (Contact contactRecords : contactList) {
        if (priceBookEntryMap.containsKey(contactRecords.Product__c) && priceBookEntryMap.get(contactRecords.Product__c).containsKey(contactRecords.Home_Country__c)) {
          PricebookEntry priceBookEntry = priceBookEntryMap.get(contactRecords.Product__c).get(contactRecords.Home_Country__c);
          //using wrapper class to create the response
          customerProductInfoList.add(new ProductInformationWrapper(contactRecords.UUID__c, priceBookEntry));
        }
      }
      
      if (customerProductInfoList.isEmpty()) {
        res.statusCode = NOT_FOUND;
        return new CustomerProductInformationResponse('error');
      }
      res.statusCode = SUCCESS;
      return new CustomerProductInformationResponse('success', customerProductInfoList);
    }
    catch (Exception e) {
      res.statusCode = BAD_REQUEST;
      return new CustomerProductInformationResponse('error');
    }
  }

  global class CustomerProductInformationResponse {
    public String message { get; set; }
    public List<ProductInformationWrapper> customerProductInfoList { get; set; }

    global CustomerProductInformationResponse(String message) {
      this.message = message;
    }

    global CustomerProductInformationResponse(String message, List<ProductInformationWrapper> customerProductInfoList) {
      this.message                 = message;
      this.customerProductInfoList = customerProductInfoList;
    }
  }
}