/*
_____________________________________________________________    
@author: Lucas Araujo.
@description: Apex Class  for accounts : inactive accounts. 
_____________________________________________________________
*/
public  class AccountInactive {
    public static List<Account> inactiveAccount(Set<Id> accIds){
        Set<Id> accountIds = new Set<Id>();

        List<Account> accListByOpp =
        [
            SELECT Id, 
                    Name,
                    Inativa__c,
                    (SELECT 
                        Id,
                        Name,
                        AccountId,
                        StageName
                    FROM
                        Opportunities
                    WHERE
                        (CreatedDate = LAST_N_DAYS:120 AND StageName = 'Closed Won' AND AccountId =: accIds)
                    OR  
                        (StageName != 'Closed Lost' AND AccountId =: accIds)
                    )
            FROM
                Account
            WHERE
                Id In (
                    SELECT 
                        AccountId
                    FROM
                        Opportunity
                    WHERE
                        (CreatedDate = LAST_N_DAYS:120 AND StageName = 'Closed Won' AND AccountId =: accIds)
                    OR  
                        (StageName != 'Closed Lost' AND AccountId =: accIds)
                )
        ];
         system.debug('tamanho : ' + accListByOpp.size());
         system.debug('accs : ' + accListByOpp);
        for(Account acc : accListByOpp){
            accountIds.add(acc.Id);
        }

        system.debug(accountIds);

        List<Task> tskList = 
        [
        SELECT
            Id,
            CreatedDate, 
            AccountId
        FROM 
            Task
        WHERE 
            CreatedDate = LAST_N_DAYS:90 
        AND 
            AccountId =: accIds
        ];

        for(Task tsk : tskList){
            accountIds.add(tsk.AccountId);
        }

        system.debug(accountIds);

        List<Account> accListUp = [SELECT   
                                        Id,
                                        Inativa__c
                                    FROM 
                                        Account
                                    WHERE
                                        Id !=: accountIds
                                    AND Id =: accIds
                                    ];

        for(Account acc : accListUp){
            acc.Inativa__c = true;
        }
        
        return accListUp;
    }
}