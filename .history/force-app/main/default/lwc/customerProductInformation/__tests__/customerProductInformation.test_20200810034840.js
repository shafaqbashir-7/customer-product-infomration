import { createElement } from 'lwc';
import CustomerProductInformation from 'c/customerProductInformation';
import { registerApexTestWireAdapter } from '@salesforce/sfdx-lwc-jest';
import getProductInfo from '@salesforce/apex/CustomerProductInformationController.getProductInfo';

// Realistic data with a list of contacts
const mockGetProductList = require('./data/getProductInfo.json');

  
// Register as Apex wire adapter. Some tests verify that provisioned values trigger desired behavior.
const getProductInfoAdapter = registerApexTestWireAdapter(getProductInfo);

describe('c-customer-product-information', () => {
  afterEach(() => {
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
    // Prevent data saved on mocks from leaking between tests
    jest.clearAllMocks();
  });
  describe('getProductInfo @wire data', () => {
    it('renders six records', () => {
      const element = createElement('c-wire-c-customer-product-information', {
        is: CustomerProductInformation
      });

      document.body.appendChild(element);
  
      // Emit data from @wire
      getProductInfoAdapter.emit(getProductInfo);
  
      return Promise.resolve().then(() => {
        // Select elements for validation
        const form = element.shadowRoot.querySelector('lightning-record-form');
        expect(form).toBeTruthy();
      });
    });
  });
});