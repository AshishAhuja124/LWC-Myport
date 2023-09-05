public with sharing class contactTriggerHandler {
    public static void afterInsertHandler(List<Contact> newContacts) {
        Set<Id> accountIds = new Set<Id>();// Getting all unique ids
            for(Contact con: newContacts) {
                if(String.isNotBlank(con.AccountId)) {
                    accountIds.add(con.AccountId);//Add ing all accounts ids
                } 
            }
            AccountContactService.updateActiveContacts(accountIds); 
    }

    public static void afterUpdateHandler(List<Contact> newContacts, Map<Id, Contact> oldContactsMap) {
        Set<Id> accountIds = new Set<Id>();
            for(Contact con: newContacts) {
                //Capture the acconnt id only if active checckbox value is changed
                if(String.isNotBlank(con.AccountId) && oldContactsMap.get(con.Id).Active__c != con.Active__c) {
                    accountIds.add(con.AccountId);//Add ing all accounts ids
                } 
                else if(oldContactsMap.get(con.Id).AccountId != con.AccountId ) {
                    accountIds.add(con.AccountId);
                    accountIds.add(oldContactsMap.get(con.Id).AccountId);
                }
            }
            AccountContactService.updateActiveContacts(accountIds); 
    }

    public static void afterDeleteHandler(List<Contact> oldContacts) {
        Set<Id> accountIds = new Set<Id>();
            for(Contact con: oldContacts) {
                if(String.isNotBlank(con.AccountId)) {
                    accountIds.add(con.AccountId);
                } 
            }
        AccountContactService.updateActiveContacts(accountIds); 
    }

    public static void afterUnDeleteHandler(List<Contact> newContacts) {
        Set<Id> accountIds = new Set<Id>();// Getting all unique ids
            for(Contact con: newContacts) {
                if(String.isNotBlank(con.AccountId)) {
                    accountIds.add(con.AccountId);//Add ing all accounts ids
                } 
            }
        AccountContactService.updateActiveContacts(accountIds); 
    }
}