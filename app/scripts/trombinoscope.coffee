(($) ->) jQuery

$ ->
  ul = $('#trombinoscope ul')
  trombi = $.getJSON 'https://picasaweb.google.com/data/feed/api/user/103136384746774831034/albumid/6060723009017170049?alt=json',
    (data) ->
      $.each data["feed"]["entry"], (index, entry) ->
        name = entry["summary"]["$t"]
        url = entry["content"]["src"]
        ul.append("<li><div><img src='"+url+"'></img><span class='caption'><p>"+name+"</p></span></div></li>")
  $("#trombinoscope").sliphover height: '30px'