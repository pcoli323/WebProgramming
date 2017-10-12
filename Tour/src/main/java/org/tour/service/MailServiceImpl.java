package org.tour.service;

import java.io.File;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailServiceImpl implements MailService {

	@Inject
	private JavaMailSender javaMailSender;

	@Override
	public void send(SimpleMailMessage message) {
		javaMailSender.send(message);
	}

}
