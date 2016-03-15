trigger SalesTransactionTrigger on Sales_Transaction__c (after insert) {

    // Create a list of IDs to all of the inserted Sales Transactions
    List<Id> TransactionIDs = new List<Id>();
    for (Sales_Transaction__c sTransaction: Trigger.new) {
        TransactionIDs.add(sTransaction.Id);
    }
    // If the list of IDs is not empty, call MedalliaIntegration.postTransaction
    if (TransactionIDs.size() > 0) {
        MedalliaIntegration.postTransaction(TransactionIDs);
    }
}