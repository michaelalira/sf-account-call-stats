global class ScheduleCalculateAccountStatistics implements Schedulable {
    global void execute(SchedulableContext sc) {
        Id batchJobId = Database.executeBatch(new AccountStatisticsResetBatch(), 200);
    }
}