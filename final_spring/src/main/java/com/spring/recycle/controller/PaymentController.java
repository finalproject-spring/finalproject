package com.spring.recycle.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.recycle.model.biz.DealBiz;
import com.spring.recycle.model.biz.FundingBiz;
import com.spring.recycle.model.biz.PaymentBiz;
import com.spring.recycle.model.dto.DealBoardDto;
import com.spring.recycle.model.dto.FundingDto;
import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.model.dto.PaymentDto;

@Controller
public class PaymentController {
	
	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
	
	@Autowired
	PaymentBiz biz;
	
	@Autowired
	FundingBiz fbiz;
	
	@Autowired
	DealBiz dealBiz;
	
    public static final String IMPORT_TOKEN_URL = "https://api.iamport.kr/users/getToken";
    public static final String IMPORT_CANCEL_URL = "https://api.iamport.kr/payments/cancel";

    public static final String KEY = "5078150538585418";
    public static final String SECRET = "86738b1ec49746997ec747a63da13f3c27f7ad6497f27c6593561bf5cd92a3241abbe9499fb56b40";

    // 아임포트 인증(토큰)을 받아주는 함수
    public String getImportToken() throws IOException, ParseException {
    	HttpURLConnection con = null;
    	String access_token = null;
    	
    	
    	try {
    		URL url = new URL(IMPORT_TOKEN_URL);
    		con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/json");
			con.setRequestProperty("Accept", "application/json");
			con.setDoOutput(true);
			
			JSONObject obj = new JSONObject();
			obj.put("imp_key", KEY);
			obj.put("imp_secret", SECRET);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(con.getOutputStream()));
			bw.write(obj.toString());
			bw.flush();
			bw.close();
			
			String result = "";
			int responseCode = con.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			if(responseCode == 200) {
				BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
				String line = null;
				while ((line = br.readLine()) != null){
					result += line;
				}
				JSONParser parsing = new JSONParser();				
				Object object = parsing.parse(result.toString());
				JSONObject jsonObj = (JSONObject)object;
				JSONObject resObj = (JSONObject)jsonObj.get("response");
				access_token = (String)resObj.get("access_token");
				System.out.println("token : " + access_token);
				
				br.close();

			} else {
				System.out.println(con.getResponseMessage());
			}
			
		} catch (ProtocolException e) {
			e.printStackTrace();
		}
    
