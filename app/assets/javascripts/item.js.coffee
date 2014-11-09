$(document).ready ->
  $(".item-check").bind "change", ->
    $.ajax
      url: "/items/" + this.value + "/toggle"
      type: "POST"
      data:
        done: this.checked
      # success: (data, textStatus, jqXHR) ->
      #   $('body').append("Successful AJAX call: #{data}")


