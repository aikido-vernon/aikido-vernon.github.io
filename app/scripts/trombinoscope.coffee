(($) ->) jQuery

$ ->
  ul = $('#trombinoscope ul')
  trombi = $.getJSON 'https://picasaweb.google.com/data/feed/api/user/103136384746774831034/albumid/6060723009017170049?alt=json',
    (data) ->
      $.each data["feed"]["entry"], (index, entry) ->
        name = entry["summary"]["$t"]
        url = entry["content"]["src"]
        ul.append("<li><img class='img-rounded' title='"+name+"' src='"+url+"'></img></li>")
  $("#trombinoscope").sliphover height: '30px'