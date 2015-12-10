$ ->
  controller = new ScrollMagic.Controller()

  # change behaviour of controller to animate scroll instead of jump
  controller.scrollTo (newpos) ->
    TweenMax.to window, 0.8, scrollTo: y: newpos

  #  bind scroll to anchor links
  $(document).on 'click', 'a[href^=\'#\']', (e) ->
    id = $(this).attr('href')
    if $(id).length > 0
      e.preventDefault()
      # trigger scroll
      controller.scrollTo id
      # if supported by the browser we can even update the URL.
      if window.history and window.history.pushState
        history.pushState '', document.title, id
