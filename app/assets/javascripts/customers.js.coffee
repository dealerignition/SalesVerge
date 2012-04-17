$ ->
    $('#expandInfo').click ->
        $("#customerinformation").slideToggle()
        $("#edit").toggle()

    $('#expandSampleCheckout').click ->
        $(".js-areas:not(#samplearea)").slideUp()
        $("#samplearea").slideToggle()

    $('#expandNote').click ->
        $(".js-areas:not(#notearea)").slideUp()
        $("#notearea").slideToggle()

    customer_search = false
    $('#customersearch').keyup ->
        customer_search = true

    sample_search = false
    $('#samplesearch').keyup ->
        sample_search = true

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

    getCustomerResults = ->
        if customer_search
            q = $('#customersearch').val()

            if q != ""
                url = "/customers?query=#{q}"
            else
                url = "/customers"

            $.get(url, (data) ->
                $('#customers').html(data)
                $(window).scrollTop($("#customersearch").offset().top-5)
            )
            customer_search = false

    getSampleResults = ->
        if sample_search
            q = $('#samplesearch').val()

            if q
              $.getJSON("/samples.json?query=#{q}", (samples) ->
                  $("#js-samples p").remove()
                  for sample in samples
                    unless sample.id in $("#js-selected-samples").data("selected")
                      $("#js-samples")
                        .append("<p><a href='##{sample.id}'>#{sample.name}</a></p>")
                      $("#js-samples a:last").data("id", sample.id)
              )
            else
              $("#js-samples p").remove()

            sample_search = false

    $("#js-selected-samples").data("selected", [])
    $("#js-samples").on('click', "a", ->
      selected = $("#js-selected-samples").data("selected")
      selected.push($(this).data("id"))
      $(this).parent().remove().appendTo("#js-selected-samples")
      $("#js-selected-samples").data("selected", selected)
    )

    setInterval(getCustomerResults, 500)
    setInterval(getSampleResults, 500)

    $("#customertable tr").click ->
        window.location = $(this).find('a.btn:last')[0].href

    $("#samplearea input[type=submit]").click (event) ->
      event.preventDefault()
      sample_ids = $("#js-selected-samples").data("selected").join("|")
      $("#samplearea input[name='sample_ids']").val(sample_ids)
      $(this).closest("form").submit()

