global class AccountStatisticsResetBatch implements database.batchable<sobject> {
	// reset all statistics to 0 the run the calculation
	
	Public string queryString;
		
	global database.querylocator start(database.batchableContext bc){
		return database.getquerylocator('select id, name from Account');
	}
	
	global void execute(database.batchablecontext bd, list<Account> accounts){
	    for ( Account a: accounts ) {
	        a.Calls_Last_30_Days__c = 0;
	        a.Calls_Last_60_Days__c = 0;
	        a.Calls_Last_90_Days__c = 0;
  
	    }
	    update accounts;
	}
	
	Public void finish(database.batchableContext bc){ 
	    Id batchJobId = Database.executeBatch(new AccountStatisticsCalculateBatch(), 200);
	    
	}
}