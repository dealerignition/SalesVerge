$ ->
    $('#customername').keypress ->
        today = new Date()
        now = today.getTime()
        last = $('.customers').data('time')
        # Monkeypatch
        if now - 1000 > last or not last? or true
            $('.customers').data('time', now)
            $.getJSON("/customers.json?#{$.param({search: this.value})}", (customers) ->
                $('.customers').empty()
                $('.customers').append("<a href='#customer|#{c.id}'>#{ c.first_name } #{ c.last_name }</a>") for c in customers
            )
    $('a[href^="#customer"]').live('click', ->
        $('#customername').val("#{this.text}")
        $('#customerid').val("#{this.href.split('|')[1]}")
    )
