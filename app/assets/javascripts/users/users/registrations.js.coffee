$(document).ready ->
  $('.picture_upload').fileinput
    showPreview: true
    maxFileCount: 1
    browseClass: 'btn btn-info fileinput-browse-button'
    browseIcon: ''
    browseLabel: ' Select files'
    removeClass: 'btn btn-warning'
    removeIcon: ''
    removeLabel: ' Cancel'
    allowedFileExtensions: ['jpeg', 'gif', 'png']
    msgValidationError: '''
    <span class="text-danger">
    <i class="fa fa-warning"></i> You can only upload picture files.
    </span>
    '''
