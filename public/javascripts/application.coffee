$ ->
  if screen.width < 992
    # This defines the fade and pin effect for the template.
    #  Pin the main area, including the first image to roughly middle
    #  Fade in the areas, pinning when they reach 100% opacity.
    #  Pin the areas for pin_hold_duration
    #  After pin_hold_duration expires, fade back out, and repeat on next section.

    controller = new ScrollMagic.Controller()

    $('.sections-text-area .section-text').each (i) ->
      $element = $(this)

      id = $element.attr('id') # Fade tween target ID, text area target.
      trigger_id = "trigger-#{id}" # The trigger ID for fade/pin

      section_height = $element.height()
      section_margin_top = parseInt($element.css('margin-top').replace('px',''))
      section_margin_bottom = parseInt($element.css('margin-bottom').replace('px',''))

      # insert trigger div directly before target ID
      $element.before("<div id='#{trigger_id}'>&nbsp;</div>")

      pin_offset = section_margin_top + 70 # Magic number - roughly the margin plus image
      fade_duration = 400 # Magic number.  Should be a percentage of VH?
      pin_hold_duration = 3000 # Magic number, completely arbitrary.

      content_in_offset = pin_offset - fade_duration
      content_hold_offset = pin_offset
      content_out_offset = pin_offset + pin_hold_duration

      tween_in = TweenMax.to("##{id}", 1, { opacity: 1})
      tween_out = TweenMax.to("##{id}", 1, { opacity: 0})

      content_in = new (ScrollMagic.Scene)(
        triggerElement: "##{trigger_id}"
        offset: content_in_offset
        duration: fade_duration).setTween(tween_in).addIndicators(name: "#{i} in (duration: 100%)").addTo(controller)

      content_hold = new (ScrollMagic.Scene)(
        triggerElement: "##{trigger_id}"
        offset: content_hold_offset
        duration: pin_hold_duration).setPin("##{id}").addIndicators(name: "#{i} pin").addTo(controller)

      content_out = new (ScrollMagic.Scene)(
        triggerElement: "##{trigger_id}"
        offset: content_out_offset
        duration: fade_duration).setTween(tween_out).addIndicators(name: "#{i} out (duration: 100%)").addTo(controller)

    # Duration to allow all sections to be scrolled.
    main_pinnable_area_duration = $('.sections-text-area').height() + 300
    # Pin the changing image area to the left.
    pinnable_area = new (ScrollMagic.Scene)(
      triggerElement: '#sections-trigger'
      offset: '200%'
      duration: main_pinnable_area_duration).setPin('.pinnable-area').addIndicators(name: 'MAIN PIN').addTo(controller)
