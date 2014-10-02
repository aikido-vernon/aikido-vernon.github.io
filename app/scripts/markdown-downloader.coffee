(($) ->) jQuery

$ ->
  markdown_div = $('.markdown')
  markdownify = () ->
    markdown_div.append(markdown.toHTML(sessionStorage.getItem("actualites")))

  if (sessionStorage.getItem("actualites") == null)
    $.get 'https://cceb29fee4d380291bbd0b1ae889504cf3e0c559.googledrive.com/host/0B_I9jsxxYO-Wa1FnemtzaHVvRGM/Actualit%C3%A9s',
      (data) ->
        sessionStorage.setItem("actualites", data)
        markdownify()
  else
    markdownify()