public with sharing class bbc {
    @AuraEnabled(cacheable=true)
    public static List<BBC_Article__c> fetchTopArticles() {
       
            Integer mostReadLimit = 10;
            Articles__c setting = Articles__c.getValues('BBC');
 
            if (setting != null && setting.Most_Read__c != null) {
                mostReadLimit = setting.Most_Read__c.intValue();
            }

            List<BBC_Article__c> articles = [
                SELECT Title__c, URL__c, Rank__c 
                FROM BBC_Article__c
                WITH SECURITY_ENFORCED 
                ORDER BY Rank__c ASC 
                LIMIT :mostReadLimit
            ];

            if (articles == null || articles.isEmpty()) {
                return new List<BBC_Article__c>();
            }

            return articles;

       
    }
}