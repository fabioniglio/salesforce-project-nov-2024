import { LightningElement, track } from 'lwc';
import fetchRawHtml from '@salesforce/apex/bbc.fetchRawHtml';

export default class BbcArticleList extends LightningElement {
    @track articles = [];
    @track error;

    connectedCallback() {
        this.loadArticles();
    }

    async loadArticles() {
        try {
            const htmlText = await fetchRawHtml(); 
            this.articles = this.parseArticles(htmlText);
        } catch (error) {
            console.error('Error fetching articles:', error);
            this.error = 'Failed to load articles';
        }
    }

    parseArticles(htmlText) {
        const parser = new DOMParser();
        const doc = parser.parseFromString(htmlText, 'text/html');

        
        const mostReadSection = doc.querySelector('section[data-testid="illinois-section-outer-10"]');
        if (!mostReadSection) {
            console.error('Most Read section not found');
            return [];
        }

        
        const articleElements = mostReadSection.querySelectorAll('div[data-testid="cambridge-card"]');
        const articles = [];

        articleElements.forEach((articleElement, index) => {
            const rank = articleElement.querySelector('span[data-testid="card-order"]')?.textContent.trim();
            const url = articleElement.querySelector('a[data-testid="internal-link"]')?.getAttribute('href');
            const title = articleElement.querySelector('h2[data-testid="card-headline"]')?.textContent.trim();

            if (rank && url && title) {
                articles.push({
                    rank: parseInt(rank, 10),
                    url: `https://www.bbc.com${url}`,
                    title: title
                });
            }
        });

        return articles.slice(0, 10); 
    }
}
