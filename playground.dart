void main() {
  final value = generateMailtoLink(
    listOfMails: listOfMails,
    subject: 'Job Application for Full Stack Developer Position',
    body: body,
  );
  print(value);
}

String body = """
Dear Hiring Manager,

I hope this message finds you well.

I am writing to express my keen interest in the Full Stack Developer position at your esteemed organization. With a solid background in both front-end and back-end technologies, I bring a comprehensive skill set and a passion for building robust, scalable web applications.

I have attached my resume and portfolio for your review. I would welcome the opportunity to discuss how my experience aligns with your team's goals and how I can contribute effectively.

Thank you for considering my application. I look forward to the possibility of speaking with you further.

https://drive.google.com/file/d/1XvbB4TUCFHoV1wCeZ_AvlBcOSDI2pmOq/view?usp=sharing

Best regards,
Ankit Raj
Phone : +918825298311
LinkedIn : https://www.linkedin.com/in/ankit-raj-716781254/
Github : https://github.com/AnkitRaj20
""";
String generateMailtoLink({
  required List<String> listOfMails,
  required String subject,
  required String body,
}) {
  final String to = listOfMails.join(',');
  final String encodedSubject = Uri.encodeComponent(subject);
  final String encodedBody = Uri.encodeComponent(body);
  return 'mailto:$to?subject=$encodedSubject&body=$encodedBody';
}

final listOfMails = [
  "pallavi.sharma@appventurez.com",
  "hello@flitzen.com",
  "career@logicgoinfotech.com",
  "hr@delata.co",
  "careers@techwatelabs.com",
  "career@logicgoinfotech.com",
  "hr@deepcoder.io",
  "reema@ideausher.com",
  "hr_executive@esferasoft.com",
  "career@yashidatech.com",
  "hr_executive@esferasoft.com",
  "hr.techpandasia@gmail.com",
  "divya.dadhaniya@orionik.com",
  "bhanupriya.venugopal@landmarkgroup.com",
  "kavya@applaunch.io",
  "hr@linkdevelopment.sa",
  "team@nexxuslab.com",
  "hr@raad-m.com",
  "hr@raad-m.com",
  "hr@equitysoft.in",
  "cecille@famproperties.com",
  "info@dioneapps.com",
  "career@logicgoinfotech.com",
  "hr@jploft.com",
  "hr@techdocklabs.com",
  "reema@ideausher.com",
  "tanisha.rathore@provistechnologies.com",
  "info@bmninfotech.com",
  "hr@devlynxtech.com",
  "skylar.solomon@gmail.com",
  "soujanya@todquest.com",
  "ht@webnautical.com",
  "team@innvocan.co.in",
  "career@toxsl.com",
  "careers@dhiwise.com",
  "sanket@raneso.com",
  "richa@eoxysit.com",
  "bhavya@tentacle.solutions",
  "pallavi.sharma@appventurez.com",
];
