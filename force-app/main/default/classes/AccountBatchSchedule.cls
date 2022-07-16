/*
_____________________________________________________________    
@author: Lucas Araujo.
@description: Apex Class Schedulable : Schedulable AccountBatch. 
_____________________________________________________________
*/
public class AccountBatchSchedule implements Schedulable{
    public void execute(SchedulableContext sc) {
        AccountBatch batch = new AccountBatch();
        Database.executeBatch(batch);
    }
    public static void start() {

        AccountBatchSchedule scheduler = new AccountBatchSchedule();

        System.schedule('AccountBatch  -  every 6 hours', '0 00 23,06,12,18 ? * MON-FRI *', scheduler);
    }
}