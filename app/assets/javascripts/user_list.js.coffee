jQuery(document).ready ($) ->

  $('.edit-user').click (event)->
    event.preventDefault()
    show = $(@).closest 'tr'
    id = show.attr('id').replace 'show-user-', ''
    edit = $ '#edit-user-'+id
    show.hide()
    edit.show()

  $('.cancel-user-edit').click (event)->
    event.preventDefault()
    edit = $(@).closest 'tr'
    id = edit.attr('id').replace 'edit-user-', ''
    show = $ '#show-user-'+id
    show.show()
    edit.hide()
