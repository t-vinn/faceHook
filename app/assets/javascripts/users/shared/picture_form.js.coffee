$ ->
  maxFieldsCount = 2
  $addLink = $('a.add_nested_fields')

  toggleAddLink = ->
    $addLink.toggle(fieldsCount <= maxFieldsCount)
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

  $(document).on 'nested:fieldAdded', ->
    fieldsCount += 1
    toggleAddLink()

  $(document).on 'nested:fieldRemoved', ->
    fieldsCount -= 1
    toggleAddLink()

  # count existing nested fields after page was loaded
  fieldsCount = $('form .fields').length
  toggleAddLink()
