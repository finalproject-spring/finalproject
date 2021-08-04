package com.spring.recycle.model.dto;

import java.util.Date;

public class PaymentDto {
	/*
	 * PAY_NUM NUMBER PRIMARY KEY,
	PAY_PRODUCT VARCHAR2(50) NOT NULL,
	PAY_CATEGORY VARCHAR2(20) NOT NULL CHECK (PAY_CATEGORY IN ('상품판매', '회원거래', '펀딩')),
	PAY_STATUS VARCHAR2(20) NOT NULL CHECK (PAY_STATUS IN ('결제완료', '결제취소대기', '결제취소')),
	PAY_BUYER VARCHAR2(20) NOT NULL,
	PAY_PRODUCTER VARCHAR2(20) NOT NULL,
	PAY_DATE DATE NOT NULL,
	MEMBER_NO NUMBER NOT NULL,
	CONSTRAINT PAYMENT_FK FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO) ON DELETE CASCADE 
	 */
	
	private int pay_num;
	private String pay_product;
	private String pay_category;
	private String pay_status;
	private String pay_buyer;
	private String pay_producter;
	private int pay_count;
	private int pay_price;
	private int funding_no;
	private Date pay_date;
	private String merchant_uid;
	
	
	public PaymentDto() {
		super();
	}


	public PaymentDto(int pay_num, String pay_product, String pay_category, String pay_status, String pay_buyer,
			String pay_producter, int pay_count, int pay_price, int funding_no, Date pay_date, String merchant_uid) {
		super();
		this.pay_num = pay_num;
		this.pay_product = pay_product;
		this.pay_category = pay_category;
		this.pay_status = pay_status;
		this.pay_buyer = pay_buyer;
		this.pay_producter = pay_producter;
		this.pay_count = pay_count;
		this.pay_price = pay_price;
		this.funding_no = funding_no;
		this.pay_date = pay_date;
		this.merchant_uid = merchant_uid;
	}


	public int getPay_num() {
		return pay_num;
	}


	public void setPay_num(int pay_num) {
		this.pay_num = pay_num;
	}


	public String getPay_product() {
		return pay_product;
	}


	public void setPay_product(String pay_product) {
		this.pay_product = pay_product;
	}


	public String getPay_category() {
		return pay_category;
	}


	public void setPay_category(String pay_category) {
		this.pay_category = pay_category;
	}


	public String getPay_status() {
		return pay_status;
	}


	public void setPay_status(String pay_status) {
		this.pay_status = pay_status;
	}


	public String getPay_buyer() {
		return pay_buyer;
	}


	public void setPay_buyer(String pay_buyer) {
		this.pay_buyer = pay_buyer;
	}


	public String getPay_producter() {
		return pay_producter;
	}


	public void setPay_producter(String pay_producter) {
		this.pay_producter = pay_producter;
	}


	public int getPay_count() {
		return pay_count;
	}


	public void setPay_count(int pay_count) {
		this.pay_count = pay_count;
	}


	public int getPay_price() {
		return pay_price;
	}


	public void setPay_price(int pay_price) {
		this.pay_price = pay_price;
	}


	public int getFunding_no() {
		return funding_no;
	}


	public void setFunding_no(int funding_no) {
		this.funding_no = funding_no;
	}


	public Date getPay_date() {
		return pay_date;
	}


	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}


	public String getMerchant_uid() {
		return merchant_uid;
	}


	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}


	@Override
	public String toString() {
		return "PaymentDto [pay_num=" + pay_num + ", pay_product=" + pay_product + ", pay_category=" + pay_category
				+ ", pay_status=" + pay_status + ", pay_buyer=" + pay_buyer + ", pay_producter=" + pay_producter
				+ ", pay_count=" + pay_count + ", pay_price=" + pay_price + ", funding_no=" + funding_no + ", pay_date="
				+ pay_date + ", merchant_uid=" + merchant_uid + "]";
	}


}
