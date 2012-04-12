$ ->
    $("#dashboard .btn-info").click ->
        if $(this).hasClass("active")
            setTimeout(removeActive, 10)
            count = 0
            $(this).siblings().each ->
                $(".#{this.id}accordion").show()
                count += $(".#{this.id}accordion").length
            count += $(".#{this.id}accordion").length
        else
            $(this).siblings().each ->
                $(".#{this.id}accordion").hide()
            $(".#{this.id}accordion").show()
            count = $(".#{this.id}accordion").length

        word = if count > 1 then "Stories" else "Story"
        $("#timelineStream h3").text("#{count} #{word}")


    removeActive = ->
        $("#dashboard button.active").removeClass("active")

    $("#dashboard select").change ->
        window.location = "?date_range=#{$(this).val()}"
