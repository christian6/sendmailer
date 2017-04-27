var nodemailer = require("nodemailer");

exports.sendmail = function (request:any, response:any) {

    var kwargs: object = {};
    // prepare data for send mail
    var auth: object = {};
    var property: string = "";
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

    var options: object = {};
    options['from'] = property;
    // valid param to mail
    if (request.params.hasOwnProperty('to')){
        options['to'] = request.params['to'];
    }else{
        kwargs['raise'] = 'not found destinary mail';
    }
    // valid param to subject
    if (request.params.hasOwnProperty('subject')){
        options['subject'] = request.params['subject'];
    }else{
        kwargs['raise'] = 'not define an subject';
    }
    // valid fields cc
    if (request.params.hasOwnProperty('cc')){
        options['cc'] = request.params['cc'];
    }
    // valid fields cco
    if (request.params.hasOwnProperty('cco')){
        options['cco'] = request.params['cco'];
    }
    // valid files attach
    if (request.params.hasOwnProperty('attach')){
        // correct its line no work
        options['attach'] = request.params['attach'];
    }
    // console.info('Type of parameter ' + typeof(request.param));
    // console.info('Type of parameter ' + typeof(request.params));

    response.setHeader('Content-Type', 'application/json');
    response.type('application/json');

    if (Object.keys(kwargs).length){
        smtpTransport.sendMail(options, function (error, result) {
            if (error){
                kwargs['status'] = false;
                kwargs['raise'] = error;
                console.error("Error message send: " + result.message);
            }else{
                kwargs['status'] = true;
            }
        });
    // response.json(kwargs);
    }else{
        response.json(kwargs);
    }
}