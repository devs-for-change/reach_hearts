$ ->
  controller = new ScrollMagic.Controller()
  scene = new (ScrollMagic.Scene)(
    triggerElement: '#sections_trigger'
    duration: 300).setPin('#first_pin').addIndicators(name: '1 (duration: 300)').addTo(controller)
