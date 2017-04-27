var nodemailer = require("nodemailer");
exports.sendmail = function (request, response) {
    var kwargs = {};
    // prepare data for send mail
    var auth = {};
    var property = "";
    // set property header mail
    property = "ICRPERU noreply <noreply@icrperusa.com>";
    // set credential from default mail
    auth['user'] = 'info@icrperusa.com';
    auth['pass'] = 'AHuachipa120';
    // init service smtp
    var smtpTransport = nodemailer.createTransport("SMTP", {
        service: "Gmail",
        auth: auth
    });
    var options = {};
    options['from'] = property;
    // valid param to mail
    if (request.params.hasOwnProperty('to')) {
        options['to'] = request.params['to'];
    }
    else {
        kwargs['raise'] = 'not found destinary mail';
    }
    // valid param to issue
    if (request.params.hasOwnProperty('issue')) {
        options['issue'] = request.params['issue'];
    }
    else {
        kwargs['raise'] = 'not define an issue';
    }
    // valid fields cc
    if (request.params.hasOwnProperty('cc')) {
        options['cc'] = request.params['cc'];
    }
    // valid fields cco
    if (request.params.hasOwnProperty('cco')) {
        options['cco'] = request.params['cco'];
    }
    // valid files attach
    if (request.params.hasOwnProperty('attach')) {
        // correct its line no work
        options['attach'] = request.params['attach'];
    }
    // console.info('Type of parameter ' + typeof(request.param));
    // console.info('Type of parameter ' + typeof(request.params));
    response.setHeader('Content-Type', 'application/json');
    response.type('application/json');
    response.json(kwargs);
    if (Object.keys(kwargs).length) {
    }
    else {
        response.json(kwargs);
    }
};
