/*
_____________________________________________________________    
@author: Lucas Araujo.
@description: Account Trigger Handler. 
_____________________________________________________________
*/
public class AccountTriggerHandler {
    public static final String PHYSICAL_PERSON = 'CPF';
    public static final String LEGAL_PERSON = 'CNPJ';
    public static final Id PERCEIRO = Schema.Sobjecttype.Account.getRecordTypeInfosByDeveloperName().get('Parceiro').getRecordTypeId();
    public static final Id  CONSUMIDOR_FINAL = Schema.Sobjecttype.Account.getRecordTypeInfosByDeveloperName().get('Consumidor_Final').getRecordTypeId();

    public static void validate(List<Account> accs){

        for(Account acc : accs){
            if(acc.Type == PHYSICAL_PERSON){
                if(!Utils.ValidaCPF(String.valueOf(acc.AccountNumber))){
                    acc.AccountNumber.addError('Número do cliente é inválido');    
                }
            } 
            
            if(acc.Type == LEGAL_PERSON){
                if(!Utils.ValidaCNPJ(String.valueOf(acc.AccountNumber))){
                    acc.AccountNumber.addError('Número do cliente é inválido');    
                }
            } 
        }
    }

    public static void builder(List<Account> accs){
        
        for(Account acc : accs){
            if(acc.RecordTypeId == PERCEIRO){
                try{
                    Opportunity opp = Repository.accountWithOpp(acc);
                    insert opp;
                }catch(Exception ex){
                    System.debug('ERROR CREATE OPP THE ACCOUNT:' + acc.Id);
                    System.debug('Message: ' +  ex.getMessage());
                }
            }

            if(acc.RecordTypeId == CONSUMIDOR_FINAL){
                try{
                    Case newCase = Repository.accountWithCase(acc);
                    insert newCase;
                }catch(Exception ex){
                    System.debug('ERROR CREATE CASE THE ACCOUNT:' + acc.Id);
                    System.debug('Message: ' +  ex.getMessage());
                }
            }
        }
    }
}