http = require 'http'
path = require 'path'
sys = require 'sys'
url = require 'url'

port = 8000

server = null

server = http.createServer (request, response) ->
    url_parts = url.parse request.url
    switch url_parts.pathname
        when '/' then sendMails url_parts.pathname, request, response
        else null
    return
.on 'error', (e) ->
    console.log "Got error: " + e.message
    return

sendMails = (_url, req, res) ->
    console.log req.query
    console.log url.parse(req.url, true).query
    res.writeHead 200, 'Content-Type': 'application/json'
    res.write "{'status': false}"
    res.end()
    return

server.listen port
sys.puts "Server running at in port 8000 localhost"
