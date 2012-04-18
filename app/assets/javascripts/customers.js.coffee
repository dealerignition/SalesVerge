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

        if q
          url = "/customers?query=#{q}"
        else
          url = "/customers"

        $.get(url, (data) ->
          $('#customers').html(data)
          $(window).scrollTop($("#customersearch").offset().top-5)
        )
        customer_search = false
    setInterval(getCustomerResults, 500)

    getSampleResults = ->
      if sample_search
        q = $('#samplesearch').val()

        if q
          $.getJSON("/samples.json?query=#{q}", (samples) ->
              $("#js-samples li").remove()
              for sample in samples
                unless sample.id in $("#js-selected-samples").data("selected")
                  $("#js-samples")
                    .append("<li><a href='##{sample.id}'>#{sample.name} <span class='help-block'>#{sample.dealer_sample_id}</span><span class='close'>&times;</span></a></li>")
                  $("#js-samples a:last").data("id", sample.id)
          )
        else
          $("#js-samples li").remove()
          $("#js-samples").show()

        checkCheckoutButton()
        sample_search = false
    setInterval(getSampleResults, 500)

    checkCheckoutButton = ->
      button = $("#checkoutButton")
      if $("#js-selected-samples").data("selected").length > 0
        button.show()
      else
        button.hide()

    $("#js-selected-samples").data("selected", [])

    $("#js-samples").on('click', "a", ->
      selected = $("#js-selected-samples").data("selected")
      selected.push($(this).data("id"))
      $(this).parent().detach().appendTo("#js-selected-samples")
      $("#js-selected-samples").data("selected", selected)

      checkCheckoutButton()
    )

    $("#js-selected-samples").on('click', "a", ->
      selected = $("#js-selected-samples").data("selected")
      selected.splice(selected.indexOf($(this).data("id")), 1)
      $(this).parent().detach().appendTo("#js-samples")
      $("#js-selected-samples").data("selected", selected)

      checkCheckoutButton()
    )

    $("#customertable tr").click ->
        window.location = $(this).find('a.btn:last')[0].href

    $("#samplearea input[type=submit]").click (event) ->
      event.preventDefault()
      sample_ids = $("#js-selected-samples").data("selected").join("|")
      $("#samplearea input[name='sample_ids']").val(sample_ids)
      $(this).closest("form").submit()

