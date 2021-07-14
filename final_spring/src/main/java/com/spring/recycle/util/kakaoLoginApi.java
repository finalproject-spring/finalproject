package com.spring.recycle.util;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class kakaoLoginApi extends DefaultApi20 {

		
	public kakaoLoginApi() {
	
	}

    private static class InstanceHolder {
        private static final kakaoLoginApi INSTANCE = new kakaoLoginApi();
      }

      public static kakaoLoginApi instance() {
        return InstanceHolder.INSTANCE;
      }
	
	@Override
	public String getAccessTokenEndpoint() {
		return "https://kauth.kakao.com/oauth/token?grant_type=authorization_code";
	}

	@Override
	protected String getAuthorizationBaseUrl() {
		return "https://kauth.kakao.com/oauth/authorize";	
	}

}
