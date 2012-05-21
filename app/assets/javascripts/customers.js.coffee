$ ->
    $('#expandInfo').click ->
        $("#show").toggle()
        $("#customerinformation").slideToggle()

    $('#expandSampleCheckout').click ->
        $(".js-areas:not(#samplearea)").slideUp()
        $("#samplearea").slideToggle()

    $('#expandNote').click ->
        $(".js-areas:not(#notearea)").slideUp()
        $("#notearea").slideToggle()


    # Search
    customer_search = false
    $('#js-customersearch').keyup ->
      customer_search = true

    sample_search = false
    $('#js-samplesearch').keyup ->
      sample_search = true

    $('#js-customersearch').focus ->
      $(this).siblings().hide()
      $(this).animate {
        width: $(this).parent().width() - 28,
      }

    $('#js-customersearch').blur ->
      $(this).siblings().show()

    getCustomerResults = ->
      if customer_search
        q = $('#js-customersearch').val()

        if q
          url = "/customers?query=#{q}"
        else
          url = "/customers"

        $.get(url, (data) ->
          if (data.trim() != "")
            $('#customers').html(data)
          else
            $('#customers').html("<div class='row span12'><h3>No matching customers.</h1></div>")
          $(window).scrollTop($("#js-customersearch").offset().top-5)
        )
        customer_search = false
    setInterval(getCustomerResults, 500)

    selectedSamples = []

    getSampleResults = ->
      if sample_search

        q = $('#js-samplesearch').val()

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

        checkOnQ()
        checkSelected()
        sample_search = false

    setInterval(getSampleResults, 500)

    $("#js-samples").on('click', "a", ->
      selectedSamples.push($(this).data("id"))
      $(this).parent().detach().appendTo("#js-selected-samples")

      checkSelected()
    )

    $("#js-selected-samples").on('click', "a", ->
      selectedSamples.splice(selectedSamples.indexOf($(this).data("id")), 1)
      $(this).parent().detach().appendTo("#js-samples")

      checkSelected()
    )

    $("#customertable tr").click ->
        window.location = $(this).find('a.btn:last')[0].href

    $("#samplearea input[type=submit]").click (event) ->
      event.preventDefault()
      sample_ids = selectedSamples.join("|")
      $("#samplearea input[name='sample_ids']").val(sample_ids)
      $(this).closest("form").submit()

    $("#js-createsample").click ->
      sample_name = $("#js-samplesearch").val()
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
          $("#js-samplesearch").val("")
          checkOnQ()
          checkSelected()
        else
          alert("Unable to create sample.")

    $("#js-addsample").click ->
      $("#js-addsample").hide()
      $("#js-samplesearch").removeClass("search-query")
      $("#js-newSampleForm").slideDown ->
        $("#js-sampleid").focus()

    $("#js-cancelcreatesample").click ->
      $("#js-newSampleForm").slideUp ->
        $("#js-samplesearch").addClass("search-query")
        $("#js-addsample").show()

    # Utilities

    checkSelected = ->
      button = $("#checkoutButton")
      if selectedSamples.length > 0
        button.show()
        $("#js-selected-samples").show()
      else
        button.hide()
        $("#js-selected-samples").hide()

      if $("#js-samples").children().length > 0
        $("#js-samples").show()
      else
        $("#js-samples").hide()

    checkOnQ = (click = false) ->
      button = $("#js-addsample")
      q = $("#js-samplesearch").val()

      if q
        button.show()
        button.html("Create &ldquo;#{q}&rdquo;")
      else
        button.hide()
        $("#js-newSampleForm").slideUp()
        $("#js-samplesearch").addClass("search-query")

    createSampleSearchItem = (id, name, dealer_sample_id) ->
      return "<li>
        <a href='##{id}'>
          #{name}
          <span class='help-block'>#{dealer_sample_id}</span>
          <span class='close'>&times;</span>
        </a>
      </li>"
