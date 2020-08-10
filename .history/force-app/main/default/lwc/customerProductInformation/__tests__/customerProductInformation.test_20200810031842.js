import { createElement } from 'lwc';
import CustomerProductInformation from 'c/customerProductInformation';
import { registerApexTestWireAdapter } from '@salesforce/sfdx-lwc-jest';
import getProductInfo from '@salesforce/apex/CustomerProductInformationController.getProductInfo';
