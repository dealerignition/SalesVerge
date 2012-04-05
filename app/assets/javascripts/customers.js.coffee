$ ->
    $('.interaction').click () ->
        $(this).children('.toggle').slideToggle()

    $('#extendedInfo').modal('hide')

    search = false
    $('.customersearch').keypress ->
        search = true

    getResults = ->
        if search
            q = $('.customersearch').val()
            $.get("/customers/search?q=#{q}", (data) ->
                $('.customertable').html(data)
            )
            search = false

    setInterval(getResults, 1000)
