$(document).ready(function() {
  $(".item-check").bind('change', function(){
    $.ajax({
      url: '/items/'+this.value+'/toggle',
      type: 'POST',
      data: {"done": this.checked}
    });
  });
});