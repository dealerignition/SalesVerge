$ ->
    $('.interaction').click () ->
        $(this).children('.toggle').slideToggle()

    $('#extendedInfo').modal('hide')

    search = false
    $('.customersearch').keyup ->
        search = true

    getResults = ->
        if search
            q = $('.customersearch').val()

            if q != ""
                url = "/customers?query=#{q}" 
            else
                url = "/customers?query=."

            $.get(url, (data) ->
                $('.customertable').html(data)
            )
            search = false

    setInterval(getResults, 500)
