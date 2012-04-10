$ ->
    # Automatically hide the mobile Safari nav bar.
    window.scrollTo(0,1)
    $("a[rel=popover]").popover()
    $(".tooltip").tooltip()
    $("a[rel=tooltip]").tooltip()
