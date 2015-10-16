hideAll($(".content"));

$(".content-links").click(function(e){
  e.preventDefault();
  showContent($(this), $(".content"));
});


function hideAll(selector){
  selector.hide();
}

function showContent(link, content){
  content.slideUp();
  link.next().slideDown();
}
