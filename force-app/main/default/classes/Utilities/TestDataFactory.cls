@IsTest
public class TestDataFactory {

    public static void createBBCArticles(Integer count) {
        List<BBC_Article__c> articles = new List<BBC_Article__c>();

        for (Integer i = 1; i <= count; i++) {
            articles.add(new BBC_Article__c(
                Title__c = 'Article ' + i,
                URL__c = 'https://www.example.com/article' + i,
                Rank__c = i
            ));
        }
        insert articles;
    }

    public static User createRestrictedUser() {
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        Id roleId = [SELECT Id FROM UserRole LIMIT 1].Id; 

        User restrictedUser = new User(
            ProfileId = profile.Id,
            UserRoleId = roleId,
            Username = 'restricteduser' + Math.random() + '@test.com',
            Email = 'restricteduser' + Math.random() + '@test.com',
            LastName = 'Restricted',
            Alias = 'restr' + String.valueOf(Math.round(Math.random() * 100)),
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert restrictedUser;
        return restrictedUser;
    }
    
    public static User createPermittedUser() {
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        Id roleId = [SELECT Id FROM UserRole LIMIT 1].Id; 

        User allowedUser = new User(
            ProfileId = profile.Id,
            UserRoleId = roleId,
            Username = 'alloweduser' + Math.random() + '@test.com',
            Email = 'alloweduser' + Math.random() + '@test.com',
            LastName = 'Allowed',
            Alias = 'allow' + String.valueOf(Math.round(Math.random() * 100)),
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert allowedUser;

        
        PermissionSet permissionSet = [SELECT Id FROM PermissionSet WHERE Name = 'Sales_Manager' LIMIT 1];
        insert new PermissionSetAssignment(
            AssigneeId = allowedUser.Id,
            PermissionSetId = permissionSet.Id
        );

        return allowedUser;
    }
}