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
  folder_id = '0B_I9jsxxYO-Wa1FnemtzaHVvRGM'

  if actualites_div.exists()
    load("actualites", actualites_div, 'https://googledrive.com/host/' + folder_id + '/actualites.md')
  if actualites_side_div.exists()
    load("actualites-side", actualites_side_div, 'https://googledrive.com/host/' + folder_id + '/actualites-side.md')
  if test_div.exists()
    load("test", test_div, 'https://googledrive.com/host/' + folder_id + '/test.md')
