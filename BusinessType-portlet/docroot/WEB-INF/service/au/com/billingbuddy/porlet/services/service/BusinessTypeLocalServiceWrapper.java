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

package au.com.billingbuddy.porlet.services.service;

import com.liferay.portal.service.ServiceWrapper;

/**
 * Provides a wrapper for {@link BusinessTypeLocalService}.
 *
 * @author Edicson Morales
 * @see BusinessTypeLocalService
 * @generated
 */
public class BusinessTypeLocalServiceWrapper implements BusinessTypeLocalService,
	ServiceWrapper<BusinessTypeLocalService> {
	public BusinessTypeLocalServiceWrapper(
		BusinessTypeLocalService businessTypeLocalService) {
		_businessTypeLocalService = businessTypeLocalService;
	}

	/**
	* Adds the business type to the database. Also notifies the appropriate model listeners.
	*
	* @param businessType the business type
	* @return the business type that was added
	* @throws SystemException if a system exception occurred
	*/
	@Override
	public au.com.billingbuddy.porlet.services.model.BusinessType addBusinessType(
		au.com.billingbuddy.porlet.services.model.BusinessType businessType)
		throws com.liferay.portal.kernel.exception.SystemException {
		return _businessTypeLocalService.addBusinessType(businessType);
	}

	/**
	* Creates a new business type with the primary key. Does not add the business type to the database.
	*
	* @param Buty_ID the primary key for the new business type
	* @return the new business type
	*/
	@Override
	public au.com.billingbuddy.porlet.services.model.BusinessType createBusinessType(
		int Buty_ID) {
		return _businessTypeLocalService.createBusinessType(Buty_ID);
	}

	/**
	* Deletes the business type with the primary key from the database. Also notifies the appropriate model listeners.
	*
	* @param Buty_ID the primary key of the business type
	* @return the business type that was removed
	* @throws PortalException if a business type with the primary key could not be found
	* @throws SystemException if a system exception occurred
	*/
	@Override
	public au.com.billingbuddy.porlet.services.model.BusinessType deleteBusinessType(
		int Buty_ID)
		throws com.liferay.portal.kernel.exception.PortalException,
			com.liferay.portal.kernel.exception.SystemException {
		return _businessTypeLocalService.deleteBusinessType(Buty_ID);
	}

	/**
	* Deletes the business type from the database. Also notifies the appropriate model listeners.
	*
	* @param businessType the business type
	* @return the business type that was removed
	* @throws SystemException if a system exception occurred
	*/
	@Override
	public au.com.billingbuddy.porlet.services.model.BusinessType deleteBusinessType(
		au.com.billingbuddy.porlet.services.model.BusinessType businessType)
		throws com.liferay.portal.kernel.exception.SystemException {
		return _businessTypeLocalService.deleteBusinessType(businessType);
	}

	@Override
	public com.liferay.portal.kernel.dao.orm.DynamicQuery dynamicQuery() {
		return _businessTypeLocalService.dynamicQuery();
	}

	/**
	* Performs a dynamic query on the database and returns the matching rows.
	*
	* @param dynamicQuery the dynamic query
	* @return the matching rows
	* @throws SystemException if a system exception occurred
	*/
	@Override
	@SuppressWarnings("rawtypes")
	public java.util.List dynamicQuery(
		com.liferay.portal.kernel.dao.orm.DynamicQuery dynamicQuery)
		throws com.liferay.portal.kernel.exception.SystemException {
		return _businessTypeLocalService.dynamicQuery(dynamicQuery);
	}

	/**
	* Performs a dynamic query on the database and returns a range of the matching rows.
	*
	* <p>
	* Useful when paginating results. Returns a maximum of <code>end - start</code> instances. <code>start</code> and <code>end</code> are not primary keys, they are indexes in the result set. Thus, <code>0</code> refers to the first result in the set. Setting both <code>start</code> and <code>end</code> to {@link com.liferay.portal.kernel.dao.orm.QueryUtil#ALL_POS} will return the full result set. If <code>orderByComparator</code> is specified, then the query will include the given ORDER BY logic. If <code>orderByComparator</code> is absent and pagination is required (<code>start</code> and <code>end</code> are not {@link com.liferay.portal.kernel.dao.orm.QueryUtil#ALL_POS}), then the query will include the default ORDER BY logic from {@link au.com.billingbuddy.porlet.services.model.impl.BusinessTypeModelImpl}. If both <code>orderByComparator</code> and pagination are absent, for performance reasons, the query will not have an ORDER BY clause and the returned result set will be sorted on by the primary key in an ascending order.
	* </p>
	*
	* @param dynamicQuery the dynamic query
	* @param start the lower bound of the range of model instances
	* @param end the upper bound of the range of model instances (not inclusive)
	* @return the range of matching rows
	* @throws SystemException if a system exception occurred
	*/
	@Override
	@SuppressWarnings("rawtypes")
	public java.util.List dynamicQuery(
		com.liferay.portal.kernel.dao.orm.DynamicQuery dynamicQuery, int start,
		int end) throws com.liferay.portal.kernel.exception.SystemException {
		return _businessTypeLocalService.dynamicQuery(dynamicQuery, start, end);
	}

	/**
	* Performs a dynamic query on the database and returns an ordered range of the matching rows.
	*
	* <p>
	* Useful when paginating results. Returns a maximum of <code>end - start</code> instances. <code>start</code> and <code>end</code> are not primary keys, they are indexes in the result set. Thus, <code>0</code> refers to the first result in the set. Setting both <code>start</code> and <code>end</code> to {@link com.liferay.portal.kernel.dao.orm.QueryUtil#ALL_POS} will return the full result set. If <code>orderByComparator</code> is specified, then the query will include the given ORDER BY logic. If <code>orderByComparator</code> is absent and pagination is required (<code>start</code> and <code>end</code> are not {@link com.liferay.portal.kernel.dao.orm.QueryUtil#ALL_POS}), then the query will include the default ORDER BY logic from {@link au.com.billingbuddy.porlet.services.model.impl.BusinessTypeModelImpl}. If both <code>orderByComparator</code> and pagination are absent, for performance reasons, the query will not have an ORDER BY clause and the returned result set will be sorted on by the primary key in an ascending order.
	* </p>
	*
	* @param dynamicQuery the dynamic query
	* @param start the lower bound of the range of model instances
	* @param end the upper bound of the range of model instances (not inclusive)
	* @param orderByComparator the comparator to order the results by (optionally <code>null</code>)
	* @return the ordered range of matching rows
	* @throws SystemException if a system exception occurred
	*/
	@Override
	@SuppressWarnings("rawtypes")
	public java.util.List dynamicQuery(
		com.liferay.portal.kernel.dao.orm.DynamicQuery dynamicQuery, int start,
		int end,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws com.liferay.portal.kernel.exception.SystemException {
		return _businessTypeLocalService.dynamicQuery(dynamicQuery, start, end,
			orderByComparator);
	}

	/**
	* Returns the number of rows that match the dynamic query.
	*
	* @param dynamicQuery the dynamic query
	* @return the number of rows that match the dynamic query
	* @throws SystemException if a system exception occurred
	*/
	@Override
	public long dynamicQueryCount(
		com.liferay.portal.kernel.dao.orm.DynamicQuery dynamicQuery)
		throws com.liferay.portal.kernel.exception.SystemException {
		return _businessTypeLocalService.dynamicQueryCount(dynamicQuery);
	}

	/**
	* Returns the number of rows that match the dynamic query.
	*
	* @param dynamicQuery the dynamic query
	* @param projection the projection to apply to the query
	* @return the number of rows that match the dynamic query
	* @throws SystemException if a system exception occurred
	*/
	@Override
	public long dynamicQueryCount(
		com.liferay.portal.kernel.dao.orm.DynamicQuery dynamicQuery,
		com.liferay.portal.kernel.dao.orm.Projection projection)
		throws com.liferay.portal.kernel.exception.SystemException {
		return _businessTypeLocalService.dynamicQueryCount(dynamicQuery,
			projection);
	}

	@Override
	public au.com.billingbuddy.porlet.services.model.BusinessType fetchBusinessType(
		int Buty_ID) throws com.liferay.portal.kernel.exception.SystemException {
		return _businessTypeLocalService.fetchBusinessType(Buty_ID);
	}

	/**
	* Returns the business type with the primary key.
	*
	* @param Buty_ID the primary key of the business type
	* @return the business type
	* @throws PortalException if a business type with the primary key could not be found
	* @throws SystemException if a system exception occurred
	*/
	@Override
	public au.com.billingbuddy.porlet.services.model.BusinessType getBusinessType(
		int Buty_ID)
		throws com.liferay.portal.kernel.exception.PortalException,
			com.liferay.portal.kernel.exception.SystemException {
		return _businessTypeLocalService.getBusinessType(Buty_ID);
	}

	@Override
	public com.liferay.portal.model.PersistedModel getPersistedModel(
		java.io.Serializable primaryKeyObj)
		throws com.liferay.portal.kernel.exception.PortalException,
			com.liferay.portal.kernel.exception.SystemException {
		return _businessTypeLocalService.getPersistedModel(primaryKeyObj);
	}

	/**
	* Returns a range of all the business types.
	*
	* <p>
	* Useful when paginating results. Returns a maximum of <code>end - start</code> instances. <code>start</code> and <code>end</code> are not primary keys, they are indexes in the result set. Thus, <code>0</code> refers to the first result in the set. Setting both <code>start</code> and <code>end</code> to {@link com.liferay.portal.kernel.dao.orm.QueryUtil#ALL_POS} will return the full result set. If <code>orderByComparator</code> is specified, then the query will include the given ORDER BY logic. If <code>orderByComparator</code> is absent and pagination is required (<code>start</code> and <code>end</code> are not {@link com.liferay.portal.kernel.dao.orm.QueryUtil#ALL_POS}), then the query will include the default ORDER BY logic from {@link au.com.billingbuddy.porlet.services.model.impl.BusinessTypeModelImpl}. If both <code>orderByComparator</code> and pagination are absent, for performance reasons, the query will not have an ORDER BY clause and the returned result set will be sorted on by the primary key in an ascending order.
	* </p>
	*
	* @param start the lower bound of the range of business types
	* @param end the upper bound of the range of business types (not inclusive)
	* @return the range of business types
	* @throws SystemException if a system exception occurred
	*/
	@Override
	public java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> getBusinessTypes(
		int start, int end)
		throws com.liferay.portal.kernel.exception.SystemException {
		return _businessTypeLocalService.getBusinessTypes(start, end);
	}

	/**
	* Returns the number of business types.
	*
	* @return the number of business types
	* @throws SystemException if a system exception occurred
	*/
	@Override
	public int getBusinessTypesCount()
		throws com.liferay.portal.kernel.exception.SystemException {
		return _businessTypeLocalService.getBusinessTypesCount();
	}

	/**
	* Updates the business type in the database or adds it if it does not yet exist. Also notifies the appropriate model listeners.
	*
	* @param businessType the business type
	* @return the business type that was updated
	* @throws SystemException if a system exception occurred
	*/
	@Override
	public au.com.billingbuddy.porlet.services.model.BusinessType updateBusinessType(
		au.com.billingbuddy.porlet.services.model.BusinessType businessType)
		throws com.liferay.portal.kernel.exception.SystemException {
		return _businessTypeLocalService.updateBusinessType(businessType);
	}

	/**
	* Returns the Spring bean ID for this bean.
	*
	* @return the Spring bean ID for this bean
	*/
	@Override
	public java.lang.String getBeanIdentifier() {
		return _businessTypeLocalService.getBeanIdentifier();
	}

	/**
	* Sets the Spring bean ID for this bean.
	*
	* @param beanIdentifier the Spring bean ID for this bean
	*/
	@Override
	public void setBeanIdentifier(java.lang.String beanIdentifier) {
		_businessTypeLocalService.setBeanIdentifier(beanIdentifier);
	}

	@Override
	public java.lang.Object invokeMethod(java.lang.String name,
		java.lang.String[] parameterTypes, java.lang.Object[] arguments)
		throws java.lang.Throwable {
		return _businessTypeLocalService.invokeMethod(name, parameterTypes,
			arguments);
	}

	/**
	 * @deprecated As of 6.1.0, replaced by {@link #getWrappedService}
	 */
	public BusinessTypeLocalService getWrappedBusinessTypeLocalService() {
		return _businessTypeLocalService;
	}

	/**
	 * @deprecated As of 6.1.0, replaced by {@link #setWrappedService}
	 */
	public void setWrappedBusinessTypeLocalService(
		BusinessTypeLocalService businessTypeLocalService) {
		_businessTypeLocalService = businessTypeLocalService;
	}

	@Override
	public BusinessTypeLocalService getWrappedService() {
		return _businessTypeLocalService;
	}

	@Override
	public void setWrappedService(
		BusinessTypeLocalService businessTypeLocalService) {
		_businessTypeLocalService = businessTypeLocalService;
	}

	private BusinessTypeLocalService _businessTypeLocalService;
}