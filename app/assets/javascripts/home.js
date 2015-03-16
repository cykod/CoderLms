function setupHome() {

  $(".panel").on("click",".change-image",function(e) {
    e.preventDefault();
    var target = e.currentTarget;
    $(target).hide();
    $(target).parents("li").find(".upload-file").removeClass("hidden");
  });
}
