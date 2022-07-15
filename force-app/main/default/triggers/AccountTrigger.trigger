/*
_____________________________________________________________    
@author: Lucas Araujo.
@description: Account Trigger Records.
@params: before insert ; before update. 
_____________________________________________________________
*/
trigger AccountTrigger on Account(before insert, before update, after insert) {
    if(Trigger.isBefore) {
        AccountTriggerHandler.validate(Trigger.new);
    }

    if(Trigger.isInsert && Trigger.isAfter) {
        AccountTriggerHandler.builder(Trigger.new);
    }
}