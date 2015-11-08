$ ->
  controller = new ScrollMagic.Controller()
  pinnable_area = new (ScrollMagic.Scene)(
    triggerElement: '#sections-trigger'
    offset: '200%'
    duration: '2000').setPin('.pinnable-area').addIndicators(name: '1').addTo(controller)



  tween_in_first = TweenMax.to('#first-section-text', 1, { opacity: 1})
  tween_out_first = TweenMax.to('#first-section-text', 1, { opacity: 0})

  first_section_content_in = new (ScrollMagic.Scene)(
    triggerElement: '#sections-trigger'
    offset: '300%'
    duration: 300).setTween(tween_in_first).addIndicators(name: '2 (duration: 100%)').addTo(controller)

  first_section_content_out = new (ScrollMagic.Scene)(
    triggerElement: '#sections-trigger'
    offset: '1000%'
    duration: 300).setTween(tween_out_first).addIndicators(name: '3 (duration: 100%)').addTo(controller)
