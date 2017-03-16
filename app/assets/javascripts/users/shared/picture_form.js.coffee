$ ->
  maxFieldsCount = 2
  $addLink = $('a.add_nested_fields')

  toggleAddLink = ->
    $addLink.toggle(fieldsCount <= maxFieldsCount)

  $(document).on 'nested:fieldAdded', ->
    fieldsCount += 1
    toggleAddLink()

  $(document).on 'nested:fieldRemoved', ->
    fieldsCount -= 1
    toggleAddLink()

  # count existing nested fields after page was loaded
  fieldsCount = $('form .fields').length
  toggleAddLink()
