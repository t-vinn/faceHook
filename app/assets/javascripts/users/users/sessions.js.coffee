$ ->
  if $('body').attr('id').match(/sessions-new/)
    $("#public_feeds .page").infinitescroll
      navSelector: "nav.pagination" # selector for the paged navigation (it will be hidden)
      nextSelector: "nav.pagination a[rel=next]" # selector for the NEXT link (to page 2)
      itemSelector: "#public_feeds tbody.post" # selector for all items you'll retrieve
