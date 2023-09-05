public with sharing class AccountContactService {
    public static void updateActiveContacts(Set<Id> accountIds) {
        List<AggregateResult> results =  [SELECT AccountId,COUNT(Id) totalContacts  FROM Contact 
                                                    where Active__c = true AND AccountId IN : accountIds 
                                                    GROUP BY AccountId];
                    List<Account> accountsToUpdate = new List<Account>();
                    for(AggregateResult result: results) {
                        //get account id and no. of active accounts
                        String accId = String.valueof(result.get('AccountId'));
                        Integer totalContacts = Integer.valueof(result.get('totalContacts'));

                        Account acc = new Account(Id = accId, Active_Contacts__c = totalContacts);
                        accountsToUpdate.add(acc);
                    } 
                    update accountsToUpdate; 
    }
}