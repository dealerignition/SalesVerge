$ ->
    $('.interaction').click( () ->
        $(this).children('.toggle').slideToggle()
    )
    $('#extendedInfo').modal('hide')
