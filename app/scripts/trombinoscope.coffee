(($) ->) jQuery

$ ->
  ul = $('#trombinoscope ul')

  if (sessionStorage.getItem("trombinoscope") == null)
    $.getJSON 'https://picasaweb.google.com/data/feed/api/user/103136384746774831034/albumid/6061615020653085601?alt=json',
      (data) ->
        trombinoscope = []
        $.each data.feed.entry, (index, entry) ->
          name = entry.summary["$t"]
          url = entry.content["src"]
          trombinoscope.push({name: name, url: url})
        sessionStorage.setItem("trombinoscope", JSON.stringify(trombinoscope))

  console.log(JSON.parse(sessionStorage.getItem("trombinoscope")))
  $.each JSON.parse(sessionStorage.getItem("trombinoscope")), (index, people) ->
    ul.append("<li><div><img src='"+people.url+"'></img><span class='caption'><p>"+people.name+"</p></span></div></li>")