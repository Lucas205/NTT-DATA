/*
_____________________________________________________________    
@author: Lucas Araujo.
@description: Account Trigger Handler. 
_____________________________________________________________
*/
public class AccountTriggerHandler {
    public static final String PHYSICAL_PERSON = 'CPF';
    public static final String LEGAL_PERSON = 'CNPJ';

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
}
