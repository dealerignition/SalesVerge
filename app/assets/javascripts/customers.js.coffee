$ ->
    $('#expandInfo').click ->
        $("#customerinformation").slideToggle()
        $("#edit").toggle()

    $('#expandSampleCheckout').click ->
        $("#samplearea").slideToggle()

    $('#expandNote').click ->
        $("#notearea").slideToggle()

    search = false
    $('#customersearch').keyup ->
        search = true

    # Only use this if we are on a phone.
    if (navigator.userAgent.toLowerCase().indexOf("iphone") > -1 ||
        navigator.userAgent.toLowerCase().indexOf("android") > -1)
      $('#customersearch').focus ->
          unless $(this).data("big")
              $(this).data("big", true)
              $(this).animate(
                  width: $(this).width() * 1.2,
                  "margin-left": "-15px"
              )
          $(window).scrollTop($(this).offset().top-5)
          $(".navbar-simple").hide()

      $('#customersearch').blur ->
          $(".navbar-simple").fadeIn()
          if not $(this).val() and $(this).data("big")
              $(this).data("big", false)
              setTimeout( =>
                  $(this).animate(
                      "margin-left": "0px",
                      width: $(this).width() / 1.2,
                  )
              , 300)

    getResults = ->
        if search
            q = $('#customersearch').val()

            if q != ""
                url = "/customers?query=#{q}"
            else
                url = "/customers"

            $.get(url, (data) ->
                $('#customers').html(data)
                $(window).scrollTop($("#customersearch").offset().top-5)
            )
            search = false

    setInterval(getResults, 500)

    $("#customertable tr").click ->
        window.location = $(this).find('a.btn:last')[0].href
