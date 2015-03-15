;var LessonSlides = (function() {
  var self = {};

  self.init = function(noOutline) {
    Mousetrap.reset();
    this.noOutline = noOutline;
    new SlideViewer({ el: $(".js-slides") }).render();
  }

  var SlideViewer = Backbone.View.extend({

    events: {
      "click .js-slides": "showSlides",
      "click .js-outline": "showOutline"
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

      $(".slide.active").height($(window).height() - $(".js-slides-container").offset().top - 10);

      if( $(".slide.active").data("title") !== undefined) {
        $(".panel-title").text($(".slide.active").data("title"));

      }

      this.$(".slide.active iframe").each(function() {
        $(this).attr("src",$(this).data("src"));
      });

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
      if(!LessonSlides.noOutline && localStorage["coderlms_slides"] == "outline") { 
        this.showOutline();
      }
      this.activateSlide(0);
      return this;
    },

    showOutline: function() {
      this.$(".js-slides-container").addClass("outline");
      this.$(".js-slides").removeClass("active");
      this.$(".js-outline").addClass("active");
      localStorage["coderlms_slides"] = "outline";
    },

    showSlides: function() {
      this.$(".js-slides-container").removeClass("outline");
      this.$(".js-outline").removeClass("active");
      this.$(".js-slides").addClass("active");
      localStorage["coderlms_slides"] = "slides";
    }

  });

  return self;
})();
