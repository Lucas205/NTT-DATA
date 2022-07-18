        /*
_____________________________________________________________    
@author: Lucas Araujo.
@description: Apex Class  for accounts : inactive accounts. 
_____________________________________________________________
*/
public  class AccountInactive {
    public static List<Account> inactiveAccount(List<Account> accs){
        List<Account> accListUp = new List<Account>();
        for(Account acc : accs){
            acc.Inativa__c = true;
            accListUp.add(acc);
        }
        
        return accListUp;
    }
}
