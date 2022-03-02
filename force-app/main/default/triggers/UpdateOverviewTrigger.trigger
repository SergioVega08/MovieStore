trigger UpdateOverviewTrigger on Movie__c (after insert) {
    for(Movie__c mov: Trigger.new){ 
        MoviesLocator.getOverviewByMovieName(mov.Name); 
    }
}