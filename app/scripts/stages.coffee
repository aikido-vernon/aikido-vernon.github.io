(($) ->) jQuery

$ ->
  side_ul = $('#stages-side ul')
  page_ul = $('#stages ul')
  slick_div = $('#slick-stages')
  sessionItem = "stages"
  folder_id = '0B_I9jsxxYO-WS1E3ZnJjWXhsZ00'

  parseItems = (sessionItem) ->
    counter = 0
    $.each JSON.parse(sessionStorage.getItem(sessionItem)), (index, stage) ->
      counter++
      link = "https://googledrive.com/host/" + folder_id + "/" + stage.telechargement
      if (counter <= 5)
        side_ul.append("<li>" + stage.date + " : " + stage.lieu + " " + stage.details + "</li>")
      if (typeof page_ul isnt 'undefined' and page_ul.length > 0)
        affiche = ' <a href="' + link + '" target="_blank">(Affiche <span class="glyphicon glyphicon-save"></span>)</a>'
        base = "<li>" + stage.date + " : " + stage.lieu + " " + stage.details
        if (stage.affiche isnt "")
          page_ul.append(base + affiche + "</li>")
        else
          page_ul.append(base + '</li>')
      if (typeof slick_div isnt 'undefined' and slick_div.length > 0 and stage.affiche isnt "")
        slick_div.append('
          <div id="effect" class="effects clearfix">
            <div class="img">
              <img data-lazy="' + 'https://googledrive.com/host/' + folder_id + '/' + stage.affiche + '"/>
              <div class="overlay">
                <h2>Télécharger l\'affiche</h2>
                <a href="' + link + '" target="_blank" class="expand"><span class="glyphicon glyphicon-save"></span></a>
                <a class="close-overlay hidden">x</a>
              </div>
            </div>
          </div>
                ')

    if (typeof slick_div isnt 'undefined' and slick_div.length > 0)
      mode = $('#slick-stages > div > div').length > 1
      slick_div.slick({
        lazyload: 'ondemand'
        centerMode: mode
        centerPadding: '60px'
        slidesToShow: 1
        slidesToScroll: 2
        variableWidth: true
        infinite: true
        dots: true
      })
    if (Modernizr.touch)
      $(".close-overlay").removeClass("hidden")
      $(".img").click (e) ->
        if (!$(this).hasClass("hover"))
          $(this).addClass("hover")
      $(".close-overlay").click (e) ->
        e.preventDefault()
        e.stopPropagation()
        if ($(this).closest(".img").hasClass("hover"))
          $(this).closest(".img").removeClass("hover")
    else
      $(".img").mouseenter () ->
        $(this).addClass("hover")
      .mouseleave () ->
        $(this).removeClass("hover")

  if (sessionStorage.getItem(sessionItem) is null)
    $.getJSON 'https://spreadsheets.google.com/feeds/list/1s01Lois7tigY7p4CKDmU5tRpbR07o9vl38oAtPE7uSI/od6/public/values?alt=json',
    (data) ->
      stages = []
      $.each data.feed.entry, (index, entry) ->
        date = entry['gsx$date']['$t']
        details = entry['gsx$détails']['$t']
        lieu = entry['gsx$lieu']['$t']
        affiche = entry['gsx$affiche']['$t']
        telechargement = entry['gsx$téléchargement']['$t']
        if (entry['gsx$terminé']['$t'] isnt 'oui')
          stages.push({date: date, details: details, lieu: lieu, affiche: affiche, telechargement: telechargement})
      sessionStorage.setItem(sessionItem, JSON.stringify(stages))
      parseItems(sessionItem, side_ul, page_ul)
  else
    parseItems(sessionItem, side_ul, page_ul)