package com.spring.recycle.model.dto;

import java.util.Arrays;

public class MessageDelDto {
	
	private int[] message_noList;

	public int[] getMessage_noList() {
		return message_noList;
	}

	public void setMessage_noList(int[] message_noList) {
		this.message_noList = message_noList;
	}

	@Override
	public String toString() {
		return "MessageDelDto [message_noList=" + Arrays.toString(message_noList) + "]";
	}
	
	
}
