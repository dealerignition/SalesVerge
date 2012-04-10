$ ->
    $('#expandInfo').click ->
        $("#customerinformation").slideToggle()
        $("#edit").toggle()

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

    $(".customertable tr").click ->
        window.location = $(this).find('a.btn:last')[0].href
