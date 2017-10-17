package org.tour.controller;

import javax.inject.Inject;

//import org.json.simple.JSONObject;
//import org.json.simple.parser.JSONParser;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.tour.domain.ImageVO;
import org.tour.service.CourseInfoService;
import org.tour.service.ImageService;
import org.tour.util.ImageUtils;

@Controller
public class ImageController {

	@Inject
	private ImageService imageService;
	@Inject
	private CourseInfoService courseInfoService;
	
	// db에 저장된 realImage 화면에 보여주기
	@RequestMapping(value = "/getRealImage", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getRealImage(@RequestParam("imageNumber") int imageNumber) throws Exception{
		Object image = imageService.getRealImage(imageNumber);
		byte[] imageContent = (byte[]) image;
		final HttpHeaders headers = new HttpHeaders();
		headers.setContentType(ImageUtils.getMediaType(imageService.getType(imageNumber)));
		return new ResponseEntity<byte[]>(imageContent, headers, HttpStatus.OK);
	}
	// db에 저장된 thumImage 화면에 보여주기
	@RequestMapping(value = "/getThumImage", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getThumImage(@RequestParam("imageNumber") int imageNumber) throws Exception{
		Object image = imageService.getThumImage(imageNumber);
		byte[] imageContent = (byte[]) image;
		final HttpHeaders headers = new HttpHeaders();
		headers.setContentType(ImageUtils.getMediaType(imageService.getType(imageNumber)));
		return new ResponseEntity<byte[]>(imageContent, headers, HttpStatus.OK);
	}
	
	// realImage이름 알아오기
	@RequestMapping(value = "/getGotoRealImage", method = RequestMethod.GET)
	public ResponseEntity<String> getGotoRealImage(@RequestParam("gotoNumber") int gotoNumber) throws Exception{
		ResponseEntity<String> entity = null;
		try {
			String realImage = courseInfoService.getRealImage(gotoNumber);
			entity = new ResponseEntity<String>(realImage, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// upload에서 imageUpload 동작
	@RequestMapping(value = "/imageUpload", method = RequestMethod.GET)
	public String imageUpload() throws Exception{
		
		return "/mypage/imageUpload";
	}
		
	@ResponseBody
	@RequestMapping(value = "/imageUpload/{userNumber}/{gotoNumber}", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> imageUpload(@PathVariable("userNumber") int userNumber, @PathVariable("gotoNumber") int gotoNumber,
																									MultipartFile file) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		try {
			ImageVO imageVO = new ImageVO();
			byte[] realFile = file.getBytes();
			String[] formatType = file.getContentType().split("/");
			byte[] thumFile = ImageUtils.makeThumnail(realFile, formatType[1]);
			
			imageVO.setUserNumber(userNumber);
			imageVO.setRealfile(realFile);
			imageVO.setThumfile(thumFile);
			imageVO.setType(formatType[1]);
			imageService.insertImage(imageVO);
			courseInfoService.changeImage(gotoNumber, imageVO.getImageNumber());
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.CREATED);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	/*
	@RequestMapping(value = "/imageDelete/{gotoNumber}", method = RequestMethod.DELETE)
	public ResponseEntity<String> imageDelete(@PathVariable("gotoNumber") int gotoNumber, @RequestBody String deleteImage) throws Exception{
		
		ResponseEntity<String> entity = null;
		try{
			JSONParser parser = new JSONParser();
			JSONObject jsonobject = (JSONObject)parser.parse(deleteImage);
			String imageURL = (String)jsonobject.get("deleteImage");
			String[] imageNumber = imageURL.split("=");
			
			courseInfoService.deleteImage(gotoNumber);
			imageService.deleteIamge(Integer.parseInt(imageNumber[1]));
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	*/
}
