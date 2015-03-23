window.setupSly = (ids...) ->
  for id in ids
    eles = $("##{id}")
    if eles.length
      eles.sly
        horizontal: 1
        itemNav: 'forceCentered'
        smart: 1
        mouseDragging: 1
        touchDragging: 1
        easing: 'swing'
        scrollBar: "##{id}-scroll"
        scrollBy: 1
        speed: 1