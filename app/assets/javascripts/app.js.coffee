$ ->
    # Automatically hide the mobile Safari navbar.
    window.scrollTo(0,1)

    $("a[rel=popover]").popover()
    $(".tooltip").tooltip()
    $("a[rel=tooltip]").tooltip()

    $("#timeline").on 'hidden shown', ->
      $(".shown").removeClass "shown"
      $(this).find(".in").parent().addClass "shown"
