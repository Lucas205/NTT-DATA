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
                            +'    Inativa__c,'
                            +'    LastActivityDate,'
                            +'    (SELECT'
                            +'            Id,'
                            +'            Name,'
                            +'            AccountId,'
                            +'            StageName'
                            +'     FROM'
                            +'          Opportunities'
                            +'     WHERE'
                            +'          (Account.LastActivityDate != LAST_N_DAYS:90)'
                            +'      OR'
                            +'          (CreatedDate = LAST_N_DAYS:120 AND isWon = false AND isClosed = false)'
                            +'      OR'
                            +'          (StageName = \'Closed Lost\')'
                            +'      )'                                               
                            +'  FROM'
                            +'      Account'
                            +'  WHERE'
                            +'      Id NOT IN'
                            +'              (SELECT'
                            +'                      AccountId'
                            +'              FROM'
                            +'                  Opportunity'
                            +'              WHERE'
                            +'                  (Account.LastActivityDate = LAST_N_DAYS:90)'
                            +'              OR'
                            +'                  (CreatedDate = LAST_N_DAYS:120 AND isWon = true AND isClosed = true)'
                            +'              OR'
                            +'                  (StageName != \'Closed Lost\')'
                            +'      )'       
        );

    }
    
    public void execute(Database.BatchableContext bc, List<Account> accList) {
        System.debug('AccountBatch:Execute has started...');
        List<Account> accUp = AccountInactive.inactiveAccount(accList);
        update accUp;
    }       
    
    public void finish(Database.BatchableContext bc){
        System.debug('AccountBatch:finish method has started...');
    }
}