/**
 * @description       : Apex controller for lwc "customerProductInformation"
 * @author            : shafaqbashir
 * @group             : 
 * @last modified on  : 08-10-2020
 * @last modified by  : shafaqbashir
 * Modifications Log 
 * Ver   Date         Author         Modification
 * 1.0   08-10-2020   shafaqbashir   Initial Version
**/
public with sharing class CustomerProductInformationController {
  @AuraEnabled(cacheable=true)
  public static Id getProductInfo(String ProductId, String homeCountry) {
      
      return ContactProductQueryServices.getProductEntry(ProductId, homeCountry);
  }
}