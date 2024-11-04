@IsTest
public with sharing class bbcTest {
    @testSetup
    static void setup() {

        TestDataFactory.createBBCArticles(10);

        Articles__c setting = new Articles__c();
        setting.Most_Read__c = 10;
        setting.Name = 'BBC';
        setting.News__c = 'BBC';
        insert setting;

    }

    
    @IsTest
    static void testFetchTopArticlesWithPermissions() {
        
        User allowedUser = TestDataFactory.createPermittedUser();

        Test.startTest();
        System.runAs(allowedUser) {
            List<BBC_Article__c> articles = bbc.fetchTopArticles();
            System.assertEquals(10, articles.size(), 'Expected 10 articles to be returned for a user with permissions');
        }
        Test.stopTest();
    }

    @IsTest
    static void testFetchTopArticlesEmpty() {
        
        delete [SELECT Id FROM BBC_Article__c];

        
        Test.startTest();
        
                List<BBC_Article__c> articles = bbc.fetchTopArticles();
                System.assertEquals(0, articles.size(), 'Expected 0 articles to be returned when no articles exist');

        Test.stopTest();
    }
}