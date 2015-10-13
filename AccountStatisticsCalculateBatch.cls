global class AccountStatisticsCalculateBatch implements database.batchable<sobject> {
	// calculate statistics
	
	Public string queryString;

	global database.querylocator start(database.batchableContext bc){
		return database.getquerylocator('select id, name from Account');
	}
	
	global void execute(database.batchablecontext bd, list<Account> accounts){
	    List<Account> accountsToUpdate = new List<Account>();
	 
	    calcCallsLast30Days( accounts );
	    calcCallsLast60Days( accounts );
	    calcCallsLast90Days( accounts );
	}
	
	private void calcCallsLast30Days( List<Account> accounts) {
        List<Account> accountsToUpdate = new List<Account>();
        Date last30DaysDate = Date.Today() - 30;

        AggregateResult[] arList = [Select AccountId, count(id) total from Task where AccountId in :accounts and CreatedDate >= :last30DaysDate and Type Like 'Call%' group by AccountId];
        for ( AggregateResult ar: arList ) {
            accountsToUpdate.add( new Account( Id = String.valueOf(ar.get('AccountId')), Calls_Last_30_Days__c = Integer.valueOf(ar.get('total')) ) );
        } 
        update accountsToUpdate; 
	}
	
    private void calcCallsLast60Days( List<Account> accounts) {
        List<Account> accountsToUpdate = new List<Account>();
        Date last60DaysDate = Date.Today() - 60;

        AggregateResult[] arList = [Select AccountId, count(id) total from Task where AccountId in :accounts and CreatedDate >= :last60DaysDate and Type Like 'Call%' group by AccountId];
        for ( AggregateResult ar: arList ) {
            accountsToUpdate.add( new Account( Id = String.valueOf(ar.get('AccountId')), Calls_Last_60_Days__c = Integer.valueOf(ar.get('total')) ) );
        } 
        update accountsToUpdate; 
	}
	
	private void calcCallsLast90Days( List<Account> accounts) {
        List<Account> accountsToUpdate = new List<Account>();
        Date last90DaysDate = Date.Today() - 90;

        AggregateResult[] arList = [Select AccountId, count(id) total from Task where AccountId in :accounts and CreatedDate >= :last90DaysDate and Type Like 'Call%' group by AccountId];
        for ( AggregateResult ar: arList ) {
            accountsToUpdate.add( new Account( Id = String.valueOf(ar.get('AccountId')), Calls_Last_90_Days__c = Integer.valueOf(ar.get('total')) ) );
        } 
        update accountsToUpdate; 
	}
	
	
	Public void finish(database.batchableContext bc){ 
	}
    
}