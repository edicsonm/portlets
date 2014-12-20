package au.com.billingbuddy.jsonprocessor;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import au.com.billingbuddy.exceptions.objects.JsonException;
import au.com.billingbuddy.porlet.common.objects.ConfigurationPortal;
import au.com.billingbuddy.porlet.requestmodel.BasicPaymentModel;

public class JsonProcessor {

	private static JsonProcessor instance;
	private static ConfigurationPortal configurationPortalInstance = ConfigurationPortal.getInstance();
	public static synchronized JsonProcessor getInstance() {
		if (instance == null) {
			instance = new JsonProcessor();
		}
		return instance;
	}

	private JsonProcessor() {}
	
	public JSONObject encodeJSONBasicPayment(BasicPaymentModel basicPaymentModel) {
		JSONObject jSONObject = new JSONObject();

		basicPaymentModel.getName();
		basicPaymentModel.getEmail();
		basicPaymentModel.getCompanyName();
		basicPaymentModel.getCardNumber();
		basicPaymentModel.getExpirationYear();
		basicPaymentModel.getExpirationMonth();
		basicPaymentModel.getCvv();
		
		jSONObject.put("name", basicPaymentModel.getName());
		jSONObject.put("email", basicPaymentModel.getEmail());
		jSONObject.put("companyname", basicPaymentModel.getCompanyName());
		jSONObject.put("ccnum", basicPaymentModel.getCardNumber());
		jSONObject.put("expyear", basicPaymentModel.getExpirationYear());
		jSONObject.put("expmonth", basicPaymentModel.getExpirationMonth());
		jSONObject.put("cvc", basicPaymentModel.getCvv());
		
		jSONObject.put("i", basicPaymentModel.getIp());
		jSONObject.put("sessionID", basicPaymentModel.getSessionId());
		jSONObject.put("user_agent", basicPaymentModel.getUserAgent());
		jSONObject.put("accept_language", basicPaymentModel.getAcceptLanguage());
		
		
		jSONObject.put("product", "Toothbrush");
		jSONObject.put("qty", "2");
		jSONObject.put("rate", "100.0");
		jSONObject.put("total", "100");
		jSONObject.put("order_currency", "USD");
		jSONObject.put("shopID", "1");
		jSONObject.put("txn_type", "creditcard");
		jSONObject.put("city", "New York");
		
		jSONObject.put("region", "NY");
		jSONObject.put("postal", "11434");
		jSONObject.put("country", "US");
		jSONObject.put("domain", "yahoo.com");
		jSONObject.put("emailMD5", "Adeeb@Hackstyle.com");
		jSONObject.put("usernameMD5", "1234");
		jSONObject.put("passwordMD5", "test_carder_password");

		jSONObject.put("shipAddr", "145-50 157TH STREET");
		jSONObject.put("shipCity", "Jamaica");
		jSONObject.put("shipRegion", "NY");
		jSONObject.put("shipPostal", "11434");
		jSONObject.put("shipCountry", "US");
		jSONObject.put("txnID", "1234");
		
		return jSONObject;
	}
	
	public static BasicPaymentModel decodeJSONBasicPayment(String jsonMessage) throws JsonException {
		BasicPaymentModel basicPaymentModel = new BasicPaymentModel();
		try {
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(jsonMessage);
			JSONObject jSONObject = (JSONObject) obj;
			basicPaymentModel.setMessage(jSONObject.get("message").toString());
			basicPaymentModel.setStatus(jSONObject.get("status").toString());
			basicPaymentModel.setData(jSONObject.get("data") != null ? jSONObject.get("data").toString(): "");
			return basicPaymentModel;
		} catch (ParseException e) {
			basicPaymentModel.setStatus(configurationPortalInstance.getKey("failure"));
			basicPaymentModel.setMessage(configurationPortalInstance.getKey("JsonException.1"));
			return basicPaymentModel;
		}
	}

}
