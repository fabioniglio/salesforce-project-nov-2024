@IsTest
public class BBCMockHttpResponse implements HttpCalloutMock {
    private Integer statusCode;
    private String responseBody;

    // Constructor for success response
    public BBCMockHttpResponse() {
        this.statusCode = 200;
        this.responseBody = '<html><body><section data-testid="illinois-section-outer-10"><div data-testid="cambridge-card"><span data-testid="card-order">1</span><a href="/news/articles/xyz" data-testid="internal-link"><h2 data-testid="card-headline">Sample Article Title</h2></a></div></section></body></html>';
    }

    // Constructor for custom response
    public BBCMockHttpResponse(Integer statusCode, String responseBody) {
        this.statusCode = statusCode;
        this.responseBody = responseBody;
    }

    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(this.statusCode);
        res.setBody(this.responseBody);
        return res;
    }
}
