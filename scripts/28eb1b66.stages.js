(function(){!function(a){}(jQuery),$(function(){var a,b,c,d,e,f;return e=$("#stages-side ul"),b=$("#stages ul"),f=$("#slick-stages"),d="stages",a="0B_I9jsxxYO-WS1E3ZnJjWXhsZ00",c=function(c){var d,g;return d=0,$.each(JSON.parse(sessionStorage.getItem(c)),function(c,g){var h,i,j;return d++,j="https://googledrive.com/host/"+a+"/"+g.telechargement,5>=d&&e.append("<li>"+g.date+" : "+g.lieu+" "+g.details+"</li>"),"undefined"!=typeof b&&b.length>0&&(h=' <a href="'+j+'" target="_blank">(Affiche <span class="glyphicon glyphicon-save"></span>)</a>',i="<li>"+g.date+" : "+g.lieu+" "+g.details,""!==g.affiche?b.append(i+h+"</li>"):b.append(i+"</li>")),"undefined"!=typeof f&&f.length>0&&""!==g.affiche?f.append('<div id="effect" class="effects clearfix"> <div class="img"> <img data-lazy="https://googledrive.com/host/'+a+"/"+g.affiche+'"/> <div class="overlay"> <h2>Télécharger l\'affiche</h2> <a href="'+j+'" target="_blank" class="expand"><span class="glyphicon glyphicon-save"></span></a> <a class="close-overlay hidden">x</a> </div> </div> </div>'):void 0}),"undefined"!=typeof f&&f.length>0&&(g=$("#slick-stages > div > div").length>1,f.slick({lazyload:"ondemand",centerMode:g,centerPadding:"60px",slidesToShow:1,slidesToScroll:2,variableWidth:!0,infinite:!0,dots:!0})),Modernizr.touch?($(".close-overlay").removeClass("hidden"),$(".img").click(function(a){return $(this).hasClass("hover")?void 0:$(this).addClass("hover")}),$(".close-overlay").click(function(a){return a.preventDefault(),a.stopPropagation(),$(this).closest(".img").hasClass("hover")?$(this).closest(".img").removeClass("hover"):void 0})):$(".img").mouseenter(function(){return $(this).addClass("hover")}).mouseleave(function(){return $(this).removeClass("hover")})},null===sessionStorage.getItem(d)?$.getJSON("https://spreadsheets.google.com/feeds/list/1s01Lois7tigY7p4CKDmU5tRpbR07o9vl38oAtPE7uSI/od6/public/values?alt=json",function(a){var f;return f=[],$.each(a.feed.entry,function(a,b){var c,d,e,g,h;return d=b.gsx$date.$t,e=b["gsx$détails"].$t,g=b.gsx$lieu.$t,c=b.gsx$affiche.$t,h=b["gsx$téléchargement"].$t,"oui"!==b["gsx$terminé"].$t?f.push({date:d,details:e,lieu:g,affiche:c,telechargement:h}):void 0}),sessionStorage.setItem(d,JSON.stringify(f)),c(d,e,b)}):c(d,e,b)})}).call(this);