/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

package au.com.billingbuddy.porlet.services.model;

import java.io.Serializable;

import java.util.ArrayList;
import java.util.List;

/**
 * This class is used by SOAP remote services, specifically {@link au.com.billingbuddy.porlet.services.service.http.BusinessTypeServiceSoap}.
 *
 * @author Edicson Morales
 * @see au.com.billingbuddy.porlet.services.service.http.BusinessTypeServiceSoap
 * @generated
 */
public class BusinessTypeSoap implements Serializable {
	public static BusinessTypeSoap toSoapModel(BusinessType model) {
		BusinessTypeSoap soapModel = new BusinessTypeSoap();

		soapModel.setButy_ID(model.getButy_ID());
		soapModel.setButy_Description(model.getButy_Description());
		soapModel.setButy_Status(model.getButy_Status());

		return soapModel;
	}

	public static BusinessTypeSoap[] toSoapModels(BusinessType[] models) {
		BusinessTypeSoap[] soapModels = new BusinessTypeSoap[models.length];

		for (int i = 0; i < models.length; i++) {
			soapModels[i] = toSoapModel(models[i]);
		}

		return soapModels;
	}

	public static BusinessTypeSoap[][] toSoapModels(BusinessType[][] models) {
		BusinessTypeSoap[][] soapModels = null;

		if (models.length > 0) {
			soapModels = new BusinessTypeSoap[models.length][models[0].length];
		}
		else {
			soapModels = new BusinessTypeSoap[0][0];
		}

		for (int i = 0; i < models.length; i++) {
			soapModels[i] = toSoapModels(models[i]);
		}

		return soapModels;
	}

	public static BusinessTypeSoap[] toSoapModels(List<BusinessType> models) {
		List<BusinessTypeSoap> soapModels = new ArrayList<BusinessTypeSoap>(models.size());

		for (BusinessType model : models) {
			soapModels.add(toSoapModel(model));
		}

		return soapModels.toArray(new BusinessTypeSoap[soapModels.size()]);
	}

	public BusinessTypeSoap() {
	}

	public int getPrimaryKey() {
		return _Buty_ID;
	}

	public void setPrimaryKey(int pk) {
		setButy_ID(pk);
	}

	public int getButy_ID() {
		return _Buty_ID;
	}

	public void setButy_ID(int Buty_ID) {
		_Buty_ID = Buty_ID;
	}

	public String getButy_Description() {
		return _Buty_Description;
	}

	public void setButy_Description(String Buty_Description) {
		_Buty_Description = Buty_Description;
	}

	public String getButy_Status() {
		return _Buty_Status;
	}

	public void setButy_Status(String Buty_Status) {
		_Buty_Status = Buty_Status;
	}

	private int _Buty_ID;
	private String _Buty_Description;
	private String _Buty_Status;
}