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

import com.liferay.portal.kernel.bean.PortletBeanLocatorUtil;
import com.liferay.portal.kernel.dao.orm.DynamicQuery;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.util.OrderByComparator;
import com.liferay.portal.kernel.util.ReferenceRegistry;
import com.liferay.portal.service.ServiceContext;

import java.util.List;

/**
 * The persistence utility for the business type service. This utility wraps {@link BusinessTypePersistenceImpl} and provides direct access to the database for CRUD operations. This utility should only be used by the service layer, as it must operate within a transaction. Never access this utility in a JSP, controller, model, or other front-end class.
 *
 * <p>
 * Caching information and settings can be found in <code>portal.properties</code>
 * </p>
 *
 * @author Edicson Morales
 * @see BusinessTypePersistence
 * @see BusinessTypePersistenceImpl
 * @generated
 */
public class BusinessTypeUtil {
	/*
	 * NOTE FOR DEVELOPERS:
	 *
	 * Never modify this class directly. Modify <code>service.xml</code> and rerun ServiceBuilder to regenerate this class.
	 */

	/**
	 * @see com.liferay.portal.service.persistence.BasePersistence#clearCache()
	 */
	public static void clearCache() {
		getPersistence().clearCache();
	}

	/**
	 * @see com.liferay.portal.service.persistence.BasePersistence#clearCache(com.liferay.portal.model.BaseModel)
	 */
	public static void clearCache(BusinessType businessType) {
		getPersistence().clearCache(businessType);
	}

	/**
	 * @see com.liferay.portal.service.persistence.BasePersistence#countWithDynamicQuery(DynamicQuery)
	 */
	public static long countWithDynamicQuery(DynamicQuery dynamicQuery)
		throws SystemException {
		return getPersistence().countWithDynamicQuery(dynamicQuery);
	}

	/**
	 * @see com.liferay.portal.service.persistence.BasePersistence#findWithDynamicQuery(DynamicQuery)
	 */
	public static List<BusinessType> findWithDynamicQuery(
		DynamicQuery dynamicQuery) throws SystemException {
		return getPersistence().findWithDynamicQuery(dynamicQuery);
	}

	/**
	 * @see com.liferay.portal.service.persistence.BasePersistence#findWithDynamicQuery(DynamicQuery, int, int)
	 */
	public static List<BusinessType> findWithDynamicQuery(
		DynamicQuery dynamicQuery, int start, int end)
		throws SystemException {
		return getPersistence().findWithDynamicQuery(dynamicQuery, start, end);
	}

	/**
	 * @see com.liferay.portal.service.persistence.BasePersistence#findWithDynamicQuery(DynamicQuery, int, int, OrderByComparator)
	 */
	public static List<BusinessType> findWithDynamicQuery(
		DynamicQuery dynamicQuery, int start, int end,
		OrderByComparator orderByComparator) throws SystemException {
		return getPersistence()
				   .findWithDynamicQuery(dynamicQuery, start, end,
			orderByComparator);
	}

	/**
	 * @see com.liferay.portal.service.persistence.BasePersistence#update(com.liferay.portal.model.BaseModel)
	 */
	public static BusinessType update(BusinessType businessType)
		throws SystemException {
		return getPersistence().update(businessType);
	}

	/**
	 * @see com.liferay.portal.service.persistence.BasePersistence#update(com.liferay.portal.model.BaseModel, ServiceContext)
	 */
	public static BusinessType update(BusinessType businessType,
		ServiceContext serviceContext) throws SystemException {
		return getPersistence().update(businessType, serviceContext);
	}

	/**
	* Returns all the business types where Buty_Description = &#63;.
	*
	* @param Buty_Description the buty_ description
	* @return the matching business types
	* @throws SystemException if a system exception occurred
	*/
	public static java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> findByFinder_Buty_Description(
		java.lang.String Buty_Description)
		throws com.liferay.portal.kernel.exception.SystemException {
		return getPersistence().findByFinder_Buty_Description(Buty_Description);
	}

