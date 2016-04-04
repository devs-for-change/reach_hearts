$ ->

  if $('#errors').length > 0
    $('html, body').animate
      scrollTop: $('#errors').offset().top,
      duration: 500
  if /contact-success/.test(window.location.hash)
    $('#contact-success').removeClass('hidden')

  smMin = 768
  pinned = false

  controller = new ScrollMagic.Controller()

  $(document).on 'click', 'a[href^=\'#\']', (e) ->
    id = $(this).attr 'href'
    if window.history and window.history.pushState
      history.pushState '', document.title, id
    item = $(id)
    if item.length > 0
      e.preventDefault()
      position = item.eq(0).offset().top
    parent = $(item).parent().parent()
    if pinned && parent.hasClass('pinnable-slide')
      pos = parent.offset().top + ($(window).height())
    else
      pos = $(item).offset().top
    $('html,body').animate
      scrollTop: pos,
      duration: 500

  $('.navbar-toggle').on 'click', (e) ->
    e.stopPropagation()
    expanded = ($(this).attr('aria-expanded') is 'true')
    $(this).attr 'aria-expanded', String !expanded
    $('.navbar-collapse').toggleClass('in')

  $('.navbar').on 'click', '.collapse.in a', ->
    $('.navbar-toggle').click()

  # set up scenes
  scenes = []
  $('.pinnable-slide').each ->

    child = $(this).children()[0]
    scene = new (ScrollMagic.Scene)(
      triggerElement: this
      triggerHook: 0,
      reverse: true
    )
    controller.addScene scene
    scenes.push scene

  # update scenes to disable/enable pinning depending on screen size
  updateScenes = ->
    if ($(window).width() < smMin && pinned)
      pinned = false
      scenes.forEach (scene) ->
        el = $(scene.triggerElement())
        slideImage = $(el).find('img').eq(0)
        firstChild = $(el).children()[0]
        scene.removePin true
        scene.removeTween true
        slideImage.css 'opacity', '1'
    else if ($(window).width() >= smMin && !pinned)
      pinned = true
      scenes.forEach (scene) ->
        el = $(scene.triggerElement())
        slideImage = $(el).find('img').eq(0)
        firstChild = $(el).children()[0]
        scene.duration $(window).height() * 2
        scene.setPin firstChild
        if (slideImage)
          tween = TweenMax.fromTo slideImage, 1, { opacity: 0 }, opacity: 1
          scene.setTween tween

  updateScenes()
  $(window).on 'resize', updateScenes

  $(window).on 'scroll', ->
    if ($('body').scrollTop() >= $('#top').offset().top + $('#top').height())
      $('#nav-logo').addClass('active')
    else
      $('#nav-logo').removeClass('active')
