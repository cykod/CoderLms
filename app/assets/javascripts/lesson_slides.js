;var LessonSlides = (function() {
  var self = {};

  self.init = function() {
    Mousetrap.reset();
    new SlideViewer({ el: $(".js-slides") }).render();
  }

  var SlideViewer = Backbone.View.extend({

    events: {


    },

    initialize: function() {
      var self = this;
      Mousetrap.bind("right", function(e) { self.showNextSlide(); });
      Mousetrap.bind("left", function(e) { self.showPreviousSlide(); });
    },

    activateSlide: function(index) {
      this.currentSlide().removeClass("active");
      this.slide(index).addClass("active");
      this.$(".js-current-slide").html(index + 1);

    },

    slide: function(index) {
      return $(".slide[data-slide=" + index + "]");
    },

    slideExists: function(index) {
      return this.slide(index)[0] ? true : false;
    },

    currentSlide: function() {
      return $(".slide.active");
    },

    currentSlideIndex: function() {
      return this.currentSlide().data("slide");
    },

    showNextSlide: function() {
      var nextNum = this.currentSlideIndex() + 1;
      if(this.slideExists(nextNum)) {
        this.activateSlide(nextNum);
      }
    },

    showPreviousSlide: function() {
      var prevNum = this.currentSlideIndex() - 1;
      if(this.slideExists(prevNum)) {
        this.activateSlide(prevNum);
      }
    },

    render: function() {
      this.activateSlide(0);
      return this;
    }

  });

  return self;
})();
