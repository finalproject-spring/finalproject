package com.spring.recycle.model.dto;

public class WishDto {

	private int wish_no;
	private String wish_id;
	private String wish_product;
	private int board_no;
	public WishDto() {}
	public WishDto(int wish_no, String wish_id, String wish_product, int board_no) {
		this.wish_no = wish_no;
		this.wish_id = wish_id;
		this.wish_product = wish_product;
		this.board_no = board_no;
	}
	public int getWish_no() {
		return wish_no;
	}
	public void setWish_no(int wish_no) {
		this.wish_no = wish_no;
	}
	public String getWish_id() {
		return wish_id;
	}
	public void setWish_id(String wish_id) {
		this.wish_id = wish_id;
	}
	public String getWish_product() {
		return wish_product;
	}
	public void setWish_product(String wish_product) {
		this.wish_product = wish_product;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	};
}
