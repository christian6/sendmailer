http = require 'http'
path = require 'path'
sys = require 'sys'
url = require 'url'

port = 3000

server = null

server = http.createServer (request, response) ->
    url_parts = url.parse request.url
    switch url_parts.pathname
        when '/' then send url_parts.pathname, request, response
        else null
    return
.on 'error', (e) ->
    console.log "Got error: " + e.message
    return

send = (_url, req, res) ->
    # console.log req.get
    # res.header 'Access-Control-Allow-Origin', '*'
    res.writeHead 200, 
        'Content-Type': 'text/plain'
        'Access-Control-Allow-Origin': '*'
    params = url.parse(req.url, true).query
    if /(.+)@(.+){2,}\.(.+){2,}/.test params.email
        nodemailer = require 'nodemailer'
        smtpTransport = nodemailer.createTransport 'SMTP',
            service: 'Gmail'
            auth:
                user: 'elementospe@gmail.com'
                pass: 'buenosaires23'
        mailOptions =
            from: "#{params.name} #{params.from}"
            to: params.email
            subject: params.subject
            html: params.body
        smtpTransport.sendMail mailOptions, (error, response) ->
            # console.log response
            # console.log error
            if error
                res.write '{"status": false, "raise": "nothing send mail"}'
                res.end()
                return
            else
                res.write '{"status": true, "raise": "mail send"}'
                res.end()
                return
    else
        res.writeHead 200, 
            'Content-Type': 'text/plain'
            'Access-Control-Allow-Origin': '*'
        res.write '{"status": false, "raise": "nothing email nothing"}'
        res.end()
    console.log params
    return

sendMails = (_url, req, res) ->
    # console.log req.query
    console.log url.parse(req.url, true).query
    res.writeHead 200, 'Content-Type': 'application/json'
    # here verify email
    
    res.write "{'status': false}"
    res.end()
    return

server.listen port
sys.puts "Server running at in port #{port} localhost"
