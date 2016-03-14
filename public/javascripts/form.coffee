$ ->
  if $('#errors').length > 0
    $('html, body').animate
      scrollTop: $("#errors").offset().top,
      duration: 500
  current_location = window.location.href
  if /contact-success/.test(current_location)
    $('#contact-success').removeClass('hidden')
