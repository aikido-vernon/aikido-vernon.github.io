(($) ->) jQuery

$ ->
  markdownify = (div, sessionItemName) ->
    div.append(marked(sessionStorage.getItem(sessionItemName)))
    $('table').addClass('table table-striped table-bordered')

  load = (sessionItemName, div, url) ->
    if (sessionStorage.getItem(sessionItemName) == null)
      $.get url,
        (data) ->
          sessionStorage.setItem(sessionItemName, data)
          markdownify(div, sessionItemName)
    else
      markdownify(div, sessionItemName)

  actualites_div = $('#actualites')
  actualites_side_div = $('#actualites-side')
  test_div = $('#test-markdown')

  if actualites_div.exists()
    load("actualites", actualites_div, 'https://cceb29fee4d380291bbd0b1ae889504cf3e0c559.googledrive.com/host/0B_I9jsxxYO-Wa1FnemtzaHVvRGM/actualites.md')
  if actualites_side_div.exists()
    load("actualites-side", actualites_side_div, 'https://cceb29fee4d380291bbd0b1ae889504cf3e0c559.googledrive.com/host/0B_I9jsxxYO-Wa1FnemtzaHVvRGM/actualites-side.md')
  if test_div.exists()
    load("test", test_div, 'https://cceb29fee4d380291bbd0b1ae889504cf3e0c559.googledrive.com/host/0B_I9jsxxYO-Wa1FnemtzaHVvRGM/test.md')
