package org.tour.util;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.http.MediaType;

public class ImageUtils {

	private static Map<String, MediaType> mediaMap;
	
	static {
		mediaMap = new HashMap<String, MediaType>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("JPEG", MediaType.IMAGE_JPEG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
	}
	
	public static byte[] makeThumnail(byte[] realImage, String formatType) throws Exception{
		
		// BufferedImage�� ���� thumnail�����
		ByteArrayInputStream bain = new ByteArrayInputStream(realImage);
		BufferedImage sourceImage = ImageIO.read(bain);
		BufferedImage destImage = Scalr.resize(sourceImage, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		
		// �ٽ� byte[]�� ���� return�ϱ�
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ImageIO.write(destImage, formatType, baos);
		byte[] thumnailImage = baos.toByteArray();
		
		return thumnailImage;
	}
	
	public static MediaType getMediaType(String type) {
		return mediaMap.get(type.toUpperCase());
	}
}
