import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="algolia-search"
export default class extends Controller {
  connect() {
    console.log("hello");
    const search = instantsearch({
      indexName: 'votre_index', // Remplacez par le nom de votre index
      searchClient,
    });

    search.addWidgets([
      instantsearch.widgets.searchBox({
        container: '#search-input',
      }),
      instantsearch.widgets.hits({
        container: '#hits',
        templates: {
          item: `
            <div>
              <h2>{{#helpers.highlight}}{ "attribute": "title" }{{/helpers.highlight}}</h2>
              <p>{{#helpers.highlight}}{ "attribute": "description" }{{/helpers.highlight}}</p>
            </div>
          `,
        },
      }),
    ]);

    search.start();
  }
}
