;var LessonEditor = (function() {
  var self = {}


  self.init = function() {
    $(".code-area").height($(window).height() - 170);
    Mousetrap.reset();

    self.editor = new EditorView({ el: $("#js-editor") }).render();
  }

  var EditorView = Backbone.View.extend({

    events: {
      "click .js-file": "selectFile",
      "click a[data-remote]": "closeDropdown",
      "submit": "saveAndRun",
      "change input[type=text]": "markChanges",
      "change select": "markChanges",
      "click [data-value=split]": "preferSplit",
      "click [data-value=full]": "preferFull"
    },

    initialize: function() {
      var self = this;
      Mousetrap.bind("ctrl+s", function(e) { self.saveAndRun(e); return false; });
      Mousetrap.bind("backspace", function(e) { return false; });
    },

    closeDropdown: function(e) {
      $(".open").removeClass("open");
    },

    showLast: function() {
      this.stashCurrentFile();
      this.showFile(this.$(".js-file").last());
    },

    showFile: function(file) {
      var contentType = file.data("type");
      var session = this.editor.getSession();

      this.holdChanges = true;
      this.editor.setValue(file.find(".js-body").val());
      this.holdChanges = false;

      session.setMode("ace/mode/" + contentType);

      var position = file.data("position");
      if(position) {
        this.editor.gotoLine(position.row, position.col, false);
      } else {
        this.editor.gotoLine(0,1, false);
      }

      file.closest("li").addClass("active");

      $(".js-code-area").removeClass("code-running");

      this.showResult(file);
      
      var displayAttr = file.attr('data-displayable'),
          editableAttr = file.attr('data-editable'),
          displayable = (typeof displayAttr !== typeof undefined && displayAttr !== false),
          editable = (typeof editableAttr !== typeof undefined && editableAttr !== false);

      if(editable) { 
        this.editor.focus();
      }


      if(!editable) {
        this.showFull();
        $(".js-run").hide();
        $(".js-split-selector").hide();
        $(".js-code-area").addClass("code-running");
      } else if(!displayable) {
        this.showFull();
        $(".js-run").show();
        $(".js-split-selector").hide();
        $(".js-code-area").removeClass("code-running");
      } else {
        $(".js-run").show();
        $(".js-split-selector").show();
        if(this.isSelectorFull()) {
          this.showFull();
        } else {
          this.showSplit();
        }
      }
    },

    firstEditableAndDisplayable: function() {
      return this.$(".js-file[data-displayable][data-editable]")[0];
    },

    showResult: function(file) {
      var attr = file.attr('data-displayable');

      if(typeof attr !== typeof undefined && attr !== false) {
        this.$(".result-area").html("<iframe src='" + file.data("url") + "?rand=" + Math.random() + "'></iframe>");

      } else {
        this.$(".result-area").empty();
        if(this.firstEditableAndDisplayable()) {
          this.showResult( $(this.firstEditableAndDisplayable()));
        }
      }
    },

    saveAndRun: function(e) {
      var self = this;

      this.save(function() {
        self.showResult(self.currentFile());
      });

      $(".js-code-area").toggleClass("code-running");
      if(!$(".js-code-area").hasClass("code-running")) {
        this.editor.focus();
      }

      if(e) { e.preventDefault(); }
    },

    save: function(callback) {
      this.saveCurrentFile();
      var action = this.$el.attr("action");

      $.ajax({
        url: action,
        type: "PUT",
        data: this.$el.serialize()
      }).then(function() {
       if(callback) {  callback(); }
      });

      this.unmarkChange();
    },

    preferFull: function(e) {
      $(".js-split-selector [data-value='full']").addClass("active");
      $(".js-split-selector [data-value='split']").removeClass("active");
      this.showFull();
    },

    preferSplit: function(e) {
      $(".js-split-selector [data-value='full']").removeClass("active");
      $(".js-split-selector [data-value='split']").addClass("active");
      this.showSplit();
    },

    showFull: function() {
      $(".js-code-area").removeClass("code-split").addClass("code-full");
    },

    showSplit: function() {
      $(".js-code-area").addClass("code-split").removeClass("code-full");
    },

    isSelectorFull: function() {
      return $(".js-split-selector [data-value='full']").hasClass("active");
    },

    saveCurrentFile: function() {
      var file = this.$(".active .js-file");
      file.find(".js-body").val(this.editor.getValue());
    },

    stashCurrentFile: function() {
      var file = this.$(".active .js-file");
      this.saveCurrentFile();
      file.closest(".active").removeClass("active");
      var selection = this.editor.getSelectionRange()
      file.data("position", { row: selection.start.row + 1, col: selection.start.column })
    },

    selectFile: function(e) {
      var file = $(e.currentTarget);
      if(file != this.currentFile()) {
        this.stashCurrentFile();
        this.showFile(file);
      }
    },

    files: function() {
      return this.$(".js-file");
    },

    currentFile: function() {
      return this.$(".active .js-file");
    },
  
    render: function() {
      this.editor = ace.edit("js-editor-code");
      this.editor.setTheme("ace/theme/chrome");
      this.editor.getSession().setUseSoftTabs(true);
      this.editor.getSession().setTabSize(2);

      if(this.files()[0]) {
        this.showFile(this.files().eq(0));
      }
      this.editor.commands.bindKey("ctrl-s", null)

      var self = this;
      this.editor.commands.addCommand({
        name: "saveEditor",
      bindKey: { win: "Ctrl-S", mac: "Ctrl-S" },
      exec: function(editor) {
          self.saveAndRun();
        }
      });

      this.editor.getSession().on('change', function(e) {
        self.markChange();
      });

      return this;
    },

    markChange: function() {
      if(this.holdChanges) { return; }
      this.$(".js-run .btn").removeClass("btn-success").addClass("btn-warning");
    },

    unmarkChange: function() {
      this.$(".js-run .btn").removeClass("btn-warning").addClass("btn-success");
    }


  });




  return self;

}());
