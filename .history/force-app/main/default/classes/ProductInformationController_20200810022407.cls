public with sharing class ProductInformationController {
  @AuraEnabled
  public static Id getProductInfo(String ProductId, String homeCountry) {
      return ContactProductQueryServices.getProductEntry(ProductId, homeCountry);
  }
}