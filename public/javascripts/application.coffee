$ ->
  window.controller = new ScrollMagic.Controller()

  controller.scrollTo (newpos) ->
    newpos += $(window).height()
    TweenMax.to window, 0.5, scrollTo: y: newpos

  $(document).on 'click', 'a[href^=\'#\']', (e) ->
    id = $(this).attr('href')
    items = $(id)
    if items.length > 0
      e.preventDefault()
      controller.scrollTo id 
      if window.history and window.history.pushState
        history.pushState '', document.title, id

  $('.navbar').on 'click', '.collapse.in a', ->
    $('.navbar-toggle').click()

  smMin = 768
  pinned = false

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
        slideImage = $(el).find("img").eq(0)
        firstChild = $(el).children()[0]
        scene.removePin true
        scene.removeTween true
        slideImage.css("opacity", "1")
    else if ($(window).width() >= smMin && !pinned)
      pinned = true
      scenes.forEach (scene) ->
        el = $(scene.triggerElement())
        slideImage = $(el).find("img").eq(0)
        firstChild = $(el).children()[0]
        scene.duration($(window).height())
        scene.setPin(firstChild)
        if (slideImage)
          tween = TweenMax.fromTo(slideImage, 1, {
            opacity: 0
          }, {
            opacity: 1,
            immediateRender: true
          })
          scene.setTween tween

  updateScenes()
  $(window).on 'resize', updateScenes