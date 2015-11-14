$ ->
  controller = new ScrollMagic.Controller()

  main_pin_accumulator = 0

  $('.sections-text-area .section-text').each (i) ->
    $element = $(this)

    id = $element.attr('id')
    trigger_id = "trigger-#{id}"

    section_height = $element.height()
    section_margin_top = parseInt($element.css('margin-top').replace('px',''))
    section_margin_bottom = parseInt($element.css('margin-bottom').replace('px',''))

    # insert trigger div
    $element.before("<div id='#{trigger_id}'>&nbsp;</div>")

    pin_offset = section_margin_top + 70 # Magic number - roughly the margin plus image

    tween_in = TweenMax.to("##{id}", 1, { opacity: 1})
    tween_out = TweenMax.to("##{id}", 1, { opacity: 0})

    content_in = new (ScrollMagic.Scene)(
      triggerElement: "##{trigger_id}"
      offset: pin_offset - 500
      duration: 500).setTween(tween_in).addIndicators(name: "#{i} in (duration: 100%)").addTo(controller)

    content_hold = new (ScrollMagic.Scene)(
      triggerElement: "##{trigger_id}"
      offset: pin_offset
      duration: 1000).setPin("##{id}").addIndicators(name: "#{i} pin").addTo(controller)

    content_out = new (ScrollMagic.Scene)(
      triggerElement: "##{trigger_id}"
      offset: pin_offset + 1000
      duration: 500).setTween(tween_out).addIndicators(name: "#{i} out (duration: 100%)").addTo(controller)

  main_pinnable_area_duration = $('.sections-text-area').height() + 300
  pinnable_area = new (ScrollMagic.Scene)(
    triggerElement: '#sections-trigger'
    offset: '200%'
    duration: main_pinnable_area_duration).setPin('.pinnable-area').addIndicators(name: 'MAIN PIN').addTo(controller)
