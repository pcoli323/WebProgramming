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
		
		// BufferedImage를 통해 thumnail만들기
		ByteArrayInputStream bain = new ByteArrayInputStream(realImage);
		BufferedImage sourceImage = ImageIO.read(bain);
		BufferedImage destImage = Scalr.resize(sourceImage, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 140);
		
		// 다시 byte[]로 만들어서 return하기
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ImageIO.write(destImage, formatType, baos);
		//gif는 thumnail로 쓰여지지 않는 거 같음 -> ImageIO.write에 formType에서 gif를 지원하지 않음
		byte[] thumnailImage = baos.toByteArray();
		
		return thumnailImage;
	}
	
	public static MediaType getMediaType(String type) {
		return mediaMap.get(type.toUpperCase());
	}
}
