import { createElement } from 'lwc';
import CustomerProductInformation from 'c/customerProductInformation';
import { registerApexTestWireAdapter } from '@salesforce/sfdx-lwc-jest';
import getProductInfo from '@salesforce/apex/CustomerProductInformationController.getProductInfo';

// Realistic data with a list of contacts
const mockGetProductList = require('./data/getProductInfo.json');

  
// Register as Apex wire adapter. Some tests verify that provisioned values trigger desired behavior.
const getProductInfoAdapter = registerApexTestWireAdapter(getProductInfo);

