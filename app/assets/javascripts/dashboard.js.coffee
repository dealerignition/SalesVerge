$ ->
  $("#timelinefilterbuttons button").click ->
      if $(this).hasClass("active")
          setTimeout(removeActive, 10)
          count = 0
          $(this).siblings().each ->
              $(".#{this.id}accordion").show()
              count += $(".#{this.id}accordion").length
          $(".noteaccordion").show()
          count += $(".#{this.id}accordion").length
          filtered = false
      else
          filtered = true
          $(this).siblings().each ->
              $(".#{this.id}accordion").hide()
          $(".noteaccordion").hide()
          $(".#{this.id}accordion").show()
          count = $(".#{this.id}accordion").length
          type = $(this).text().trim()

      if filtered
        if count == 1
          if type.slice(-3) == "ies"
            word = type.slice(0, -3) + "y"
          else
            word = type.slice(0, -1)
        else
          word = type
      else
        word = if count == 1 then "Activity" else "Activities"

      $("#timelineStream h3").text("#{count} #{word}")


  removeActive = ->
      $("#timelinefilterbuttons button.active").removeClass("active")

  $("#dashboard select").change ->
      window.location = "?date_range=#{$(this).val()}"
