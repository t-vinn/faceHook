$(document).ready ->
  $("#posts .page").infinitescroll
    navSelector: "nav.pagination" # selector for the paged navigation (it will be hidden)
    nextSelector: "nav.pagination a[rel=next]" # selector for the NEXT link (to page 2)
    itemSelector: "#posts tbody.post" # selector for all items you'll retrieve
  $("#following_posts .page").infinitescroll
    navSelector: "nav.pagination" # selector for the paged navigation (it will be hidden)
    nextSelector: "nav.pagination a[rel=next]" # selector for the NEXT link (to page 2)
    itemSelector: "#following_posts tbody.post" # selector for all items you'll retrieve
  $("#feeds .page").infinitescroll
    navSelector: "nav.pagination" # selector for the paged navigation (it will be hidden)
    nextSelector: "nav.pagination a[rel=next]" # selector for the NEXT link (to page 2)
    itemSelector: "#feeds tbody.post" # selector for all items you'll retrieve
  $('.picture_upload').fileinput
    showPreview: true
    maxFileCount: 1
    browseClass: 'btn btn-info fileinput-browse-button'
    browseIcon: ''
    browseLabel: ' select files'
    removeClass: 'btn btn-warning'
    removeIcon: ''
    removeLabel: ' cancel'
    uploadClass: 'btn btn-success fileinput-upload-button'
    uploadIcon: '<i class="fa fa-upload"></i>'
    uploadLabel: ' import'
    allowedFileExtensions: ['jpeg', 'gif', 'png']
    msgValidationError: '''
    <span class="text-danger">
    <i class="fa fa-warning"></i> You can upload jpeg, gif, or png files only.
    </span>
    '''

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