    	return access_token;
    	
    }
    
    @RequestMapping("admin_paycancel.do")
    public String payCancel(int pay_num) throws IOException, ParseException {
    	PaymentDto dto = new PaymentDto();
    	dto = biz.paymentDetail(pay_num);
    	System.out.println(dto);
    	HttpURLConnection con = null;
    	String access_token = getImportToken();
    	
    	try {
    		URL url = new URL(IMPORT_CANCEL_URL);
    		con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/json");
			con.setRequestProperty("Authorization", access_token);
			con.setDoOutput(true);
			
			JSONObject obj = new JSONObject();
			System.out.println(dto.getMerchant_uid());
			obj.put("merchant_uid", dto.getMerchant_uid());
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(con.getOutputStream()));
			bw.write(obj.toString());
			bw.flush();
			bw.close();
			
			String result = "";
			int responseCode = con.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			if(responseCode == 200) {
				BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
				String line = null;
				while ((line = br.readLine()) != null){
					result += line;
				}
				JSONParser parsing = new JSONParser();				
				Object object = parsing.parse(result.toString());
				System.out.println(object);
				JSONObject jsonObj = (JSONObject)object;
				System.out.println(jsonObj);
				JSONObject resObj = (JSONObject)jsonObj.get("response");
				String code = (String)resObj.get("code");
				
				br.close();
				
				logger.info("결제 취소 성공");
				int count = dto.getPay_count();
				int price = dto.getPay_price();
				int amount = (count * price);
				FundingDto fdto = new FundingDto();
				fdto.setFunding_ca(amount);
				fbiz.cancelCaUpdate(fdto);
				int res = biz.paymentCancelSuccess(pay_num);
				System.out.println("결제 상태 변경 :" + res);
			} else {
				System.out.println(con.getResponseMessage());
			}
			
		} catch (ProtocolException e) {
			e.printStackTrace();
		}
    	
    	return "redirect:admin_payCancelList.do";
    }
 
    @RequestMapping("funding_paycancel.do")
    public String funding_payCancel(String merchant_uid , int funding_no, HttpServletResponse response , PaymentDto paymentdto,  HttpServletRequest request , Model model , int pay_count, int pay_price  ) throws IOException, ParseException {
       PaymentDto dto = new PaymentDto();
       dto = biz.paymentDetail2(merchant_uid);
       System.out.println("컨트롤러 : " + dto);
       System.out.println("컨트롤러 : " + merchant_uid);
       HttpURLConnection con = null;
       String access_token = getImportToken();
       
       try {
          URL url = new URL(IMPORT_CANCEL_URL);
          con = (HttpURLConnection) url.openConnection();
         con.setRequestMethod("POST");
         con.setRequestProperty("Content-Type", "application/json");
         con.setRequestProperty("Authorization", access_token);
         con.setDoOutput(true);
         
         JSONObject obj = new JSONObject();
         System.out.println(dto.getMerchant_uid());
         obj.put("merchant_uid", dto.getMerchant_uid());
         
         BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(con.getOutputStream()));
         bw.write(obj.toString());
         bw.flush();
         bw.close();
         
         String result = "";
         int responseCode = con.getResponseCode();
         System.out.println("responseCode : " + responseCode);
         if(responseCode == 200) {
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String line = null;
            while ((line = br.readLine()) != null){
               result += line;
            }
            JSONParser parsing = new JSONParser();            
            Object object = parsing.parse(result.toString());
            System.out.println(object);
            JSONObject jsonObj = (JSONObject)object;
            System.out.println(jsonObj);
            JSONObject resObj = (JSONObject)jsonObj.get("response");
            String code = (String)resObj.get("code");
            
            br.close();
            
            logger.info("결제 취소 성공");
            int count = dto.getPay_count();
            int price = dto.getPay_price();
            int amount = (count * price);
            FundingDto fdto = new FundingDto();
            fdto.setFunding_ca(amount);
            fdto.setFunding_no(funding_no);
            System.out.println(fdto);
            int res2 =fbiz.cancelCaUpdate(fdto);
            logger.info("펀딩 현재 모금액 차감 : "+ res2);
            int res = biz.paymentCancelSuccess(dto.getPay_num());
            System.out.println("결제 상태 변경 :" + res);
         } else {
            System.out.println(con.getResponseMessage());
         }
         
      } catch (ProtocolException e) {
         e.printStackTrace();
      }
       
       
       MemberDto memberdto = (MemberDto) request.getSession().getAttribute("dto");
        FundingDto fundingdto = fbiz.fundingDetail(funding_no);
         model.addAttribute("fundingdto", fundingdto);
         model.addAttribute("dto", memberdto);
         model.addAttribute("paymentdto", paymentdto);
         paymentdto.setPay_buyer(memberdto.getMember_id());
         paymentdto.setPay_product(fundingdto.getFunding_title());
         paymentdto.setPay_count(pay_count);
         paymentdto.setPay_price(pay_price);
         paymentdto.setMerchant_uid(merchant_uid);
         int amount = pay_count * pay_price;
         fundingdto.setFunding_ca(amount);
         
         model.addAttribute("paymentdto", paymentdto);
         model.addAttribute("amount",amount);
         logger.info("memberdto");
       return "funding/funding_refund";
    }

    
    //결제 - 태희추가 
    @RequestMapping("/deal_kakaopay.do")
    public String dealPay(int board_no,HttpServletRequest request , Model model, PaymentDto dto) {
    	logger.info("paymentdto =" + dto);
       MemberDto memberdto = (MemberDto) request.getSession().getAttribute("dto");
       DealBoardDto dealDto = new DealBoardDto();
       model.addAttribute("memberdto", memberdto);
       model.addAttribute("dealDto", dealBiz.selectDeal(board_no));
       model.addAttribute("paymentdto", dto);
       
       return "deal/deal_kakaopay";
       
    }
    
}
