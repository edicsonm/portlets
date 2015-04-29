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

import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.ModelWrapper;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * This class is a wrapper for {@link BusinessType}.
 * </p>
 *
 * @author Edicson Morales
 * @see BusinessType
 * @generated
 */
public class BusinessTypeWrapper implements BusinessType,
	ModelWrapper<BusinessType> {
	public BusinessTypeWrapper(BusinessType businessType) {
		_businessType = businessType;
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

	/**
	* Returns the primary key of this business type.
	*
	* @return the primary key of this business type
	*/
	@Override
	public int getPrimaryKey() {
		return _businessType.getPrimaryKey();
	}

	/**
	* Sets the primary key of this business type.
	*
	* @param primaryKey the primary key of this business type
	*/
	@Override
	public void setPrimaryKey(int primaryKey) {
		_businessType.setPrimaryKey(primaryKey);
	}

	/**
	* Returns the buty_ i d of this business type.
	*
	* @return the buty_ i d of this business type
	*/
	@Override
	public int getButy_ID() {
		return _businessType.getButy_ID();
	}

	/**
	* Sets the buty_ i d of this business type.
	*
	* @param Buty_ID the buty_ i d of this business type
	*/
	@Override
	public void setButy_ID(int Buty_ID) {
		_businessType.setButy_ID(Buty_ID);
	}

	/**
	* Returns the buty_ description of this business type.
	*
	* @return the buty_ description of this business type
	*/
	@Override
	public java.lang.String getButy_Description() {
		return _businessType.getButy_Description();
	}

	/**
	* Sets the buty_ description of this business type.
	*
	* @param Buty_Description the buty_ description of this business type
	*/
	@Override
	public void setButy_Description(java.lang.String Buty_Description) {
		_businessType.setButy_Description(Buty_Description);
	}

	/**
	* Returns the buty_ status of this business type.
	*
	* @return the buty_ status of this business type
	*/
	@Override
	public java.lang.String getButy_Status() {
		return _businessType.getButy_Status();
	}

	/**
	* Sets the buty_ status of this business type.
	*
	* @param Buty_Status the buty_ status of this business type
	*/
	@Override
	public void setButy_Status(java.lang.String Buty_Status) {
		_businessType.setButy_Status(Buty_Status);
	}

	@Override
	public boolean isNew() {
		return _businessType.isNew();
	}

	@Override
	public void setNew(boolean n) {
		_businessType.setNew(n);
	}

	@Override
	public boolean isCachedModel() {
		return _businessType.isCachedModel();
	}

	@Override
	public void setCachedModel(boolean cachedModel) {
		_businessType.setCachedModel(cachedModel);
	}

	@Override
	public boolean isEscapedModel() {
		return _businessType.isEscapedModel();
	}

	@Override
	public java.io.Serializable getPrimaryKeyObj() {
		return _businessType.getPrimaryKeyObj();
	}

	@Override
	public void setPrimaryKeyObj(java.io.Serializable primaryKeyObj) {
		_businessType.setPrimaryKeyObj(primaryKeyObj);
	}

	@Override
	public com.liferay.portlet.expando.model.ExpandoBridge getExpandoBridge() {
		return _businessType.getExpandoBridge();
	}

	@Override
	public void setExpandoBridgeAttributes(
		com.liferay.portal.model.BaseModel<?> baseModel) {
		_businessType.setExpandoBridgeAttributes(baseModel);
	}

	@Override
	public void setExpandoBridgeAttributes(
		com.liferay.portlet.expando.model.ExpandoBridge expandoBridge) {
		_businessType.setExpandoBridgeAttributes(expandoBridge);
	}

	@Override
	public void setExpandoBridgeAttributes(
		com.liferay.portal.service.ServiceContext serviceContext) {
		_businessType.setExpandoBridgeAttributes(serviceContext);
	}

	@Override
	public java.lang.Object clone() {
		return new BusinessTypeWrapper((BusinessType)_businessType.clone());
	}

	@Override
	public int compareTo(BusinessType businessType) {
		return _businessType.compareTo(businessType);
	}

	@Override
	public int hashCode() {
		return _businessType.hashCode();
	}

	@Override
	public com.liferay.portal.model.CacheModel<BusinessType> toCacheModel() {
		return _businessType.toCacheModel();
	}

	@Override
	public BusinessType toEscapedModel() {
		return new BusinessTypeWrapper(_businessType.toEscapedModel());
	}

	@Override
	public BusinessType toUnescapedModel() {
		return new BusinessTypeWrapper(_businessType.toUnescapedModel());
	}

	@Override
	public java.lang.String toString() {
		return _businessType.toString();
	}

	@Override
	public java.lang.String toXmlString() {
		return _businessType.toXmlString();
	}

	@Override
	public void persist()
		throws com.liferay.portal.kernel.exception.SystemException {
		_businessType.persist();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}

		if (!(obj instanceof BusinessTypeWrapper)) {
			return false;
		}

		BusinessTypeWrapper businessTypeWrapper = (BusinessTypeWrapper)obj;

		if (Validator.equals(_businessType, businessTypeWrapper._businessType)) {
			return true;
		}

		return false;
	}

	/**
	 * @deprecated As of 6.1.0, replaced by {@link #getWrappedModel}
	 */
	public BusinessType getWrappedBusinessType() {
		return _businessType;
	}

	@Override
	public BusinessType getWrappedModel() {
		return _businessType;
	}

	@Override
	public void resetOriginalValues() {
		_businessType.resetOriginalValues();
	}

	private BusinessType _businessType;
}