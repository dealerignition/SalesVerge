$ ->
    # Automatically hide the mobile Safari navbar.
    setTimeout(window.scrollTo(0,1), 100)

    $("a[rel=popover]").popover()
    $(".tooltip").tooltip()
    $("a[rel=tooltip]").tooltip()

    $("#timeline").on 'hidden shown', ->
      $(".shown").removeClass "shown"
      $(this).find(".in").parent().addClass "shown"

    shownElement = null
    $("#timeline").on 'click', 'a', ->
      shownElement = $(this).closest(".accordion-group")

    elementHeight = 0
    $("#timeline").on 'hide', ->
      elementHeight = $(shownElement).innerHeight()

    $("#timeline").on 'show', ->
      $(shownElement).addClass "shown"

    $("#alert-modal-background").css({ opacity: 0.75 })
    $("#alert-modal").css({ opacity: 1 })