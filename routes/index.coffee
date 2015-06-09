
#
# * GET home page.
#
nodemailer = require("nodemailer")

exports.index = (req, res) ->
  res.render "index",
        title: "send to e-mail"
        para: req.param("para")
        asunto: req.param("asunto")
        texto: req.param("texto")
  return

exports.enviar = (req, res) ->
    # create reusable transport method (opens pool of SMTP connections)
    smtpTransport = nodemailer.createTransport("SMTP",
        service: "Gmail"
        auth:
            user: "logistica@icrperusa.com" #"foxtime03@gmail.com"
            pass: "MGisla2011" #"fronhell"
    )

    # setup e-mail data with unicode symbols
    mailOptions =
        from: "Logistica ICR PERU S.A. ✔ <logistica@icrperusa.com>" # sender address
        to: req.body.email # list of receivers
        subject: req.body.asunto # Subject line
        #text: "Hello world ✔", // plaintext body
        html: req.body.texto # html body

    # send mail with defined transport object
    smtpTransport.sendMail mailOptions, (error, response) ->
        if error
            console.log error
            res.render "error",
            title: "Error al enviar el mail"
        else
            console.log "Message sent: " + response.message
            res.render "enviado",
            title: "El mensaje fue enviado"
        return
    return

# if you don't want to use this transport object anymore, uncomment following line
#smtpTransport.close(); // shut down the connection pool, no more messages

exports.envelop = (request, response) ->
    console.log request.param "notdounsdf"
    authProperty = new Object
    fromProperty = ""
    # emailProperty
    if request.param("pwdmailer") isnt undefined
        console.log "success #{ request.param "name" }"
        fromProperty = "#{ request.param("name").toString() } ✔ <#{ request.param("email").toString() }> "
        console.log fromProperty
        authProperty =
            user: request.param "email"
            pass: request.param "pwdmailer"
    else
        fromProperty = "Logistica ICR PERU S.A. ✔ <logistica@icrperusa.com>"
        authProperty =
            user: "logistica@icrperusa.com"
            pass: "MGisla2011"
    smtpTransport = nodemailer.createTransport "SMTP",
        service: "Gmail"
        auth: authProperty

    emailOptions =
        from: fromProperty
        to: request.param "forsb"
        subject: request.param "issue"
        html: request.param "body"

    if request.param("ccb") isnt undefined
        elmailOptions.cc = request.param("ccb")

    if request.param("ccob") isnt undefined
        elmailOptions.cco = request.param("ccob")

    smtpTransport.sendMail emailOptions, (error, result) ->
        context = new Object
        if error
            context.status = false
            console.error "error #{error}, result #{result}"
        else
            context.status = true
            #context.result = result.message
            console.log "Message sent: " + result.message
        response.setHeader "Content-Type", "application/json"
        response.type "application/json"
        # response.setEncoding("utf-8")
        response.jsonp context
        #response.end()
        return
    return