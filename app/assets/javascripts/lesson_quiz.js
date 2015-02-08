;var LessonQuiz = (function() {
  var self = {};

  self.init = function() {
    Mousetrap.reset();
    new QuizViewer({ el: $("#js-quiz") }).render();
  }

  var QuizViewer = Backbone.View.extend({

    events: {
      "click input[type=radio]": "showNextQuestion"
    },

    initialize: function() {
      var self = this;
    },

    activateQuestion: function(index) {
      this.currentQuestion().removeClass("active");
      this.question(index).addClass("active");
    },

    question: function(index) {
      return $(".question[data-question=" + index + "]");
    },

    questionExists: function(index) {
      return this.question(index)[0] ? true : false;
    },

    currentQuestion: function() {
      return $(".question.active");
    },

    currentQuestionIndex: function() {
      return this.currentQuestion().data("question");
    },

    showNextQuestion: function() {
      var nextNum = this.currentQuestionIndex() + 1;
      if(this.questionExists(nextNum)) {
        this.activateQuestion(nextNum);
      } else {
        var self = this;
        setTimeout(function() {
          self.submitAnswers();
        },10);

      }
    },

    submitAnswers: function() {
      this.currentQuestion().removeClass("active");
      var action = this.$el.attr("action");

      var self = this;

      $.ajax({
        url: action,
        type: "PUT",
        data: this.$el.serialize()
      }).then(function() {
        self.$(".done").addClass("active");
      });
    },

    render: function() {
      this.activateQuestion(0);
      return this;
    }

  });

  return self;
})();
