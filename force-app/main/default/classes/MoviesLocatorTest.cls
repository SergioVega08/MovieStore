@isTest
public class MoviesLocatorTest{
    @isTest 
    static void getOverviewByName() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MoviesLocatorMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        
        Test.startTest();
        MoviesLocator.getOverviewByMovieName('titanic');
        Test.stopTest();
        
        List <Movie__c> movlist = [Select Name, Review__c from Movie__c where Name =:'titanic'];
        
        System.assertEquals(1, movlist.size());
        // Verify that the response received contains fake values
        System.assertEquals('101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic, 84 years later. A young Rose boards the ship with her mother and fiancé. Meanwhile, Jack Dawson and Fabrizio De Rossi win third-class tickets aboard the ship. Rose tells the whole story from Titanics departure through to its death—on its first and last voyage—on April 15, 1912.', movlist[0].Review__c);
    }
}