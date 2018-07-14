(($) ->) jQuery

$ ->
  tarifs =
    carnet: "80€ + licence fédérale de 35€ et adhésion au club de 40€"
    annee:
      ado: "130€, comprenant la licence fédérale de 35€ et l'adhésion au club de 40€"
      enfant: "75€, comprenant la licence fédérale de 25€ et l'adhésion au club de 20€"
      adulte:
        homme: "180€, comprenant la licence fédérale de 35€ et l'adhésion au club de 40€"
        femme: "180€, comprenant la licence fédérale de 35€ et l'adhésion au club de 40€"

  form = $('#inscription')
  seulForm = form.find('#single-form')
  chequeForm = form.find('#cheque-form')
  mensualitesForm = form.find('#mensualites')
  parentForm = form.find('#parent-form')
  autorisationImageDiv = form.find('#autorisation-image-texte')
  assuranceDiv = form.find('#assurance-texte')
  carnet = $('#carnet').parents('label')
  tarif = form.find('#tarif')

  coursInputs = form.find('input[name=cours]')
  modeInscriptionInputs = form.find('input[name=mode-inscription]')
  moyenDePaiementInputs = form.find('input[name=moyen-paiement]')
  radioInputs = form.find('input[type=radio]')

  f = {}

  loadRadios = () ->
    f['cours'] = form.find('label.active input[name=cours]').prop('id')
    f['sexe'] = form.find('label.active input[name=sexe]').prop('id')
    f['modeInscription'] = form.find('label.active input[name=mode-inscription]').prop('id')
    f['seul'] = form.find('label.active input[name=seul]').prop('id')
    f['moyenDePaiement'] = form.find('label.active input[name=moyen-paiement]').prop('id')
    f['mensualite'] = form.find('label.active input[name=mensualite]').prop('id')

  loadFields = () ->
    f['nom'] = form.find('#nom').val()
    f['prenom'] = form.find('#prenom').val()
    f['dateNaissance'] = form.find('#date-de-naissance').val()
    f['parent'] = form.find('#parent').val()
    f['dateNaissanceParent'] = form.find('#date-de-naissance-parent').val()
    f['villeParent'] = form.find('#ville-parent').val()
    f['relationParent'] = form.find('#relation-parent').val()
    f['rue'] = form.find('#rue').val()
    f['rue2'] = form.find('#rue2').val()
    f['ville'] = form.find('#ville').val()
    f['codePostal'] = form.find('#code-postal').val()
    f['telephone'] = form.find('#telephone').val()
    f['courriel'] = form.find('#courriel').val()
    f['numeroLicence'] = form.find('#numero-licence').val()
    f['grade'] = form.find('#grade').val()
    f['autorisationImage'] = form.find('label.active input[name=autorisation-image]').prop('id') == 'autorisationImageOui'
    f['premiereInscription'] = form.find('label.active input[name=type-inscription]').prop('id') == 'premiere-inscription'
    f['luEtApprouve'] = form.find('input[name=lu-et-approuve] ').is(':checked')
    f['titulaireCheque'] = form.find('#titulaire-cheque').val()
    f['banque'] = form.find('#banque').val()

    loadRadios()

  updateTarif = () ->
    mode = tarifs[f['modeInscription']]
    if mode?[f['cours']]?[f['sexe']]?[f['seul']]?
      text = mode[f['cours']][f['sexe']][f['seul']]
    else if mode?[f['cours']]?[f['sexe']]?
      text = mode[f['cours']][f['sexe']]
    else if mode?[f['cours']]?
      text = mode[f['cours']]
    else
      text = mode
    tarif.text(text)

  seulDisplayable = () ->
    f['cours'] == 'adulte' && f['modeInscription'] != 'carnet' && f['sexe'] == 'homme'


  disableCarnet = (disable) ->
    if (f['modeInscription'] == 'carnet')
      $('#annee').click()
    carnet.attr('disabled', disable)

  autorisationImageTexte = () ->
    if (f['cours'] == 'adulte')
      text = 'mon image'
    else
      text = "l'image de "
      if (f['sexe'] == 'homme')
        text += "mon fils"
      else
        text += "ma fille"
    return "J'autorise l'association A.S.A.V (Aïkido Vernon) à utiliser #{text} à des fins non commerciales, que ce soit sur des photos ou vidéos."

  assuranceTexte = () ->
    if (f['cours'] == 'adulte')
      return "Je certifie avoir pris connaissance du contrat d'assurance qui couvre la pratique de l'Aïkido au sein de l'association. En outre, je certifie savoir que l'association ne garantit pas les pertes éventuelles de salaire en cas d'accident dû à la pratique de l'Aïkido mais je peux souscrire individuellement à une assurance complémentaire selon les modalités définies sur la demande de licence."
    else
      return "J'autorise mon enfant à pratiquer l'Aïkido aux cours, démonstrations et stages auxquels le club participe ou organise et j'autorise les responsables de l'association à prendre toutes les mesures médicales jugées indispensables y compris l'hospitalisation et l'intervention chirurgicale en cas d'accident."

  coursInputs.on 'change', ->
    switch $(this).attr('id')
      when 'ado','enfant'
        disableCarnet(true)
        parentForm.show()
      else
        disableCarnet(false)
        parentForm.hide()

  modeInscriptionInputs.on 'change', ->
    switch $(this).attr('id')
      when 'annee'
        mensualitesForm.show()
      else
        mensualitesForm.hide()


  moyenDePaiementInputs.on 'change', ->
    switch $(this).attr('id')
      when 'cheque'
        chequeForm.show()
      else
        chequeForm.hide()

  radioInputs.on 'change', ->
    # ugly hack
    label = $(this).parents('label')
    label.addClass('active')
    loadRadios()
    label.removeClass('active')
    if (seulDisplayable())
      seulForm.show()
    else
      seulForm.hide()
    autorisationImageDiv.text(autorisationImageTexte())
    assuranceDiv.text(assuranceTexte())
    updateTarif()

  loadFields()

  autorisationImageDiv.text(autorisationImageTexte())
  assuranceDiv.text(assuranceTexte())
  parentForm.hide()
  updateTarif()


  ############################
  # Soumission du formulaire #
  ############################
  form.on('submit', (e) ->
    e.preventDefault()

    loadFields()
    $.ajax 'https://formspree.io/asav.bureau@gmail.com',
      type : 'POST'
      data : f
      dataType : 'html'
      encode : true

    if (!f['luEtApprouve'])
      $('#are-you-sure').modal('show')
      return

    ###############
    # Definitions #
    ###############

    totalWidth = 595
    totalHeight = 842

    baseIndent = 20
    baseFontSize = 14
    smallFontSize = 10
    labelWidth = 90

    blueFontColor = '#3d4755'
    headerColor = '#69818f'

    doc = new PDFDocument
      size: 'A4'

    stream = doc.pipe(blobStream())

    ###########
    # Methods #
    ###########

    newLine = (label, text, widthText, x = doc.x) ->
      text = ' ' if text == ''
      y = doc.y
      doc.fillColor blueFontColor
      .font 'Helvetica-Bold'
      .text label, x, y,
        width: labelWidth
      #.rect(doc.x, y, labelWidth, baseFontSize).stroke()
      .moveUp()
      y = doc.y
      doc.fillColor 'black'
      .font 'Helvetica'
      .text text, x + labelWidth + baseIndent / 2, y,
        width: widthText
      #.rect(doc.x, y, widthText, baseFontSize).stroke()
      doc.x = baseIndent

    newDualLine = (label1, text1, widthText1, label2, text2, widthText2) ->
      newLine(label1, text1, widthText1)
      doc.moveUp()
      newLine(label2, text2, widthText2, labelWidth + 4 * baseIndent + widthText1)

    radioText = (x = doc.x, y = doc.y, text, fontSize, checked = false) ->
      doc.fontSize fontSize
      .circle(x, y + fontSize / 3, fontSize / 3)
      .stroke('black')
      .text text, x + 2 * fontSize / 3, y
      if (checked)
        doc.circle(x, y + fontSize / 3, fontSize / 6)
        .fill('black')

    checkbox = (x, y, size, ticked = false) ->
      doc.rect(x, y, size, size)
      .lineCap('round')
      if (ticked)
        doc.moveTo(x, y)
        .lineTo(x + size, y + size)
        .moveTo(x, y + size)
        .lineTo(x + size, y)
      doc.stroke()

    dashLine = () ->
      doc.moveDown()
      .moveTo(baseIndent, doc.y).lineTo(totalWidth - baseIndent, doc.y).dash(2, space: 2).stroke()
      .undash()
      .moveDown()

    line = () ->
      doc.moveDown()
      .moveTo(baseIndent, doc.y).lineTo(totalWidth - baseIndent, doc.y).stroke()
      .moveDown()

    ####################
    # Actual execution #
    ####################

    doc.rect(0, 0, totalWidth, 100)
    .fill(headerColor)

    doc.image 'data:image/png;base64,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',
      10, 10, width: 80

    doc.fillColor 'white'
    .fontSize 25
    .text 'AÏKIDO CLUB DE VERNON', 80, 20,
      indent: 80
      align: 'center'
    .text 'INSCRIPTION ' + f['cours'].toUpperCase(), 80, 60,
      indent: 80
      align: 'center'
    .moveDown()

    doc.x = baseIndent

    doc.fontSize baseFontSize
    newLine('Nom', f['nom'], 400)
    newLine('Prénom', f['prenom'], 400)
    newDualLine('Date de naissance', f['dateNaissance'], 100, 'Sexe', f['sexe'], 100)

    dashLine()

    newLine('Rue', f['rue'], 400)
    if (rue2)
      newLine(' ', f['rue2'], 400)

    newLine('Ville', f['ville'], 400)
    newDualLine('Code postal', f['codePostal'], 100, 'Téléphone', f['telephone'], 100)
    newLine('Courriel', f['courriel'])

    dashLine()

    newDualLine('Numéro de licence', f['numeroLicence'], 100, 'Grade', f['grade'], 100)

    radioText(3 / 2 * baseIndent + labelWidth, doc.y, "Première inscription au club", baseFontSize, f['premiereInscription'])
    doc.moveUp()
    radioText(3 / 2 * baseIndent + labelWidth + 200, doc.y, "Ré-inscription au club", baseFontSize, !f['premiereInscription'])

    line()

    doc.fontSize smallFontSize
    doc.font('Helvetica-Bold')

    columnWidth = 450

    y = doc.y
    x = columnWidth + 2 * baseIndent

    doc.text autorisationImageTexte(), baseIndent, y,
      width: columnWidth

    radioText(x, y, "OUI", smallFontSize, f['autorisationImage'])
    radioText(x, doc.y, "NON", smallFontSize, not f['autorisationImage'])

    line()

    doc.x = baseIndent
    if (f['cours'] != 'adulte')
      newDualLine('Je, soussigné(e)', f['parent'], 200, 'Né(e) le', f['dateNaissanceParent'], 200)
      newDualLine('Demeurant à', f['villeParent'], 200, 'Agissant en qualité de', f['relationParent'], 200)
      doc.moveDown()

    columnWidth = 400
    y = doc.y
    x = columnWidth + 2 * baseIndent

    doc.fillColor('#8f0000')
    .text assuranceTexte(), baseIndent, y,
      width: columnWidth

    savedX = doc.x
    savedY = doc.y

    checkbox(x, y, 8, f['luEtApprouve'])

    doc.fillColor('black')
    doc.text "Lu et approuvé", x + 15, y,
      width: 100

    doc.x = savedX
    doc.y = savedY
    line()

    switch f['modeInscription']
      when 'annee'
        category = 'Année '
      when 'mois'
        category = 'Mois '
      when 'carnet'
        category = 'Carnet de 10 cours '

    switch f['cours']
      when 'adulte'
        category += "#{f['sexe']} "
      else
        category += "#{f['cours']} "

    category += tarif.text()

    doc.fontSize baseFontSize
    newLine('Inscription', category)

    dashLine()

    if (f['moyenDePaiement'] == 'cheque')
      paymentLabel = if f['mensualite'] == '1' then "1 chèque" else f['mensualite'] + " chèques"
      newLine('Règlement', paymentLabel)
      label = if f['mensualite'] == '1' then "Titulaire du chèque" else "Titulaire des chèques"
      newDualLine(label, f['titulaireCheque'], 150, 'Banque', f['banque'], 150)
    else if (f['moyenDePaiement'] == 'especes')
      newLine('Règlement', 'Espèces')
      dashLine()
      doc.fontSize(20)
      .underline()
      .font('Helvetica-Bold')
      .text 'Règlement en espèces en une seule fois',
        align: 'center'

    stream.on 'finish', ->
      blob = stream.toBlob('application/pdf')
      saveAs(blob, 'inscription.pdf')
#      url = stream.toBlobURL('application/pdf')
#      $('#iframe').prop('src', url)
    doc.end()
  )

