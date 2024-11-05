public with sharing class bbc {

    @AuraEnabled(cacheable=true)
    public static String fetchRawHtml() {
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            
            request.setEndpoint('callout:BBC');
            request.setMethod('GET');
            
            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 200) {
                return response.getBody(); 
            } else {
                throw new AuraHandledException('Failed to retrieve content from BBC');
            }
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching content: ' + e.getMessage());
        }
    }
}
