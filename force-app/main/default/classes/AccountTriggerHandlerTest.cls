/*
_____________________________________________________________    
@author: Lucas Araujo.
@description: Apex class Test for coverage code base. 
_____________________________________________________________
*/
@isTest
public class AccountTriggerHandlerTest {
    
    @isTest
    static void testSucces(){
        Id PERCEIRO = Schema.Sobjecttype.Account.getRecordTypeInfosByDeveloperName().get('Parceiro').getRecordTypeId();
        Id  CONSUMIDOR_FINAL = Schema.Sobjecttype.Account.getRecordTypeInfosByDeveloperName().get('Consumidor_Final').getRecordTypeId();
        Id  OTHER = Schema.Sobjecttype.Account.getRecordTypeInfosByDeveloperName().get('Other').getRecordTypeId();
        
        List<Account> accListSuccess = new List<Account>();

        Account acc = new Account(RecordTypeId = PERCEIRO,
                                  Name = 'Account For Test PERCEIRO',
                                  Active__c = 'Yes',
                                  AccountNumber = '00000000000',
                                  Type = 'CPF'
                                  );
        
        Account acc1 = new Account(RecordTypeId = OTHER,
                                  Name = 'Account For Test OTHER',
                                  Active__c = 'Yes',
                                  AccountNumber = '00000000000',
                                  Type = 'CPF'
                                  );
        

        Account acc2 = new Account(RecordTypeId = CONSUMIDOR_FINAL,
                                   Name = 'Account For Test CONSUMIDOR_FINAL',
                                   Active__c = 'Yes',
                                   AccountNumber = '00000000000000',
                                   Type = 'CNPJ'
                                  );
        accListSuccess.add(acc);
        accListSuccess.add(acc1);        
        accListSuccess.add(acc2);        
        
        Test.startTest();
            insert accListSuccess;

            List<Opportunity> opps = [
                                    SELECT 
                                            Id,
                                            Name,
                                            AccountId,
                                            CloseDate,
                                            StageName
                                    FROM 
                                            Opportunity
                                    ];
            system.assertEquals(1, opps.size());                                     
            system.assertEquals(accListSuccess[0].Id, opps[0].AccountId);
            system.assertEquals(Date.today().addDays(30), opps[0].CloseDate);
            system.assertEquals('Qualification', opps[0].StageName);
            system.assert(opps[0].Name.equals('Account For Test PERCEIRO – opp Parceiro'));

        Test.stopTest();                                 
    }
}
