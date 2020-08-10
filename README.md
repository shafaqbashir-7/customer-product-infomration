# Overall Soultion Description

The solution is designed to display the customer product's information on case page layout and rest API to call for external system to fetch product information from salesforce.

## How the information is stored

For storing information I have considered the following `sObjects` to be in use

-   ### `Case`
    -   ContactId
-   ### `Contact`
    -   Product (Lookup to product `sObject`)
    -   Home Country (text field storing the information about the country)
-   ### `Product`

    -   Name
    -   Product Currency
    -   Product Code
    -   Quantity Unit Of Measure

-   ### `PriceBook`
    PriceBook corresponds to the Home Country field on Contact level, for every country there will be a seperate PriceBookEntry
    -   Price Book Name (Home Country)
    -   isActive (needs to active for to be useable)
-   ### `PriceBookEntry`
    -   Product2 (Product in use)
    -   PriceBook2 (related price book based on the Home Country)
    -   Currency type

## How it works

#### Display Information on Case Page layout.

###### ProductInformation (Lightning aura Component)

-   This Component is created to display the product information on case page layout level.
-   `ProductInformation` store the value of `Contact.Product_c` and `Contact.HOme_Country_c` field by using RecordData on page load and pass it to the `productInformationController.js`
-   Inside the `productInformationController.js` an `apexController` `ProductInformationController.cls` is called which query the `pricebookEntry` based on the input values.
-   `PricebookEntry` product information is the displayed on page layout using `recordFormView`.

###### CustomerProductInformation (Lightning Web Component)

-   This `lwc` is created to display the product information on case page layout level.
-   `CustomerProductInformation` uses two wire adaptors
-   `getRecord` to get the `Contact.Product_c` and `Contact.Home_Contry_c` using the `caseId`.
-   apexwire Adaptor called `CustomerProductInformation.getProductInfo` to query the `pricebookEntry` based on the input values.
-   the `PricebookEntry` is the displayed on page layout using `recordFormView`.

#### RESTApi to fetch data from Salesforce

The RestApi is designed to return multiple `customerProductInformation`
records based on multiple contact information

###### Endpoint

    /services/data/apexrest/customerproductinformation/getCustomerProductInformation

###### POST

The API only supports the POST method.
Here is the `JSONSchema` representing the request body:

```json
{
  "$schema": "http://json-schema.org/draft-07/schema",
  "type": "object",
  "examples": [{
    "uuidList": [
      "961e003a-db08-11ea-87d0-0242ac130003"
    ]
  }],
  "required": [
    "uuidList"
  ],
  "properties": {
    "uuidList": {
      "type": "array",
      "items": {
        "anyOf": [{
          "type": "string",
        }]
      }
    }
  },
}
```

###### RESPONSE

###### `200`

Here is a `JSONSchema` representing the response we get from the API.

```json
{
	"$schema": "http://json-schema.org/draft-07/schema",

	"type": "array",
	"items": {
		"$id": "#/items",
		"anyOf": [{
			"type": "object",
			"examples": [{
				"CustomerProductInformationResponse": {
					"message": "succesS",
					"customerProductInfoList": {
						"ProductInformationWrapper": {
							"uuid": "sadas",
							"product_name": "sdsds",
							"atm_fee_in_other_currencies": "22.5",
							"card_replacement_cost": "22.5",
							"cost_per_calendar_month": "33.5",
							"currency_iso_code": "sdsfcsdfs"
						}
					}
				}
			}],
			"required": [
				"CustomerProductInformationResponse"
			],
			"properties": {
				"CustomerProductInformationResponse": {
					"type": "object",
					"required": [
						"message",
						"customerProductInfoList"
					],
					"properties": {
						"message": {
							"type": "string"
						},
						"customerProductInfoList": {
							"type": "object",
							"required": [
								"ProductInformationWrapper"
							],
							"properties": {
								"ProductInformationWrapper": {
									"type": "object",
									"required": [
										"uuid",
										"product_name",
										"atm_fee_in_other_currencies",
										"card_replacement_cost",
										"cost_per_calendar_month",
										"currency_iso_code"
									],
									"properties": {
										"uuid": {
											"type": "string"
										},
										"product_name": {
											"type": "string"
										},
										"atm_fee_in_other_currencies": {
											"type": "number"
										},
										"card_replacement_cost": {
											"type": "number"
										},
										"cost_per_calendar_month": {
											"type": "number"
										},
										"currency_iso_code": {
											"type": "string"
										}
									}
								}
							}
						}
					}
				}
			}
		}]
	}
}    
```

TESTING

-   Tests are written to cover the all the possible scenarios
-   JEST Unit for `lwc` component
-   I have tried writting jest unit testing for `lwc` component but since i used two different type of `wireAdaptors` in my controller class, i kept running into issues.As my knowledge in jest unit testing is very limited and salesforce doesnt have a good documentation on how to do it. I couldnt move forward with this. 
-   One other possible way is to use single `wireAdaptor` and use the neccesary code to `ApexController` and write jest unit. 
