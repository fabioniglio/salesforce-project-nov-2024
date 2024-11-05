@IsTest
public class bbcTest {
    @IsTest
    static void testFetchRawHtmlSuccess() {
       
        Test.setMock(HttpCalloutMock.class, new BBCMockHttpResponse());

        Test.startTest();
        String htmlContent = bbc.fetchRawHtml();
        Test.stopTest();

        System.assertNotEquals(null, htmlContent, 'HTML content should not be null');
        System.assert(htmlContent.contains('Sample Article Title'), 'Expected HTML content should include the sample article title');
        System.assert(htmlContent.contains('data-testid="card-order"'), 'Expected HTML content should contain the rank element');
    }

    @IsTest
    static void testFetchRawHtmlErrorHandling() {
        
        Test.setMock(HttpCalloutMock.class, new BBCMockHttpResponse(500, 'Internal Server Error'));

        Test.startTest();
        try {
            String htmlContent = bbc.fetchRawHtml();
            System.assert(false, 'An exception was expected due to an error response');
        } catch (Exception e) {
            System.assertEquals('System.AuraHandledException', e.getTypeName(), 'Unexpected exception type received');
        }
        Test.stopTest();
    }
}