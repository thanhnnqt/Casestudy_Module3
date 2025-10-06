package com.example.du_an.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailUtil {

    private static final String FROM_EMAIL = "huyduong03111@gmail.com";
    private static final String FROM_PASSWORD = "fzyp bekj iyvk qeza";

    public static void sendEmail(String toEmail, String subject, String content) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
                }
            });
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Tiệm Cầm Đồ", "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject, "UTF-8");
            message.setText(content, "UTF-8");

            Transport.send(message);
            System.out.println("✅ Email sent successfully to: " + toEmail);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
