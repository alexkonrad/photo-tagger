//= require ../underscore.js
//= require ../jquery.serializeJSON.min.js

(function (root) {
  var PhotoTagger = root.PhotoTagger = (root.PhotoTagger || {});

  var PhotoFormView = PhotoTagger.PhotoFormView = function () {
    this.$el = "<div></div>";

    var that = this;
    $("#content").on("submit", "#new-photo-form", function (event) {
      event.preventDefault();
      that.submit(event);
    });
  };

  _.extend(PhotoFormView.prototype, {
    render: function () {
      this.$el = JST["photo_form"]();
      return this;
    },

    submit: function (event) {
      var photoAttributes = $(event.currentTarget).serializeJSON();

      _.extend(photoAttributes['photo'], {owner_id: CURRENT_USER_ID });

      PhotoTagger.Photo.create(photoAttributes['photo'], function () {

      });
    }
  });

})(this);