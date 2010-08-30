Event.observe(document, 'dom:loaded', function() {

  $$('.edit-user').each(function(element) {
    Event.observe(element, 'click', function(event) {
      event.stop()
      var show = element.up('tr');
      var id = show.id.sub('show-user-', '');
      var edit = $('edit-user-'+id);
      show.hide();
      edit.show();
    });
  });

  $$('.cancel-user-edit').each(function(element) {
    Event.observe(element, 'click', function(event) {
      var edit = element.up('tr');
      var id = edit.id.sub('edit-user-', '');
      var show = $('show-user-'+id);
      show.show();
      edit.hide();
    });
  });

});
