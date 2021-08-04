package com.spring.recycle.util;

import com.google.api.gax.rpc.ApiException;
import com.google.cloud.dialogflow.v2.DetectIntentResponse;
import com.google.cloud.dialogflow.v2.Intent.Message.Text;
import com.google.cloud.dialogflow.v2.QueryInput;
import com.google.cloud.dialogflow.v2.QueryResult;
import com.google.cloud.dialogflow.v2.SessionName;
import com.google.cloud.dialogflow.v2.SessionsClient;
import com.google.cloud.dialogflow.v2.TextInput;
import java.io.IOException;
import java.util.List;

public class DetectIntentTexts {
	
	  public static String detectIntentTexts(String projectId, List<String> texts, String sessionId, String languageCode)
	      throws IOException, ApiException {

		String responseMessage = null;
	    
	    try (SessionsClient sessionsClient = SessionsClient.create()) {
	      // 세션 아이디(UUID), 구글 프로젝트 아이디 입력
	      SessionName session = SessionName.of(projectId, sessionId);
	      System.out.println("Session Path: " + session.toString());

	      for (String text : texts) {
	        TextInput.Builder textInput =
	            TextInput.newBuilder().setText(text).setLanguageCode(languageCode);

	        QueryInput queryInput = QueryInput.newBuilder().setText(textInput).build();

	        DetectIntentResponse response = sessionsClient.detectIntent(session, queryInput);

	        QueryResult queryResult = response.getQueryResult();

	        Text textMessage = queryResult.getFulfillmentMessages(0).getText();
	        responseMessage = textMessage.getText(0);
	        
	      }
	    }
	    return responseMessage;
	  }

}
