$ ->
  $('#expandNewUser').click ->
      $("#newUserArea").slideToggle()

    $(document).on("submit", '#newUserArea form', (event) ->
      event.preventDefault()
      $.post("/account_settings/users/create", $(this).serialize(), (data) ->
        if data.success
          $('#users').append(data.data).hide().slideDown()
          $('#newUserArea').slideUp()
          $('#expandNewUser').removeClass('active')
        $('#newUserArea form').replaceWith(data.form)
      )
    )
