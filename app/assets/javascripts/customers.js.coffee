$ ->
    $('#expandInfo').click ->
        $("#edit").toggle()
        $("#customerinformation").slideToggle()

    $('#expandSampleCheckout').click ->
        $(".js-areas:not(#samplearea)").slideUp()
        $("#samplearea").slideToggle()

    $('#expandNote').click ->
        $(".js-areas:not(#notearea)").slideUp()
        $("#notearea").slideToggle()


    # Search
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
        $(window).scrollTop($(this).offset().top-5)
        $(".navbar-simple").hide()

      $('#customersearch').blur ->
        $(".navbar-simple").fadeIn()

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

    selectedSamples = []

    getSampleResults = ->
      if sample_search

        q = $('#samplesearch').val()

        if q
          $.getJSON("/samples.json?query=#{q}", (samples) ->
            $("#js-samples li").remove()
            for sample in samples
              unless sample.id in selectedSamples
                $("#js-samples")
                  .append(createSampleSearchItem(sample.id,
                                        sample.name, sample.dealer_sample_id))
                $("#js-samples a:last").data("id", sample.id)
          )
        else
          $("#js-samples li").remove()

        checkCreateSampleButton()
        checkCheckoutButton()
        sample_search = false

    setInterval(getSampleResults, 500)

    $("#js-samples").on('click', "a", ->
      selectedSamples.push($(this).data("id"))
      $(this).parent().detach().appendTo("#js-selected-samples")

      checkCheckoutButton()
    )

    $("#js-selected-samples").on('click', "a", ->
      selectedSamples.splice(selectedSamples.indexOf($(this).data("id")), 1)
      $(this).parent().detach().appendTo("#js-samples")

      checkCheckoutButton()
    )

    $("#customertable tr").click ->
        window.location = $(this).find('a.btn:last')[0].href

    $("#samplearea input[type=submit]").click (event) ->
      event.preventDefault()
      sample_ids = selectedSamples.join("|")
      $("#samplearea input[name='sample_ids']").val(sample_ids)
      $(this).closest("form").submit()

    $("#js-addsample").click ->
      checkCreateSampleButton(true)

    $("#js-createsample").click ->
      sample_name = $("#samplesearch").val()
      sample_id = $("#js-sampleid").val()
      $.post "/samples/create", {
        sample_name: sample_name,
        sample_id: sample_id
      }, (data) ->
        if data.success
          $("#js-selected-samples")
            .append(createSampleSearchItem(data.id, sample_name, sample_id))
          $("#js-selected-samples a:last").data("id", data.id)

          selectedSamples.push(data.id)
          $("#samplesearch").val("")
          checkCreateSampleButton()
          checkCheckoutButton()
        else
          alert("Unable to create sample.")

    # Utilities

    checkCheckoutButton = ->
      button = $("#checkoutButton")
      if selectedSamples.length > 0
        button.show()
      else
        button.hide()

    checkCreateSampleButton = (click = false) ->
      button = $("#js-addsample")
      q = $("#samplesearch").val()

      if q
        button.show()
        button.html("Create &ldquo;#{q}&rdquo;")

        if button.hasClass("js-cancel") && click
          button.parent().siblings("p.hide").hide()
          button.removeClass("js-cancel")
        else if click
          button.html("Cancel")
          button.parent().siblings("p.hide").show()
          button.addClass("js-cancel")
      else
        button.hide()
        button.parent().siblings("p.hide").hide()
        button.removeClass("js-cancel")

    createSampleSearchItem = (id, name, dealer_sample_id) ->
      return """<li>
        <a href='##{id}'>
          #{name}
          <span class='help-block'>#{dealer_sample_id}</span>
          <span class='close'>&times;</span>
        </a>
      </li>"""
