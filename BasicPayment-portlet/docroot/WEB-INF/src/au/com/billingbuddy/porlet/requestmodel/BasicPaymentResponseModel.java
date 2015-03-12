package au.com.billingbuddy.porlet.requestmodel;

import au.com.billingbuddy.requestmodel.RequestModel;

public class BasicPaymentResponseModel extends RequestModel {

	private String message;
	private String status;
	private String data;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

}
