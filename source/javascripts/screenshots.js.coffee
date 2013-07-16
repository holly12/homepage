$('.screenshot.small a').click ->
  event.preventDefault()
  img = $(this).html()
  $(this).closest("article").find(".screenshot.big").html(img)
