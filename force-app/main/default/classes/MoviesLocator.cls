public class MoviesLocator {
    @future(callout = true)
    public static void getOverviewByMovieName(String movieName){
        String overview = '';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.themoviedb.org/3/search/movie?api_key=d326af08bc29ca22831878531cb9c7cf&language=en-US&query='+movieName+'&page=1&include_adult=false');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = 
                (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'movies' key as a list
            List<Object> movies = (List<Object>)results.get('results');
            // Cast the values in the 'overviews' key for first object in List
            Map<String, Object> overviews = 
                (Map<String, Object>) movies[0];
            //Save the overview in the string variable
            overview = (string.valueOf(overviews.get('overview'))); 
            //
            //Select the movie by the name
          	Movie__c mov = [SELECT Name FROM Movie__c where Name =: movieName];
            
            //Update the review of the movie selected
            mov.Review__c = overview;
            
            //Upsert the field in th data base
            upsert mov;
        }
    }
}