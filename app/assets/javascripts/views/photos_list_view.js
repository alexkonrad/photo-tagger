//= require ../underscore.js

(function (root) {
  var PhotoTagger = root.PhotoTagger = (root.PhotoTagger || {});

  var PhotosListView = PhotoTagger.PhotosListView = function () {
    this.$el = "<div></div>";
  };

  _.extend(PhotosListView.prototype, {
    render: function () {
      var that = this;
      that.$el = "";
      that.$el = "<ul>";
      PhotoTagger.Photo.all.forEach(function(photo) {
        var photoTag = "<li>" + photo.get("title") + "</li>"
        that.$el += photoTag;
      });
      that.$el += "</ul>";

      return that;
    }
  })

})(this);