	/**
	* Returns a range of all the business types where Buty_Description = &#63;.
	*
	* <p>
	* Useful when paginating results. Returns a maximum of <code>end - start</code> instances. <code>start</code> and <code>end</code> are not primary keys, they are indexes in the result set. Thus, <code>0</code> refers to the first result in the set. Setting both <code>start</code> and <code>end</code> to {@link com.liferay.portal.kernel.dao.orm.QueryUtil#ALL_POS} will return the full result set. If <code>orderByComparator</code> is specified, then the query will include the given ORDER BY logic. If <code>orderByComparator</code> is absent and pagination is required (<code>start</code> and <code>end</code> are not {@link com.liferay.portal.kernel.dao.orm.QueryUtil#ALL_POS}), then the query will include the default ORDER BY logic from {@link au.com.billingbuddy.porlet.services.model.impl.BusinessTypeModelImpl}. If both <code>orderByComparator</code> and pagination are absent, for performance reasons, the query will not have an ORDER BY clause and the returned result set will be sorted on by the primary key in an ascending order.
	* </p>
	*
	* @param Buty_Description the buty_ description
	* @param start the lower bound of the range of business types
	* @param end the upper bound of the range of business types (not inclusive)
	* @return the range of matching business types
	* @throws SystemException if a system exception occurred
	*/
	public static java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> findByFinder_Buty_Description(
		java.lang.String Buty_Description, int start, int end)
		throws com.liferay.portal.kernel.exception.SystemException {
		return getPersistence()
				   .findByFinder_Buty_Description(Buty_Description, start, end);
	}

