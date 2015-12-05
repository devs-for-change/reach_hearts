$ ->
  setup_scroll_effect = ->
    if $(window).width() > 991
      # This defines the fade and pin effect for the template.
      #  Pin the main area, including the first image to roughly middle
      #  Fade in the areas, pinning when they reach 100% opacity.
      #  Pin the areas for pin_hold_duration
      #  After pin_hold_duration expires, fade back out, and repeat on next section.

      controller = new ScrollMagic.Controller({addIndicators: true})

      $('.sections-text-area .section-text').each ->
        $element = $(this)

        id = $element.attr('id') # Fade tween target ID, text area target.
        trigger_id = "trigger-#{id}" # The trigger ID for fade/pin

        section_height = $element.height()
        section_margin_top = parseInt($element.css('margin-top').replace('px',''))
        section_margin_bottom = parseInt($element.css('margin-bottom').replace('px',''))

        # insert trigger div directly before target ID, unless it already exists
        $element.before("<div id='#{trigger_id}'>&nbsp;</div>") unless $("##{trigger_id}").length > 0

        pin_offset = (section_margin_top + 70) + (.45 * section_height) # Magic numbers
        fade_duration = 400 # Magic number.  Should be a percentage of VH?
        pin_hold_duration = 1500 # Magic number, completely arbitrary.

        content_in_offset = pin_offset - fade_duration
        content_hold_offset = pin_offset
        content_out_offset = pin_offset + pin_hold_duration

        tween_in = TweenMax.to("##{id}", 1, { opacity: 1})
        tween_out = TweenMax.to("##{id}", 1, { opacity: 0})

        content_in = new (ScrollMagic.Scene)(
          triggerElement: "##{trigger_id}"
          offset: content_in_offset
          duration: fade_duration)
            .setTween(tween_in)
            .addTo(controller)

        content_hold = new (ScrollMagic.Scene)(
          triggerElement: "##{trigger_id}"
          offset: content_hold_offset
          duration: pin_hold_duration)
            .setPin("##{id}")
            .addTo(controller)

        image_swap = new (ScrollMagic.Scene)(
          triggerElement: "##{trigger_id}"
          offset: content_hold_offset
          duration: pin_hold_duration)
            .on 'enter', ->
              swap_scene_image_in($element)
            .on 'leave', ->
              swap_scene_image_out($element)
            .addTo(controller)

        content_out = new (ScrollMagic.Scene)(
          triggerElement: "##{trigger_id}"
          offset: content_out_offset
          duration: fade_duration)
            .setTween(tween_out)
            .on 'leave', ->
              stop_swap_animations($element)
            .addTo(controller)

      # Duration to allow all sections to be scrolled.
      main_pinnable_area_duration = $('.sections-text-area').height() + 300

      # Pin the changing image area to the left.
      pinnable_area = new (ScrollMagic.Scene)(
        triggerElement: '#sections-trigger'
        offset: '200%'
        duration: main_pinnable_area_duration).setPin('.pinnable-area').addIndicators(name: "MAIN PIN").addTo(controller)

  swap_scene_image_in = ($element) ->
    $target = $('.section-image-target')
    src = $element.find('.section-image').attr('src')
    $target.attr('src', src)
    $target.stop().fadeIn 500

  swap_scene_image_out = ($element) ->
    $target = $('.section-image-target')
    $target.stop().fadeOut 500

  stop_swap_animations = ($element) ->
    $target = $('.section-image-target')
    $target.stop().hide()


  setup_scroll_effect()
  $(window).resize ->
    location.reload()
