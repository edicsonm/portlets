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

package au.com.billingbuddy.porlet.services.service.persistence;

import au.com.billingbuddy.porlet.services.model.BusinessType;
import au.com.billingbuddy.porlet.services.service.BusinessTypeLocalServiceUtil;

import com.liferay.portal.kernel.dao.orm.BaseActionableDynamicQuery;
import com.liferay.portal.kernel.exception.SystemException;

/**
 * @author Edicson Morales
 * @generated
 */
public abstract class BusinessTypeActionableDynamicQuery
	extends BaseActionableDynamicQuery {
	public BusinessTypeActionableDynamicQuery() throws SystemException {
		setBaseLocalService(BusinessTypeLocalServiceUtil.getService());
		setClass(BusinessType.class);

		setClassLoader(au.com.billingbuddy.porlet.services.service.ClpSerializer.class.getClassLoader());

		setPrimaryKeyPropertyName("Buty_ID");
	}
}