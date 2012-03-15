$ ->
    $('.datepicker').datepicker({
        format: "yyyy-mm-dd"
    })

    $('#customername').keyup ->
        $('#customername').data('run', true)

    $('.customers a[href="#"]').live('click', ->
        $('#customername').val("#{this.text.split(' (')[0]}")
        $('#customerid').val("#{ $(this).attr('value') }")
        $('.customers').slideUp().empty()
    )

    $('#keep').click((event) ->
        event.preventDefault()
    )

    updateAutoFill = () ->
        if $('#customername').data('run')
            $('#customername').data('run', false)
            search = $('#customername').val()
            last = $('#customername').data('last')

            if search and search != last
                $('#customername').data('last', search)
                $.getJSON("/customers.json?#{$.param({search: search})}", (customers) ->
                    if customers.length == 0
                        $('.customers').slideUp( () ->
                            $(this).empty()
                        )
                        return

                    $('.customers').slideDown()

                    customerIDs = []
                    for c in customers
                        customerIDs.push(c.id)

                    for c in $('.customers').children().not('#keep')
                        id = Number($(c).children('a').last().attr('value'))
                        $(c).slideUp( () ->
                            $(this).remove()
                        ) unless id in customerIDs
                        i = customerIDs.indexOf(id)
                        customerIDs.remove(i) unless i < 0

                    for c in customers
                        $('.customers').prepend(
                            "<li><a href='#' value='#{ c.id }'>#{ c.first_name } #{ c.last_name } (#{ c.email })</a></li>"
                        ).children().first().slideDown() if c.id in customerIDs
                )

    setInterval(updateAutoFill, 1000)
