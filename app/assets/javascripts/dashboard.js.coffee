$ ->
    $("#dashboard .btn-info").click ->
        if $(this).hasClass("active")
            setTimeout(removeActive, 10)
            count = 0
            $(this).siblings().each ->
                $(".#{this.id}").show()
                count += $(".#{this.id}").length
            count += $(".#{this.id}").length
        else
            $(this).siblings().each ->
                $(".#{this.id}").hide()
            $(".#{this.id}").show()
            count = $(".#{this.id}").length

        word = if count > 1 then "Stories" else "Story"
        $("#timelineStream h3").text("#{count} #{word}")


    removeActive = ->
        $("#dashboard button.active").removeClass("active")

    $("#dashboard select").change ->
        window.location = "?date_range=#{$(this).val()}"
