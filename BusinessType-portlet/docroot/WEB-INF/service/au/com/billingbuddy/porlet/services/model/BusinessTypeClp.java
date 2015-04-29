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

import au.com.billingbuddy.porlet.services.service.BusinessTypeLocalServiceUtil;
import au.com.billingbuddy.porlet.services.service.ClpSerializer;

import com.liferay.portal.kernel.bean.AutoEscapeBeanHandler;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.util.ProxyUtil;
import com.liferay.portal.kernel.util.StringBundler;
import com.liferay.portal.model.BaseModel;
import com.liferay.portal.model.impl.BaseModelImpl;

import java.io.Serializable;

import java.lang.reflect.Method;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Edicson Morales
 */
public class BusinessTypeClp extends BaseModelImpl<BusinessType>
	implements BusinessType {
	public BusinessTypeClp() {
	}

	@Override
	public Class<?> getModelClass() {
		return BusinessType.class;
	}

	@Override
	public String getModelClassName() {
		return BusinessType.class.getName();
	}

	@Override
	public int getPrimaryKey() {
		return _Buty_ID;
	}

	@Override
	public void setPrimaryKey(int primaryKey) {
		setButy_ID(primaryKey);
	}

	@Override
	public Serializable getPrimaryKeyObj() {
		return _Buty_ID;
	}

	@Override
	public void setPrimaryKeyObj(Serializable primaryKeyObj) {
		setPrimaryKey(((Integer)primaryKeyObj).intValue());
	}

	@Override
	public Map<String, Object> getModelAttributes() {
		Map<String, Object> attributes = new HashMap<String, Object>();

		attributes.put("Buty_ID", getButy_ID());
		attributes.put("Buty_Description", getButy_Description());
		attributes.put("Buty_Status", getButy_Status());

		return attributes;
	}

	@Override
	public void setModelAttributes(Map<String, Object> attributes) {
		Integer Buty_ID = (Integer)attributes.get("Buty_ID");

		if (Buty_ID != null) {
			setButy_ID(Buty_ID);
		}

		String Buty_Description = (String)attributes.get("Buty_Description");

		if (Buty_Description != null) {
			setButy_Description(Buty_Description);
		}

		String Buty_Status = (String)attributes.get("Buty_Status");

		if (Buty_Status != null) {
			setButy_Status(Buty_Status);
		}
	}

	@Override
	public int getButy_ID() {
		return _Buty_ID;
	}

	@Override
	public void setButy_ID(int Buty_ID) {
		_Buty_ID = Buty_ID;

		if (_businessTypeRemoteModel != null) {
			try {
				Class<?> clazz = _businessTypeRemoteModel.getClass();

				Method method = clazz.getMethod("setButy_ID", int.class);

				method.invoke(_businessTypeRemoteModel, Buty_ID);
			}
			catch (Exception e) {
				throw new UnsupportedOperationException(e);
			}
		}
	}

	@Override
	public String getButy_Description() {
		return _Buty_Description;
	}

	@Override
	public void setButy_Description(String Buty_Description) {
		_Buty_Description = Buty_Description;

		if (_businessTypeRemoteModel != null) {
			try {
				Class<?> clazz = _businessTypeRemoteModel.getClass();

				Method method = clazz.getMethod("setButy_Description",
						String.class);

				method.invoke(_businessTypeRemoteModel, Buty_Description);
			}
			catch (Exception e) {
				throw new UnsupportedOperationException(e);
			}
		}
	}

	@Override
	public String getButy_Status() {
		return _Buty_Status;
	}

	@Override
	public void setButy_Status(String Buty_Status) {
		_Buty_Status = Buty_Status;

		if (_businessTypeRemoteModel != null) {
			try {
				Class<?> clazz = _businessTypeRemoteModel.getClass();

				Method method = clazz.getMethod("setButy_Status", String.class);

				method.invoke(_businessTypeRemoteModel, Buty_Status);
			}
			catch (Exception e) {
				throw new UnsupportedOperationException(e);
			}
		}
	}

	public BaseModel<?> getBusinessTypeRemoteModel() {
		return _businessTypeRemoteModel;
	}

	public void setBusinessTypeRemoteModel(BaseModel<?> businessTypeRemoteModel) {
		_businessTypeRemoteModel = businessTypeRemoteModel;
	}

	public Object invokeOnRemoteModel(String methodName,
		Class<?>[] parameterTypes, Object[] parameterValues)
		throws Exception {
		Object[] remoteParameterValues = new Object[parameterValues.length];

		for (int i = 0; i < parameterValues.length; i++) {
			if (parameterValues[i] != null) {
				remoteParameterValues[i] = ClpSerializer.translateInput(parameterValues[i]);
			}
		}

		Class<?> remoteModelClass = _businessTypeRemoteModel.getClass();

		ClassLoader remoteModelClassLoader = remoteModelClass.getClassLoader();

		Class<?>[] remoteParameterTypes = new Class[parameterTypes.length];

		for (int i = 0; i < parameterTypes.length; i++) {
			if (parameterTypes[i].isPrimitive()) {
				remoteParameterTypes[i] = parameterTypes[i];
			}
			else {
				String parameterTypeName = parameterTypes[i].getName();

				remoteParameterTypes[i] = remoteModelClassLoader.loadClass(parameterTypeName);
			}
		}

		Method method = remoteModelClass.getMethod(methodName,
				remoteParameterTypes);

		Object returnValue = method.invoke(_businessTypeRemoteModel,
				remoteParameterValues);

		if (returnValue != null) {
			returnValue = ClpSerializer.translateOutput(returnValue);
		}

		return returnValue;
	}

	@Override
	public void persist() throws SystemException {
		if (this.isNew()) {
			BusinessTypeLocalServiceUtil.addBusinessType(this);
		}
		else {
			BusinessTypeLocalServiceUtil.updateBusinessType(this);
		}
	}

	@Override
	public BusinessType toEscapedModel() {
		return (BusinessType)ProxyUtil.newProxyInstance(BusinessType.class.getClassLoader(),
			new Class[] { BusinessType.class }, new AutoEscapeBeanHandler(this));
	}

	@Override
	public Object clone() {
		BusinessTypeClp clone = new BusinessTypeClp();

		clone.setButy_ID(getButy_ID());
		clone.setButy_Description(getButy_Description());
		clone.setButy_Status(getButy_Status());

		return clone;
	}

	@Override
	public int compareTo(BusinessType businessType) {
		int value = 0;

		value = getButy_Description()
					.compareTo(businessType.getButy_Description());

		if (value != 0) {
			return value;
		}

		return 0;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}

		if (!(obj instanceof BusinessTypeClp)) {
			return false;
		}

		BusinessTypeClp businessType = (BusinessTypeClp)obj;

		int primaryKey = businessType.getPrimaryKey();

		if (getPrimaryKey() == primaryKey) {
			return true;
		}
		else {
			return false;
		}
	}

	public Class<?> getClpSerializerClass() {
		return _clpSerializerClass;
	}

	@Override
	public int hashCode() {
		return getPrimaryKey();
	}

	@Override
	public String toString() {
		StringBundler sb = new StringBundler(7);

		sb.append("{Buty_ID=");
		sb.append(getButy_ID());
		sb.append(", Buty_Description=");
		sb.append(getButy_Description());
		sb.append(", Buty_Status=");
		sb.append(getButy_Status());
		sb.append("}");

		return sb.toString();
	}

	@Override
	public String toXmlString() {
		StringBundler sb = new StringBundler(13);

		sb.append("<model><model-name>");
		sb.append("au.com.billingbuddy.porlet.services.model.BusinessType");
		sb.append("</model-name>");

		sb.append(
			"<column><column-name>Buty_ID</column-name><column-value><![CDATA[");
		sb.append(getButy_ID());
		sb.append("]]></column-value></column>");
		sb.append(
			"<column><column-name>Buty_Description</column-name><column-value><![CDATA[");
		sb.append(getButy_Description());
		sb.append("]]></column-value></column>");
		sb.append(
			"<column><column-name>Buty_Status</column-name><column-value><![CDATA[");
		sb.append(getButy_Status());
		sb.append("]]></column-value></column>");

		sb.append("</model>");

		return sb.toString();
	}

	private int _Buty_ID;
	private String _Buty_Description;
	private String _Buty_Status;
	private BaseModel<?> _businessTypeRemoteModel;
	private Class<?> _clpSerializerClass = au.com.billingbuddy.porlet.services.service.ClpSerializer.class;
}