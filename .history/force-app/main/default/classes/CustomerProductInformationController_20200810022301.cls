/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-09-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   08-09-2020   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
public with sharing class CustomerProductInformationController {
  @AuraEnabled(cacheable=true)
  public static Id getProductInfo(String ProductId, String homeCountry) {
      
      return ContactProductQueryServices.getProductEntry(ProductId, homeCountry);
  }
}