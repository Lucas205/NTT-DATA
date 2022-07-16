/*
_____________________________________________________________    
@author: Lucas Araujo.
@description: Batch  for accounts : clean accounts. 
_____________________________________________________________
*/
public  class AccountBatch implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
                            'SELECT'
                            +'    Id,'
                            +'    Name,'
                            +'    Inativa__c'
                            +'  FROM'
                            +'      Account'
                            +'  WHERE'
                            +'      Inativa__c = false'
        );
    }
    
    public void execute(Database.BatchableContext bc, List<Account> accList) {
        System.debug('AccountBatch:Execute has started...');
        Set<Id> accIds = new Set<Id>();
        for(Account acc: accList){
            accIds.add(acc.Id);
        }
        List<Account> accUp = AccountInactive.inactiveAccount(accIds);
        update accUp;
    }       
    
    public void finish(Database.BatchableContext bc){
        System.debug('AccountBatch:finish method has started...');
    }
}