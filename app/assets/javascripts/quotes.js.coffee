$ ->
    $('#expandCharge').click ->
      $("#chargearea").slideToggle()

    $("#js-chargedescription").change ->
      for s in $.parseJSON($("#chargearea").attr("samples"))
        if s.name == $(this).val() or s.dealer_sample_id == $(this).val()
          $("#js-chargesampleid").val(s.id)
          break
        else
          $("#js-chargesampleid").val(null)


      $("#js-chargeprice").focus()

    $("#js-chargedescription").typeahead {
        source: $.parseJSON($("#chargearea").attr("autofill")),
        items: 2
      }
