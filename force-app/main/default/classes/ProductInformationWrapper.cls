/**
 * @description       : Wrapper Class For RestAPI 
 * @author            : shafaqbashir
 * @group             : 
 * @last modified on  : 08-10-2020
 * @last modified by  : shafaqbashir
 * Modifications Log 
 * Ver   Date         Author         Modification
 * 1.0   08-10-2020   shafaqbashir   Initial Version
**/
global class ProductInformationWrapper {
  public String uuid                        { get; set; }
  public String product_name                { get; set; }
  public String home_country                { get; set; }
  public Double atm_fee_in_other_currencies { get; set; }
  public Double card_replacement_cost       { get; set; } 
  public Double cost_per_calendar_month     { get; set; }
  public String currency_iso_code           { get; set; }

  global ProductInformationWrapper(String uuid, PricebookEntry priceBookEntry) {
    this.uuid                        = uuid;
    this.product_name                = priceBookEntry.Product2.Name;
    this.home_country                = priceBookEntry.Pricebook2.Name;
    this.atm_fee_in_other_currencies = priceBookEntry.ATM_Fee_in_other_currencies__c;
    this.card_replacement_cost       = priceBookEntry.Card_Replacement_Cost__c;
    this.cost_per_calendar_month     = priceBookEntry.Cost_per_Calendar_Month__c;
    this.currency_iso_code           = priceBookEntry.CurrencyIsoCode;
  }
}