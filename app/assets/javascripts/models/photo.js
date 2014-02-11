//= require ../underscore.js

(function (root) {
  var PhotoTagger = root.PhotoTagger = (root.PhotoTagger || {});

  var Photo = PhotoTagger.Photo = function (attributes) {
    this.attributes = _.extend({}, attributes);
  };

  _.extend(Photo, {
    all: [],

    create: function (attributes, callback) {
      $.ajax({
        url: "/api/photos",
        type: "POST",
        data: { photo: attributes },
        success: function (photoAttributes) {
          var newPhoto = new Photo(photoAttributes)
          Photo.all.push(newPhoto);
          callback(newPhoto);
        }
      });
    },

    fetchByUserId: function (userId, callback) {
      var path = "/api/users/" + userId + "/photos"

      $.ajax({
        url: path,
        type: "GET",
        // data: {},
        success: function (photos) {
          var photoObjects = []

          for (var i = 0; i < photos.length; i++) {
            photoObjects.push( new Photo(photos[i]) );
          };


          Photo.all = Photo.all.concat(photoObjects);
          callback(photoObjects);
        }
      });
    }
  });

  _.extend(Photo.prototype, {
    get: function (attr_name) {
      return this.attributes[attr_name];
    },

    set: function (attr_name, val) {
      this.attributes[attr_name] = val;
      return this.attributes[attr_name];
    },

    save: function (callback) {
      var that = this;

      if (that.get("id")) {
        $.ajax({
          url: "/api/photos/" + that.get("id"),
          type: "PUT",
          data: that.attributes,
          success: function () { callback(that); }
        })
      } else {
        $.ajax({
          url: "/api/photos",
          type: "POST",
          data: { photo: that.attributes },
          success: function (photo) {
            _.extend(that.attributes, photo);
            Photo.all.push(that);
            callback(that);
          }
        })
      }
    }
  });



})(this);

