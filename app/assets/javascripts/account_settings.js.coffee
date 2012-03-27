$ -> 
    $('#createUser').modal('hide')
    $(document).on("submit", '#createUser form', (event) ->
      event.preventDefault()
      $.post("/account_settings/users/create", $(this).serialize(), (data) ->
        if data.success
          $('#createUser').one('hidden', ->
            $('#users').append(data.data).hide().slideDown()
          )
          $('#createUser').modal('hide')

        $('#createUser').html(data.form)
      )
    )
