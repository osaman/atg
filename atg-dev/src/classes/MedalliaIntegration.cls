public class MedalliaIntegration {
     
    // The postTransaction method integrates Salesforce system
    // with the NPS system (Medallia)
	private static String REST_ENDPOINT = 'https://edemo.medallia.com/mainstreet.feed';
	private static String CONTENT_TYPE = 'application/json';
	private static String ACCEPT = 'application/json';
    private static String username = 'john';
    private static String password = 'Ypass12';	
    
    @future (callout=true) // indicates that this is an asynchronous call
    public static void postTransaction(List<ID> TransactionIDs) {
      
        // Create a JSON generator object
        JSONGenerator gen = JSON.createGenerator(true);
        // open the JSON generator
        gen.writeStartArray();
		List<Sales_Transaction__c> Transactions = [SELECT Id, Customer__c from Sales_Transaction__c where ID IN: TransactionIDs];
        // iterate through the list of transactions passed in to the call
        // writing each detail required by Medallia in the call
        for (Sales_Transaction__c sTransaction : Transactions) {
            gen.writeStartObject();
            gen.writeStringField('transaction_id', sTransaction.Id);
			gen.writeStringField('customer_id', sTransaction.Customer__c );
            gen.writeEndObject();            
        }
        // close the JSON generator
        gen.writeEndArray();
        // create a string from the JSON generator
        String jsonTransactions = gen.getAsString();
        // debugging call, which you can check in debug logs
        System.debug('json Tansactions: ' + jsonTransactions);

        // create an HTTPrequest object    
        HttpRequest req = new HttpRequest();
		//Set EndPoing
        req.setEndpoint(REST_ENDPOINT);
        //Set User name and Password
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + 
        EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);        
        // set up the HTTP request with a method, header, and body
        req.setMethod('POST');
        req.setHeader('Content-Type', CONTENT_TYPE);
		req.setHeader('Accept', ACCEPT);
        req.setBody(jsonTransactions); 
        System.debug('SFDC Request: '+ req.getHeader('Authorization'));
        // create a new HTTP object
        Http http = new Http();
        // create a new HTTP response for receiving the remote response
        // then use it to send the configured HTTPrequest
        HTTPResponse res = http.send(req);
        // debugging call, which you can check in debug logs
        System.debug('Medallia response: '+ res.getBody());


        // Examine the status code from the HTTPResponse
        // If status code != 200, write debugging information, done
        if (res.getStatusCode() != 200) {
            System.debug('Error from ' + req.getEndpoint() + ' : ' +
              res.getStatusCode() + ' ' + res.getStatus());
        }
        // If status code = 200
        else {

        }      
    }
}