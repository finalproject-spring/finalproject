package com.spring.recycle.controller;

import java.beans.PropertyEditorSupport;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.google.gson.JsonObject;
import com.spring.recycle.model.biz.FundingBiz;
import com.spring.recycle.model.biz.PaymentBiz;
import com.spring.recycle.model.biz.PaymentBizImpl;
import com.spring.recycle.model.dto.FundingDto;
import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.model.dto.PaymentDto;
import com.spring.recycle.util.FundingPageMaker;
import com.spring.recycle.util.FundingSearchCriteria;


@Controller
public class FundingController {
	
	private Logger logger = LoggerFactory.getLogger(FundingController.class);
	
	@Autowired
	private FundingBiz biz;
	@Autowired
	private PaymentBiz pbiz;
	
	
	@RequestMapping(value="/funding_list.do", method = RequestMethod.GET)
	public String listPage(Model model, HttpServletRequest request,@ModelAttribute("scri") FundingSearchCriteria scri) {
		if (scri.getFunding_filter().contains("전체보기") || scri.getFunding_filter().contains("카테고리를")) {
			scri.setFunding_filter("");
		}
		
		MemberDto memberdto = (MemberDto) request.getSession().getAttribute("dto");
		model.addAttribute("memberdto", memberdto);
		model.addAttribute("list", biz.fundingList(scri));
		
		FundingPageMaker pageMaker = new FundingPageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(biz.listCount(scri));
		model.addAttribute("scri", scri);
		model.addAttribute("pageMaker", pageMaker);
		
		return "funding/funding_list";
	}

	
	@RequestMapping("funding_insertform.do")
	public String insertForm() {
		
		return "funding/funding_insert";
	}
	
	@RequestMapping("funding_detail.do")
	public String selectOne(Model model, HttpServletRequest request, int funding_no, FundingSearchCriteria scri) {
		MemberDto memberdto = (MemberDto) request.getSession().getAttribute("dto");
		model.addAttribute("memberdto", memberdto);
		model.addAttribute("dto", biz.fundingDetail(funding_no));
		model.addAttribute("scri", scri);
		
		return "funding/funding_detail";
	}
	
	@RequestMapping(value="/funding_uploadSummernoteImg.do", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String uploadSummernoteImg(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request) {
		JsonObject jsonObject = new JsonObject();
		
		// 내부 경로 저장
		String contextRoot = request.getSession().getServletContext().getRealPath("/");
		System.out.println("contextRoot: " + contextRoot);
		String fileRoot = contextRoot + "resources/fileupload/funding_img/";
		String realFolder = request.getSession().getServletContext().getRealPath("funding_img");
		System.out.println("realFolder: " + realFolder);
		System.out.println(fileRoot);
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		File targetFile = new File(fileRoot + savedFileName);	
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "resources/fileupload/funding_img/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String res = jsonObject.toString();
		return res;
		
	}
	
	@RequestMapping("/funding_insertres.do")
	public String insertRes(MultipartFile uploadfile, FundingDto dto, HttpServletRequest request) throws IOException {

		logger.info("upload file name : " + uploadfile.getOriginalFilename());
		logger.info("upload file size: " + uploadfile.getSize());
		String contextRoot = request.getSession().getServletContext().getRealPath("/");
		String fileRoot = contextRoot + "resources/fileupload/funding_img/";
		String originalFileName = uploadfile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		File targetFile = new File(fileRoot + savedFileName);
		InputStream fileStream;
		fileStream = uploadfile.getInputStream();
		FileUtils.copyInputStreamToFile(fileStream, targetFile);

		dto.setFunding_pic("resources/fileupload/funding_img/"+savedFileName);


		if(biz.fundingInsert(dto) > 0) {
			return "redirect:funding_list.do";
		}
			return "redirect:funding_insertform.do";
	}
	
	@RequestMapping("/funding_updateform.do")
	public String updateForm(Model model, int funding_no) {
		model.addAttribute("dto", biz.fundingDetail(funding_no));
		return "funding/funding_update";
	}
	
	@RequestMapping("/funding_updateres.do")
	public String updateRes(FundingDto dto, int funding_no, @RequestParam(required = false) MultipartFile uploadfile, HttpServletRequest request) throws IOException {
		logger.info("-----------------------업로드파일" + uploadfile);
		if (uploadfile.getSize() != 0) {
			String contextRoot = request.getSession().getServletContext().getRealPath("/");
			String fileRoot = contextRoot + "resources/fileupload/funding_img/";
			String originalFileName = uploadfile.getOriginalFilename();	//오리지날 파일명
			String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
			String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
			File targetFile = new File(fileRoot + savedFileName);
			InputStream fileStream;
			fileStream = uploadfile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);

			dto.setFunding_pic("resources/fileupload/funding_img/"+savedFileName);
		}
		
		if (biz.fundingUpdate(dto) > 0) {
			return "redirect:funding_detail.do?funding_no="+funding_no;
		}
		return "redirect:funding_updateform.do?funding_no="+funding_no;
	}
	
	@RequestMapping("/funding_delete.do")
	public String delete(int funding_no) {
		
		if(biz.fundingDelete(funding_no) > 0) {
			return "redirect:funding_list.do";
		}
		return "redirect:funding_detail.do?funding_no="+funding_no;
	}
	
	
	//태히 추가 
	@RequestMapping("/funding_kakaopay.do")
	public String fundingpay(HttpServletRequest request , Model model, PaymentDto dto) {
		MemberDto memberdto = (MemberDto) request.getSession().getAttribute("dto");
		FundingDto dtof = new FundingDto();
		model.addAttribute("memberdto", memberdto);
		dtof = biz.fundingDetail(dto.getFunding_no());
		model.addAttribute("fundingdto", dtof);
		model.addAttribute("paymentdto", dto);
		
		return "funding/funding_kakaopay";
	}
	
	   @RequestMapping("/funding_paySuccess.do")
	   public String funding_Success(HttpServletRequest request , Model model ,PaymentDto paymentdto, int funding_no, int pay_count, int pay_price, String merchant_uid  ) { 
	      MemberDto memberdto = (MemberDto) request.getSession().getAttribute("dto");
	      FundingDto fundingdto = biz.fundingDetail(funding_no);
	      model.addAttribute("fundingdto", fundingdto);
	      model.addAttribute("dto", memberdto);
	      
	      paymentdto.setPay_buyer(memberdto.getMember_id());
	      paymentdto.setPay_product(fundingdto.getFunding_title());
	      paymentdto.setPay_count(pay_count);
	      paymentdto.setPay_price(pay_price);
	      paymentdto.setMerchant_uid(merchant_uid);
	      int res = 0;
	      res = pbiz.paymentInsert(paymentdto);
	      logger.info("paymentdto");
	      int amount = pay_count * pay_price;
	      fundingdto.setFunding_ca(amount);
	      biz.caUpdate(fundingdto);
	      model.addAttribute("paymentdto", paymentdto);
	      model.addAttribute("amount",amount);
	      return "funding/funding_paySuccess";
	   }
	   
	
	@RequestMapping("/funding_payFail.do")
	public String funding_fail() {
		
		return "funding/funding_payFail";
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) throws Exception {
	    binder.registerCustomEditor(MultipartFile.class, new PropertyEditorSupport() {

	        @Override
	        public void setAsText(String text) {
	            logger.debug("initBinder MultipartFile.class: {}; set null;", text);
	            setValue(null);
	        }

	    });
	}
	
	@RequestMapping("/funding_payRefund.do")
	public String funding_payRefund(String merchant_uid) {
		
		return "funding/funding_payRefund";
	}

}
