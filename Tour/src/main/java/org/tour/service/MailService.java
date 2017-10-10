package org.tour.service;

import org.springframework.mail.SimpleMailMessage;

public interface MailService {
	
	public void send(SimpleMailMessage message);
	
}
