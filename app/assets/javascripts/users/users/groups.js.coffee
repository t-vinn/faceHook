$ ->
  if $('body').attr('id').match(/groups-show/)
    $("#group_posts .page").infinitescroll
      navSelector: "nav.pagination" # selector for the paged navigation (it will be hidden)
      nextSelector: "nav.pagination a[rel=next]" # selector for the NEXT link (to page 2)
      itemSelector: "#group_posts tbody.post" # selector for all items you'll retrieve
    $('.picture_upload').fileinput
      showPreview: true
      maxFileCount: 1
      browseClass: 'btn btn-info fileinput-browse-button'
      browseIcon: ''
      browseLabel: ' select files'
      removeClass: 'btn btn-warning'
      removeIcon: ''
      removeLabel: ' cancel'
      allowedFileExtensions: ['jpeg', 'gif', 'png']
      msgValidationError: '''
      <span class="text-danger">
      <i class="fa fa-warning"></i> You can upload jpeg, gif, or png files only.
      </span>
      '''
  else if $('body').attr('id').match(/groups-index/)
    $("#groups .page").infinitescroll
      navSelector: "nav.pagination" # selector for the paged navigation (it will be hidden)
      nextSelector: "nav.pagination a[rel=next]" # selector for the NEXT link (to page 2)
      itemSelector: "#groups tr.post" # selector for all items you'll retrieve

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
