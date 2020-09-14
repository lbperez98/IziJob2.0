import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

void enviarMail(String email) async{
  final smtpServer = gmail('izijoblp@gmail.com', "Lebron23\$");
  final message = Message()
    ..from = Address('izijoblp@gmail.com', 'IZIJOB')
    ..recipients.add(email)
    ..ccRecipients.addAll([email])
    ..bccRecipients.add(Address(email))
    ..subject = '¡Bienvenido a IziJob! 😀 La fecha de tu registro es: ${DateTime.now()}'
    ..text = 'Pilas .\nVergeles si responde.'
    ..html = "<h1>Bienvenido a IziJob!</h1>\n<p>Pronto el trabajo de tu sueño te contactará!</p>";

    try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }




}

