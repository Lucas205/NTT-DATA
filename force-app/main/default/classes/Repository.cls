/*
_____________________________________________________________    
@author: Lucas Araujo.
@description: Class Repository for make records. 
_____________________________________________________________
*/
public class Repository {
    public static Opportunity accountWithOpp(Account acc){
        return  new Opportunity(Name = acc.Name + ' – opp Parceiro',
                                AccountId = acc.Id,
                                CloseDate = Date.today().addDays(30),
                                StageName = 'Qualification'
                                );
    }

    public static Case accountWithCase(Account acc){
        return new Case(Subject = 'Consumidor Final',
                        AccountId = acc.Id,
                        Status = 'Not Started',
                        Priority = 'Medium'                
                        );
    }
}