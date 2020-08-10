@RestResource(urlMapping='/customerproductinformation/*')
global class RestCustomerProductInformation {
    global static final Integer SUCCESS = 200;
  	global static final Integer NOT_FOUND = 404;
  	global static final Integer BAD_REQUEST = 400;
  	global static final Integer SERVER_ERROR = 500;

    @HttpPost
    global static CustomerProductInformationResponse getCustomerProductInformation(List<String> uuidList) {
		RESTRequest req  = RESTContext.request;
        RESTResponse res = RESTContext.response;	

        try {
            if(uuidList.isEmpty()) {
                res.statusCode = BAD_REQUEST;
            	return new CustomerProductInformationResponse('error');
            }
                List<ProductInformationWrapper> customerProductInfoList = new List<ProductInformationWrapper>();
                Map<Id, Map<String, PricebookEntry>> priceBookEntryMap  = new Map<Id, Map<String, PricebookEntry>>();
                Set<Id> productList = new Set<Id>();
                Set<String> homeCountryList = new Set<String>();
            
				            System.debug('here : ');		
                List<Contact> contactList = [SELECT Id, Product__c, UUID__c, Home_Country__c FROM Contact WHERE UUID__c IN :uuidList];
            System.debug('contact : ' + contactList);
                for (Contact contactRecord : contactList) {
                    if (contactRecord.Product__c != null && contactRecord.Home_Country__c != null) {
                        productList.add(contactRecord.Product__c);
                        homeCountryList.add(contactRecord.Home_Country__c);
                    }
                }
				
                List<PricebookEntry> priceBookEntryList = [SELECT Id, Product2Id, Product2.Name, ATM_Fee_in_other_currencies__c, Card_Replacement_Cost__c, Cost_per_Calendar_Month__c, Pricebook2.Name, CurrencyIsoCode FROM PricebookEntry WHERE Pricebook2.Name  In : homeCountryList AND Product2Id In : productList];
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
            System.debug('error code : ' + e);
            System.debug('error code : ' + BAD_REQUEST);
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