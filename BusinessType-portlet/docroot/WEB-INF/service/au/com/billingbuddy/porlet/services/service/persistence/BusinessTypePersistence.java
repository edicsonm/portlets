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

import com.liferay.portal.service.persistence.BasePersistence;

/**
 * The persistence interface for the business type service.
 *
 * <p>
 * Caching information and settings can be found in <code>portal.properties</code>
 * </p>
 *
 * @author Edicson Morales
 * @see BusinessTypePersistenceImpl
 * @see BusinessTypeUtil
 * @generated
 */
public interface BusinessTypePersistence extends BasePersistence<BusinessType> {
	/*
	 * NOTE FOR DEVELOPERS:
	 *
	 * Never modify or reference this interface directly. Always use {@link BusinessTypeUtil} to access the business type persistence. Modify <code>service.xml</code> and rerun ServiceBuilder to regenerate this interface.
	 */

	/**
	* Returns all the business types where Buty_Description = &#63;.
	*
	* @param Buty_Description the buty_ description
	* @return the matching business types
	* @throws SystemException if a system exception occurred
	*/
	public java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> findByFinder_Buty_Description(
		java.lang.String Buty_Description)
		throws com.liferay.portal.kernel.exception.SystemException;

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
	public java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> findByFinder_Buty_Description(
		java.lang.String Buty_Description, int start, int end)
		throws com.liferay.portal.kernel.exception.SystemException;

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
	public java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> findByFinder_Buty_Description(
		java.lang.String Buty_Description, int start, int end,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws com.liferay.portal.kernel.exception.SystemException;

	/**
	* Returns the first business type in the ordered set where Buty_Description = &#63;.
	*
	* @param Buty_Description the buty_ description
	* @param orderByComparator the comparator to order the set by (optionally <code>null</code>)
	* @return the first matching business type
	* @throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException if a matching business type could not be found
	* @throws SystemException if a system exception occurred
	*/
	public au.com.billingbuddy.porlet.services.model.BusinessType findByFinder_Buty_Description_First(
		java.lang.String Buty_Description,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException,
			com.liferay.portal.kernel.exception.SystemException;

	/**
	* Returns the first business type in the ordered set where Buty_Description = &#63;.
	*
	* @param Buty_Description the buty_ description
	* @param orderByComparator the comparator to order the set by (optionally <code>null</code>)
	* @return the first matching business type, or <code>null</code> if a matching business type could not be found
	* @throws SystemException if a system exception occurred
	*/
	public au.com.billingbuddy.porlet.services.model.BusinessType fetchByFinder_Buty_Description_First(
		java.lang.String Buty_Description,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws com.liferay.portal.kernel.exception.SystemException;

	/**
	* Returns the last business type in the ordered set where Buty_Description = &#63;.
	*
	* @param Buty_Description the buty_ description
	* @param orderByComparator the comparator to order the set by (optionally <code>null</code>)
	* @return the last matching business type
	* @throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException if a matching business type could not be found
	* @throws SystemException if a system exception occurred
	*/
	public au.com.billingbuddy.porlet.services.model.BusinessType findByFinder_Buty_Description_Last(
		java.lang.String Buty_Description,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException,
			com.liferay.portal.kernel.exception.SystemException;

	/**
	* Returns the last business type in the ordered set where Buty_Description = &#63;.
	*
	* @param Buty_Description the buty_ description
	* @param orderByComparator the comparator to order the set by (optionally <code>null</code>)
	* @return the last matching business type, or <code>null</code> if a matching business type could not be found
	* @throws SystemException if a system exception occurred
	*/
	public au.com.billingbuddy.porlet.services.model.BusinessType fetchByFinder_Buty_Description_Last(
		java.lang.String Buty_Description,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws com.liferay.portal.kernel.exception.SystemException;

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
	public au.com.billingbuddy.porlet.services.model.BusinessType[] findByFinder_Buty_Description_PrevAndNext(
		int Buty_ID, java.lang.String Buty_Description,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException,
			com.liferay.portal.kernel.exception.SystemException;

	/**
	* Removes all the business types where Buty_Description = &#63; from the database.
	*
	* @param Buty_Description the buty_ description
	* @throws SystemException if a system exception occurred
	*/
	public void removeByFinder_Buty_Description(
		java.lang.String Buty_Description)
		throws com.liferay.portal.kernel.exception.SystemException;

	/**
	* Returns the number of business types where Buty_Description = &#63;.
	*
	* @param Buty_Description the buty_ description
	* @return the number of matching business types
	* @throws SystemException if a system exception occurred
	*/
	public int countByFinder_Buty_Description(java.lang.String Buty_Description)
		throws com.liferay.portal.kernel.exception.SystemException;

	/**
	* Caches the business type in the entity cache if it is enabled.
	*
	* @param businessType the business type
	*/
	public void cacheResult(
		au.com.billingbuddy.porlet.services.model.BusinessType businessType);

	/**
	* Caches the business types in the entity cache if it is enabled.
	*
	* @param businessTypes the business types
	*/
	public void cacheResult(
		java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> businessTypes);

	/**
	* Creates a new business type with the primary key. Does not add the business type to the database.
	*
	* @param Buty_ID the primary key for the new business type
	* @return the new business type
	*/
	public au.com.billingbuddy.porlet.services.model.BusinessType create(
		int Buty_ID);

	/**
	* Removes the business type with the primary key from the database. Also notifies the appropriate model listeners.
	*
	* @param Buty_ID the primary key of the business type
	* @return the business type that was removed
	* @throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException if a business type with the primary key could not be found
	* @throws SystemException if a system exception occurred
	*/
	public au.com.billingbuddy.porlet.services.model.BusinessType remove(
		int Buty_ID)
		throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException,
			com.liferay.portal.kernel.exception.SystemException;

	public au.com.billingbuddy.porlet.services.model.BusinessType updateImpl(
		au.com.billingbuddy.porlet.services.model.BusinessType businessType)
		throws com.liferay.portal.kernel.exception.SystemException;

	/**
	* Returns the business type with the primary key or throws a {@link au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException} if it could not be found.
	*
	* @param Buty_ID the primary key of the business type
	* @return the business type
	* @throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException if a business type with the primary key could not be found
	* @throws SystemException if a system exception occurred
	*/
	public au.com.billingbuddy.porlet.services.model.BusinessType findByPrimaryKey(
		int Buty_ID)
		throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException,
			com.liferay.portal.kernel.exception.SystemException;

	/**
	* Returns the business type with the primary key or returns <code>null</code> if it could not be found.
	*
	* @param Buty_ID the primary key of the business type
	* @return the business type, or <code>null</code> if a business type with the primary key could not be found
	* @throws SystemException if a system exception occurred
	*/
	public au.com.billingbuddy.porlet.services.model.BusinessType fetchByPrimaryKey(
		int Buty_ID) throws com.liferay.portal.kernel.exception.SystemException;

	/**
	* Returns all the business types.
	*
	* @return the business types
	* @throws SystemException if a system exception occurred
	*/
	public java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> findAll()
		throws com.liferay.portal.kernel.exception.SystemException;

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
	public java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> findAll(
		int start, int end)
		throws com.liferay.portal.kernel.exception.SystemException;

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
	public java.util.List<au.com.billingbuddy.porlet.services.model.BusinessType> findAll(
		int start, int end,
		com.liferay.portal.kernel.util.OrderByComparator orderByComparator)
		throws com.liferay.portal.kernel.exception.SystemException;

	/**
	* Removes all the business types from the database.
	*
	* @throws SystemException if a system exception occurred
	*/
	public void removeAll()
		throws com.liferay.portal.kernel.exception.SystemException;

	/**
	* Returns the number of business types.
	*
	* @return the number of business types
	* @throws SystemException if a system exception occurred
	*/
	public int countAll()
		throws com.liferay.portal.kernel.exception.SystemException;
}