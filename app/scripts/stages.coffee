(($) ->) jQuery

$ ->
  stages = []
  side_ul = $('#stages-side ul')
  page_ul = $('#stages ul')

  if (sessionStorage.getItem("stages") == null)
    $.getJSON 'https://spreadsheets.google.com/feeds/list/1s01Lois7tigY7p4CKDmU5tRpbR07o9vl38oAtPE7uSI/od6/public/values?alt=json',
      (data) ->
        stages = []
        $.each data.feed.entry, (index, entry) ->
          date = entry['gsx$date']['$t']
          details = entry['gsx$détails']['$t']
          lieu = entry['gsx$lieu']['$t']
          termine = entry['gsx$terminé']['$gt']
          stages.push({date: date, details: details, lieu: lieu, termine: termine})
        sessionStorage.setItem("stages", JSON.stringify(stages))

  counter = 0
  $.each JSON.parse(sessionStorage.getItem("stages")), (index, stage) ->
    if (stage.termine != 'oui')
      counter++
      if (counter <= 5)
        side_ul.append("<li>" + stage.date + " : " + stage.lieu + " " + stage.details + "</li>")
      if (typeof page_ul != 'undefined')
        page_ul.append("<li>" + stage.date + " : " + stage.lieu + " " + stage.details + "</li>")
