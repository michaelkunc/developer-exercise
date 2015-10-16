$(document).ready(function(){
  module("Accordion tests");

  test('hideAll();', function(){
    var testDiv = $('#testDiv');
    hideAll(testDiv);
    equal(false, testDiv.is(":visible"));
  });

  test('showContent', function(){
    equal(true,)
  })

});
