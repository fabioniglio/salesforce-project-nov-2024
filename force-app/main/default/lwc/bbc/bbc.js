import { LightningElement, wire } from 'lwc';
import getTopArticles from '@salesforce/apex/bbc.fetchTopArticles';

export default class BbcArticle extends LightningElement {

    @wire(getTopArticles) articles;

    get hasArticles() {
        return this.articles && this.articles.data && this.articles.data.length > 0;
    }
} 