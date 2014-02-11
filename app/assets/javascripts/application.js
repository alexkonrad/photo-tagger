// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

//= require_tree ./models
//= require_tree ./views
//= require_tree ../templates

(function (root) {
  var PhotoTagger = root.PhotoTagger = (root.PhotoTagger || {});

  var init = PhotoTagger.initialize = function (user_id) {
    var photosListView = new PhotoTagger.PhotosListView ();

    PhotoTagger.Photo.fetchByUserId(user_id, function () {
      var str = photosListView.render().$el;
      $("#content").append(str);
    });

    var photosFormView = new PhotoTagger.PhotoFormView();
    var renderedForm = photosFormView.render()

    $("#content").append(renderedForm.$el);
  }
})(this);

