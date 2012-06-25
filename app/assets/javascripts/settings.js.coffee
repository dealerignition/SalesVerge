$ ->
  $("#expandNewUser").click ->
    $("#newUserArea").slideToggle()
  
  $("#toggle_scraping_config").click ->
    $("#scraping_config").slideToggle()

  $(".js-userRole").change ->
    name = $(this).closest("tr").find("b").text().trim()
    id = $(this).attr("data-id")
    switch $(this).val()
      when "Inactive"
        result = confirm "Are you sure you want to deactivate #{name}?"
        if result
          $.ajax "/users/#{id}/deactivate", {
            type: "PUT"
          }
          $(this).closest("tr").find(".js-user-info").addClass("help-block")
      else
        result = confirm "Are you sure you want to change #{name}'s role to #{$(this).val()}?"
        if result
          $.ajax "/users/#{id}/activate", {
            type: "PUT"
          }
          $.ajax "/users/#{id}/role", {
            type: "PUT",
            data: { role: $(this).val() }
          }
          $(this).closest("tr").find(".js-user-info").removeClass("help-block")
