(($) ->) jQuery

$ ->
  stages = []
  side_ul = $('#stages-side ul')
  page_ul = $('#stages ul')

  $.getJSON 'https://spreadsheets.google.com/feeds/list/1s01Lois7tigY7p4CKDmU5tRpbR07o9vl38oAtPE7uSI/od6/public/values?alt=json',
    (data) ->
      counter = 0
      $.each data.feed.entry, (index, entry) ->
        counter++
        date = entry['gsx$date']['$t']
        details = entry['gsx$détails']['$t']
        lieu = entry['gsx$lieu']['$t']
        termine = entry['gsx$terminé']['$gt']

        if (termine != 'oui')
          if (counter <= 5)
            side_ul.append("<li>"+date+" : "+lieu+" "+details+"</li>")
          if (typeof page_ul != 'undefined')
            page_ul.append("<li>"+date+" : "+lieu+" "+details+"</li>")
