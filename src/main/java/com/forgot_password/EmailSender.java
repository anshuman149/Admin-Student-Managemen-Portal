package com.forgot_password;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailSender {

    public static void sendOTP(String recipientEmail, String otp) {
        
        // 1. Apna Gmail address aur App Password yahan daal
        final String senderEmail = "noreply.university.com@gmail.com"; // Apna asli Gmail ID likh
        final String senderPassword = "otqs uysn oqud ttzx"; // Google wala 16-digit password

        // 2. Gmail SMTP Server ki settings
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // 3. Email account me login karna
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        // 4. Email ka Content (Message) taiyaar karna aur bhejna
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            
            // Email ka Subject
            message.setSubject("Password Reset OTP - Student Portal");
            
            // Email ke andar ka Message
            message.setText("Hello,\n\nThis is the otp FOR RESET PASSWORD " + otp + "\n\nDONT SHARE OTP WITH ANYONE");

            // Email fire kar do!
            Transport.send(message);
            System.out.println("Email has been sent on " + recipientEmail);

        } catch (MessagingException e) {
            System.out.println("Finding Error on sending mail");
            e.printStackTrace();
        }
    }
}