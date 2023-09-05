trigger contactTrigger on Contact (after insert, after update, after delete, after undelete) {

    switch on Trigger.operationType {
        when  AFTER_INSERT{
            contactTriggerHandler.afterInsertHandler(Trigger.new);                             
        }


        when  AFTER_UPDATE{
            contactTriggerHandler.afterUpdateHandler(Trigger.new, Trigger.oldMap);                                                             
        }
        
        when AFTER_DELETE {
            contactTriggerHandler.afterDeleteHandler(Trigger.old);                             
        }

        when AFTER_UNDELETE {
            contactTriggerHandler.afterUnDeleteHandler(Trigger.new);                             
        }
    }
}