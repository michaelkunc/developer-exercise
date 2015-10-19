var Quote = Backbone.Model.extend();

var Quotes = Backbone.Collection.extend({
    model: Quote,
    url: 'https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json',
    sync: function(method, model, options) {
        var that = this;
        var params = _.extend({
            type: 'GET',
            dataType: 'json',
            url: that.url,
            processData: false
        }, options);

        return $.ajax(params);
    }
});

var QuoteView = Backbone.View.extend({
    initialize: function() {
        _.bindAll(this, 'render');
        this.collection = new Quotes;
        var that = this;
        this.collection.fetch().then(function(response){
          that.render();
        })
    },

    template: _.template($("#quotes-template").html()),

    render: function() {
      var stuff = this.template({
            quotes: this.collection.toJSON()
        });
        console.log(stuff);
        $(this.el).append(stuff);
  }
});

var quoteView = new QuoteView({
    el: $('ul')
});