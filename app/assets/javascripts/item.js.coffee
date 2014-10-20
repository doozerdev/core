$(document).ready ->
  $(".item-check").bind "change", ->
    $.ajax
      url: "/items/" + @value + "/toggle"
      type: "POST"
      data:
        done: @checked
      success: (data, textStatus, jqXHR) ->
        $('body').append "Successful AJAX call: #{data}"