	/**
	* Returns an ordered range of all the business types where Buty_Description = &#63;.
	*
	* <p>
	* Useful when paginating results. Returns a maximum of <code>end - start</code> instances. <code>start</code> and <code>end</code> are not primary keys, they are indexes in the result set. Thus, <code>0</code> refers to the first result in the set. Setting both <code>start</code> and <code>end</code> to {@link com.liferay.portal.kernel.dao.orm.QueryUtil#ALL_POS} will return the full result set. If <code>orderByComparator</code> is specified, then the query will include the given ORDER BY logic. If <code>orderByComparator</code> is absent and pagination is required (<code>start</code> and <code>end</code> are not {@link com.liferay.portal.kernel.dao.orm.QueryUtil#ALL_POS}), then the query will include the default ORDER BY logic from {@link au.com.billingbuddy.porlet.services.model.impl.BusinessTypeModelImpl}. If both <code>orderByComparator</code> and pagination are absent, for performance reasons, the query will not have an ORDER BY clause and the returned result set will be sorted on by the primary key in an ascending order.
	* </p>
	*
	* @param Buty_Description the buty_ description
	* @param start the lower bound of the range of business types
	* @param end the upper bound of the range of business types (not inclusive)
	* @param orderByComparator the comparator to order the results by (optionally <code>null</code>)
	* @return the ordered range of matching business types
	* @throws SystemException if a system exception occurred
	*/
	public static java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> findByFinder_Buty_Description(
		java.lang.String Buty_Description, int start, int end,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws com.liferay.portal.kernel.exception.SystemException {
		return getPersistence()
				   .findByFinder_Buty_Description(Buty_Description, start, end,
			orderByComparator);
	}

	/**
	* Returns the first business type in the ordered set where Buty_Description = &#63;.
	*
	* @param Buty_Description the buty_ description
	* @param orderByComparator the comparator to order the set by (optionally <code>null</code>)
	* @return the first matching business type
	* @throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException if a matching business type could not be found
	* @throws SystemException if a system exception occurred
	*/
	public static au.com.billingbuddy.porlet.services.model.BusinessType findByFinder_Buty_Description_First(
		java.lang.String Buty_Description,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException,
			com.liferay.portal.kernel.exception.SystemException {
		return getPersistence()
				   .findByFinder_Buty_Description_First(Buty_Description,
			orderByComparator);
	}

	/**
	* Returns the first business type in the ordered set where Buty_Description = &#63;.
	*
	* @param Buty_Description the buty_ description
	* @param orderByComparator the comparator to order the set by (optionally <code>null</code>)
	* @return the first matching business type, or <code>null</code> if a matching business type could not be found
	* @throws SystemException if a system exception occurred
	*/
	public static au.com.billingbuddy.porlet.services.model.BusinessType fetchByFinder_Buty_Description_First(
		java.lang.String Buty_Description,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws com.liferay.portal.kernel.exception.SystemException {
		return getPersistence()
				   .fetchByFinder_Buty_Description_First(Buty_Description,
			orderByComparator);
	}

	/**
	* Returns the last business type in the ordered set where Buty_Description = &#63;.
	*
	* @param Buty_Description the buty_ description
	* @param orderByComparator the comparator to order the set by (optionally <code>null</code>)
	* @return the last matching business type
	* @throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException if a matching business type could not be found
	* @throws SystemException if a system exception occurred
	*/
	public static au.com.billingbuddy.porlet.services.model.BusinessType findByFinder_Buty_Description_Last(
		java.lang.String Buty_Description,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException,
			com.liferay.portal.kernel.exception.SystemException {
		return getPersistence()
				   .findByFinder_Buty_Description_Last(Buty_Description,
			orderByComparator);
	}

	/**
	* Returns the last business type in the ordered set where Buty_Description = &#63;.
	*
	* @param Buty_Description the buty_ description
	* @param orderByComparator the comparator to order the set by (optionally <code>null</code>)
	* @return the last matching business type, or <code>null</code> if a matching business type could not be found
	* @throws SystemException if a system exception occurred
	*/
	public static au.com.billingbuddy.porlet.services.model.BusinessType fetchByFinder_Buty_Description_Last(
		java.lang.String Buty_Description,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws com.liferay.portal.kernel.exception.SystemException {
		return getPersistence()
				   .fetchByFinder_Buty_Description_Last(Buty_Description,
			orderByComparator);
	}

	/**
	* Returns the business types before and after the current business type in the ordered set where Buty_Description = &#63;.
	*
	* @param Buty_ID the primary key of the current business type
	* @param Buty_Description the buty_ description
	* @param orderByComparator the comparator to order the set by (optionally <code>null</code>)
	* @return the previous, current, and next business type
	* @throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException if a business type with the primary key could not be found
	* @throws SystemException if a system exception occurred
	*/
	public static au.com.billingbuddy.porlet.services.model.BusinessType[] findByFinder_Buty_Description_PrevAndNext(
		int Buty_ID, java.lang.String Buty_Description,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException,
			com.liferay.portal.kernel.exception.SystemException {
		return getPersistence()
				   .findByFinder_Buty_Description_PrevAndNext(Buty_ID,
			Buty_Description, orderByComparator);
	}

	/**
	* Removes all the business types where Buty_Description = &#63; from the database.
	*
	* @param Buty_Description the buty_ description
	* @throws SystemException if a system exception occurred
	*/
	public static void removeByFinder_Buty_Description(
		java.lang.String Buty_Description)
		throws com.liferay.portal.kernel.exception.SystemException {
		getPersistence().removeByFinder_Buty_Description(Buty_Description);
	}

	/**
	* Returns the number of business types where Buty_Description = &#63;.
	*
	* @param Buty_Description the buty_ description
	* @return the number of matching business types
	* @throws SystemException if a system exception occurred
	*/
	public static int countByFinder_Buty_Description(
		java.lang.String Buty_Description)
		throws com.liferay.portal.kernel.exception.SystemException {
		return getPersistence().countByFinder_Buty_Description(Buty_Description);
	}

	/**
	* Caches the business type in the entity cache if it is enabled.
	*
	* @param businessType the business type
	*/
	public static void cacheResult(
		au.com.billingbuddy.porlet.services.model.BusinessType businessType) {
		getPersistence().cacheResult(businessType);
	}

	/**
	* Caches the business types in the entity cache if it is enabled.
	*
	* @param businessTypes the business types
	*/
	public static void cacheResult(
		java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> businessTypes) {
		getPersistence().cacheResult(businessTypes);
	}

	/**
	* Creates a new business type with the primary key. Does not add the business type to the database.
	*
	* @param Buty_ID the primary key for the new business type
	* @return the new business type
	*/
	public static au.com.billingbuddy.porlet.services.model.BusinessType create(
		int Buty_ID) {
		return getPersistence().create(Buty_ID);
	}

	/**
	* Removes the business type with the primary key from the database. Also notifies the appropriate model listeners.
	*
	* @param Buty_ID the primary key of the business type
	* @return the business type that was removed
	* @throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException if a business type with the primary key could not be found
	* @throws SystemException if a system exception occurred
	*/
	public static au.com.billingbuddy.porlet.services.model.BusinessType remove(
		int Buty_ID)
		throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException,
			com.liferay.portal.kernel.exception.SystemException {
		return getPersistence().remove(Buty_ID);
	}

	public static au.com.billingbuddy.porlet.services.model.BusinessType updateImpl(
		au.com.billingbuddy.porlet.services.model.BusinessType businessType)
		throws com.liferay.portal.kernel.exception.SystemException {
		return getPersistence().updateImpl(businessType);
	}

	/**
	* Returns the business type with the primary key or throws a {@link au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException} if it could not be found.
	*
	* @param Buty_ID the primary key of the business type
	* @return the business type
	* @throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException if a business type with the primary key could not be found
	* @throws SystemException if a system exception occurred
	*/
	public static au.com.billingbuddy.porlet.services.model.BusinessType findByPrimaryKey(
		int Buty_ID)
		throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException,
			com.liferay.portal.kernel.exception.SystemException {
		return getPersistence().findByPrimaryKey(Buty_ID);
	}

	/**
	* Returns the business type with the primary key or returns <code>null</code> if it could not be found.
	*
	* @param Buty_ID the primary key of the business type
	* @return the business type, or <code>null</code> if a business type with the primary key could not be found
	* @throws SystemException if a system exception occurred
	*/
	public static au.com.billingbuddy.porlet.services.model.BusinessType fetchByPrimaryKey(
		int Buty_ID) throws com.liferay.portal.kernel.exception.SystemException {
		return getPersistence().fetchByPrimaryKey(Buty_ID);
	}

	/**
	* Returns all the business types.
	*
	* @return the business types
	* @throws SystemException if a system exception occurred
	*/
	public static java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> findAll()
		throws com.liferay.portal.kernel.exception.SystemException {
		return getPersistence().findAll();
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
	public static java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> findAll(
		int start, int end)
		throws com.liferay.portal.kernel.exception.SystemException {
		return getPersistence().findAll(start, end);
	}

	/**
	* Returns an ordered range of all the business types.
	*
	* <p>
	* Useful when paginating results. Returns a maximum of <code>end - start</code> instances. <code>start</code> and <code>end</code> are not primary keys, they are indexes in the result set. Thus, <code>0</code> refers to the first result in the set. Setting both <code>start</code> and <code>end</code> to {@link com.liferay.portal.kernel.dao.orm.QueryUtil#ALL_POS} will return the full result set. If <code>orderByComparator</code> is specified, then the query will include the given ORDER BY logic. If <code>orderByComparator</code> is absent and pagination is required (<code>start</code> and <code>end</code> are not {@link com.liferay.portal.kernel.dao.orm.QueryUtil#ALL_POS}), then the query will include the default ORDER BY logic from {@link au.com.billingbuddy.porlet.services.model.impl.BusinessTypeModelImpl}. If both <code>orderByComparator</code> and pagination are absent, for performance reasons, the query will not have an ORDER BY clause and the returned result set will be sorted on by the primary key in an ascending order.
	* </p>
	*
	* @param start the lower bound of the range of business types
	* @param end the upper bound of the range of business types (not inclusive)
	* @param orderByComparator the comparator to order the results by (optionally <code>null</code>)
	* @return the ordered range of business types
	* @throws SystemException if a system exception occurred
	*/
	public static java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> findAll(
		int start, int end,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws com.liferay.portal.kernel.exception.SystemException {
		return getPersistence().findAll(start, end, orderByComparator);
	}

	/**
	* Removes all the business types from the database.
	*
	* @throws SystemException if a system exception occurred
	*/
	public static void removeAll()
		throws com.liferay.portal.kernel.exception.SystemException {
		getPersistence().removeAll();
	}

	/**
	* Returns the number of business types.
	*
	* @return the number of business types
	* @throws SystemException if a system exception occurred
	*/
	public static int countAll()
		throws com.liferay.portal.kernel.exception.SystemException {
		return getPersistence().countAll();
	}

	public static BusinessTypePersistence getPersistence() {
		if (_persistence == null) {
			_persistence = (BusinessTypePersistence)PortletBeanLocatorUtil.locate(au.com.billingbuddy.porlet.services.service.ClpSerializer.getServletContextName(),
					BusinessTypePersistence.class.getName());

			ReferenceRegistry.registerReference(BusinessTypeUtil.class,
				"_persistence");
		}

		return _persistence;
	}

	/**
	 * @deprecated As of 6.2.0
	 */
	public void setPersistence(BusinessTypePersistence persistence) {
	}

	private static BusinessTypePersistence _persistence;
}