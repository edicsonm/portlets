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

import au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException;
import au.com.billingbuddy.porlet.services.model.BusinessType;
import au.com.billingbuddy.porlet.services.model.impl.BusinessTypeImpl;
import au.com.billingbuddy.porlet.services.model.impl.BusinessTypeModelImpl;

import com.liferay.portal.kernel.cache.CacheRegistryUtil;
import com.liferay.portal.kernel.dao.orm.EntityCacheUtil;
import com.liferay.portal.kernel.dao.orm.FinderCacheUtil;
import com.liferay.portal.kernel.dao.orm.FinderPath;
import com.liferay.portal.kernel.dao.orm.Query;
import com.liferay.portal.kernel.dao.orm.QueryPos;
import com.liferay.portal.kernel.dao.orm.QueryUtil;
import com.liferay.portal.kernel.dao.orm.Session;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.InstanceFactory;
import com.liferay.portal.kernel.util.OrderByComparator;
import com.liferay.portal.kernel.util.PropsKeys;
import com.liferay.portal.kernel.util.PropsUtil;
import com.liferay.portal.kernel.util.StringBundler;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.kernel.util.UnmodifiableList;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.CacheModel;
import com.liferay.portal.model.ModelListener;
import com.liferay.portal.service.persistence.impl.BasePersistenceImpl;

import java.io.Serializable;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * The persistence implementation for the business type service.
 *
 * <p>
 * Caching information and settings can be found in <code>portal.properties</code>
 * </p>
 *
 * @author Edicson Morales
 * @see BusinessTypePersistence
 * @see BusinessTypeUtil
 * @generated
 */
public class BusinessTypePersistenceImpl extends BasePersistenceImpl<BusinessType>
	implements BusinessTypePersistence {
	/*
	 * NOTE FOR DEVELOPERS:
	 *
	 * Never modify or reference this class directly. Always use {@link BusinessTypeUtil} to access the business type persistence. Modify <code>service.xml</code> and rerun ServiceBuilder to regenerate this class.
	 */
	public static final String FINDER_CLASS_NAME_ENTITY = BusinessTypeImpl.class.getName();
	public static final String FINDER_CLASS_NAME_LIST_WITH_PAGINATION = FINDER_CLASS_NAME_ENTITY +
		".List1";
	public static final String FINDER_CLASS_NAME_LIST_WITHOUT_PAGINATION = FINDER_CLASS_NAME_ENTITY +
		".List2";
	public static final FinderPath FINDER_PATH_WITH_PAGINATION_FIND_ALL = new FinderPath(BusinessTypeModelImpl.ENTITY_CACHE_ENABLED,
			BusinessTypeModelImpl.FINDER_CACHE_ENABLED, BusinessTypeImpl.class,
			FINDER_CLASS_NAME_LIST_WITH_PAGINATION, "findAll", new String[0]);
	public static final FinderPath FINDER_PATH_WITHOUT_PAGINATION_FIND_ALL = new FinderPath(BusinessTypeModelImpl.ENTITY_CACHE_ENABLED,
			BusinessTypeModelImpl.FINDER_CACHE_ENABLED, BusinessTypeImpl.class,
			FINDER_CLASS_NAME_LIST_WITHOUT_PAGINATION, "findAll", new String[0]);
	public static final FinderPath FINDER_PATH_COUNT_ALL = new FinderPath(BusinessTypeModelImpl.ENTITY_CACHE_ENABLED,
			BusinessTypeModelImpl.FINDER_CACHE_ENABLED, Long.class,
			FINDER_CLASS_NAME_LIST_WITHOUT_PAGINATION, "countAll", new String[0]);
	public static final FinderPath FINDER_PATH_WITH_PAGINATION_FIND_BY_FINDER_BUTY_DESCRIPTION =
		new FinderPath(BusinessTypeModelImpl.ENTITY_CACHE_ENABLED,
			BusinessTypeModelImpl.FINDER_CACHE_ENABLED, BusinessTypeImpl.class,
			FINDER_CLASS_NAME_LIST_WITH_PAGINATION,
			"findByFinder_Buty_Description",
			new String[] {
				String.class.getName(),
				
			Integer.class.getName(), Integer.class.getName(),
				OrderByComparator.class.getName()
			});
	public static final FinderPath FINDER_PATH_WITHOUT_PAGINATION_FIND_BY_FINDER_BUTY_DESCRIPTION =
		new FinderPath(BusinessTypeModelImpl.ENTITY_CACHE_ENABLED,
			BusinessTypeModelImpl.FINDER_CACHE_ENABLED, BusinessTypeImpl.class,
			FINDER_CLASS_NAME_LIST_WITHOUT_PAGINATION,
			"findByFinder_Buty_Description",
			new String[] { String.class.getName() },
			BusinessTypeModelImpl.BUTY_DESCRIPTION_COLUMN_BITMASK);
	public static final FinderPath FINDER_PATH_COUNT_BY_FINDER_BUTY_DESCRIPTION = new FinderPath(BusinessTypeModelImpl.ENTITY_CACHE_ENABLED,
			BusinessTypeModelImpl.FINDER_CACHE_ENABLED, Long.class,
			FINDER_CLASS_NAME_LIST_WITHOUT_PAGINATION,
			"countByFinder_Buty_Description",
			new String[] { String.class.getName() });

	/**
	 * Returns all the business types where Buty_Description = &#63;.
	 *
	 * @param Buty_Description the buty_ description
	 * @return the matching business types
	 * @throws SystemException if a system exception occurred
	 */
	@Override
	public List<BusinessType> findByFinder_Buty_Description(
		String Buty_Description) throws SystemException {
		return findByFinder_Buty_Description(Buty_Description,
			QueryUtil.ALL_POS, QueryUtil.ALL_POS, null);
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
	@Override
	public List<BusinessType> findByFinder_Buty_Description(
		String Buty_Description, int start, int end) throws SystemException {
		return findByFinder_Buty_Description(Buty_Description, start, end, null);
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
	@Override
	public List<BusinessType> findByFinder_Buty_Description(
		String Buty_Description, int start, int end,
		OrderByComparator orderByComparator) throws SystemException {
		boolean pagination = true;
		FinderPath finderPath = null;
		Object[] finderArgs = null;

		if ((start == QueryUtil.ALL_POS) && (end == QueryUtil.ALL_POS) &&
				(orderByComparator == null)) {
			pagination = false;
			finderPath = FINDER_PATH_WITHOUT_PAGINATION_FIND_BY_FINDER_BUTY_DESCRIPTION;
			finderArgs = new Object[] { Buty_Description };
		}
		else {
			finderPath = FINDER_PATH_WITH_PAGINATION_FIND_BY_FINDER_BUTY_DESCRIPTION;
			finderArgs = new Object[] {
					Buty_Description,
					
					start, end, orderByComparator
				};
		}

		List<BusinessType> list = (List<BusinessType>)FinderCacheUtil.getResult(finderPath,
				finderArgs, this);

		if ((list != null) && !list.isEmpty()) {
			for (BusinessType businessType : list) {
				if (!Validator.equals(Buty_Description,
							businessType.getButy_Description())) {
					list = null;

					break;
				}
			}
		}

		if (list == null) {
			StringBundler query = null;

			if (orderByComparator != null) {
				query = new StringBundler(3 +
						(orderByComparator.getOrderByFields().length * 3));
			}
			else {
				query = new StringBundler(3);
			}

			query.append(_SQL_SELECT_BUSINESSTYPE_WHERE);

			boolean bindButy_Description = false;

			if (Buty_Description == null) {
				query.append(_FINDER_COLUMN_FINDER_BUTY_DESCRIPTION_BUTY_DESCRIPTION_1);
			}
			else if (Buty_Description.equals(StringPool.BLANK)) {
				query.append(_FINDER_COLUMN_FINDER_BUTY_DESCRIPTION_BUTY_DESCRIPTION_3);
			}
			else {
				bindButy_Description = true;

				query.append(_FINDER_COLUMN_FINDER_BUTY_DESCRIPTION_BUTY_DESCRIPTION_2);
			}

			if (orderByComparator != null) {
				appendOrderByComparator(query, _ORDER_BY_ENTITY_ALIAS,
					orderByComparator);
			}
			else
			 if (pagination) {
				query.append(BusinessTypeModelImpl.ORDER_BY_JPQL);
			}

			String sql = query.toString();

			Session session = null;

			try {
				session = openSession();

				Query q = session.createQuery(sql);

				QueryPos qPos = QueryPos.getInstance(q);

				if (bindButy_Description) {
					qPos.add(Buty_Description);
				}

				if (!pagination) {
					list = (List<BusinessType>)QueryUtil.list(q, getDialect(),
							start, end, false);

					Collections.sort(list);

					list = new UnmodifiableList<BusinessType>(list);
				}
				else {
					list = (List<BusinessType>)QueryUtil.list(q, getDialect(),
							start, end);
				}

				cacheResult(list);

				FinderCacheUtil.putResult(finderPath, finderArgs, list);
			}
			catch (Exception e) {
				FinderCacheUtil.removeResult(finderPath, finderArgs);

				throw processException(e);
			}
			finally {
				closeSession(session);
			}
		}

		return list;
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
	@Override
	public BusinessType findByFinder_Buty_Description_First(
		String Buty_Description, OrderByComparator orderByComparator)
		throws NoSuchBusinessTypeException, SystemException {
		BusinessType businessType = fetchByFinder_Buty_Description_First(Buty_Description,
				orderByComparator);

		if (businessType != null) {
			return businessType;
		}

		StringBundler msg = new StringBundler(4);

		msg.append(_NO_SUCH_ENTITY_WITH_KEY);

		msg.append("Buty_Description=");
		msg.append(Buty_Description);

		msg.append(StringPool.CLOSE_CURLY_BRACE);

		throw new NoSuchBusinessTypeException(msg.toString());
	}

	/**
	 * Returns the first business type in the ordered set where Buty_Description = &#63;.
	 *
	 * @param Buty_Description the buty_ description
	 * @param orderByComparator the comparator to order the set by (optionally <code>null</code>)
	 * @return the first matching business type, or <code>null</code> if a matching business type could not be found
	 * @throws SystemException if a system exception occurred
	 */
	@Override
	public BusinessType fetchByFinder_Buty_Description_First(
		String Buty_Description, OrderByComparator orderByComparator)
		throws SystemException {
		List<BusinessType> list = findByFinder_Buty_Description(Buty_Description,
				0, 1, orderByComparator);

		if (!list.isEmpty()) {
			return list.get(0);
		}

		return null;
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
	@Override
	public BusinessType findByFinder_Buty_Description_Last(
		String Buty_Description, OrderByComparator orderByComparator)
		throws NoSuchBusinessTypeException, SystemException {
		BusinessType businessType = fetchByFinder_Buty_Description_Last(Buty_Description,
				orderByComparator);

		if (businessType != null) {
			return businessType;
		}

		StringBundler msg = new StringBundler(4);

		msg.append(_NO_SUCH_ENTITY_WITH_KEY);

		msg.append("Buty_Description=");
		msg.append(Buty_Description);

		msg.append(StringPool.CLOSE_CURLY_BRACE);

		throw new NoSuchBusinessTypeException(msg.toString());
	}

	/**
	 * Returns the last business type in the ordered set where Buty_Description = &#63;.
	 *
	 * @param Buty_Description the buty_ description
	 * @param orderByComparator the comparator to order the set by (optionally <code>null</code>)
	 * @return the last matching business type, or <code>null</code> if a matching business type could not be found
	 * @throws SystemException if a system exception occurred
	 */
	@Override
	public BusinessType fetchByFinder_Buty_Description_Last(
		String Buty_Description, OrderByComparator orderByComparator)
		throws SystemException {
		int count = countByFinder_Buty_Description(Buty_Description);

		if (count == 0) {
			return null;
		}

		List<BusinessType> list = findByFinder_Buty_Description(Buty_Description,
				count - 1, count, orderByComparator);

		if (!list.isEmpty()) {
			return list.get(0);
		}

		return null;
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
	@Override
	public BusinessType[] findByFinder_Buty_Description_PrevAndNext(
		int Buty_ID, String Buty_Description,
		OrderByComparator orderByComparator)
		throws NoSuchBusinessTypeException, SystemException {
		BusinessType businessType = findByPrimaryKey(Buty_ID);

		Session session = null;

		try {
			session = openSession();

			BusinessType[] array = new BusinessTypeImpl[3];

			array[0] = getByFinder_Buty_Description_PrevAndNext(session,
					businessType, Buty_Description, orderByComparator, true);

			array[1] = businessType;

			array[2] = getByFinder_Buty_Description_PrevAndNext(session,
					businessType, Buty_Description, orderByComparator, false);

			return array;
		}
		catch (Exception e) {
			throw processException(e);
		}
		finally {
			closeSession(session);
		}
	}

	protected BusinessType getByFinder_Buty_Description_PrevAndNext(
		Session session, BusinessType businessType, String Buty_Description,
		OrderByComparator orderByComparator, boolean previous) {
		StringBundler query = null;

		if (orderByComparator != null) {
			query = new StringBundler(6 +
					(orderByComparator.getOrderByFields().length * 6));
		}
		else {
			query = new StringBundler(3);
		}

		query.append(_SQL_SELECT_BUSINESSTYPE_WHERE);

		boolean bindButy_Description = false;

		if (Buty_Description == null) {
			query.append(_FINDER_COLUMN_FINDER_BUTY_DESCRIPTION_BUTY_DESCRIPTION_1);
		}
		else if (Buty_Description.equals(StringPool.BLANK)) {
			query.append(_FINDER_COLUMN_FINDER_BUTY_DESCRIPTION_BUTY_DESCRIPTION_3);
		}
		else {
			bindButy_Description = true;

			query.append(_FINDER_COLUMN_FINDER_BUTY_DESCRIPTION_BUTY_DESCRIPTION_2);
		}

		if (orderByComparator != null) {
			String[] orderByConditionFields = orderByComparator.getOrderByConditionFields();

			if (orderByConditionFields.length > 0) {
				query.append(WHERE_AND);
			}

			for (int i = 0; i < orderByConditionFields.length; i++) {
				query.append(_ORDER_BY_ENTITY_ALIAS);
				query.append(orderByConditionFields[i]);

				if ((i + 1) < orderByConditionFields.length) {
					if (orderByComparator.isAscending() ^ previous) {
						query.append(WHERE_GREATER_THAN_HAS_NEXT);
					}
					else {
						query.append(WHERE_LESSER_THAN_HAS_NEXT);
					}
				}
				else {
					if (orderByComparator.isAscending() ^ previous) {
						query.append(WHERE_GREATER_THAN);
					}
					else {
						query.append(WHERE_LESSER_THAN);
					}
				}
			}

			query.append(ORDER_BY_CLAUSE);

			String[] orderByFields = orderByComparator.getOrderByFields();

			for (int i = 0; i < orderByFields.length; i++) {
				query.append(_ORDER_BY_ENTITY_ALIAS);
				query.append(orderByFields[i]);

				if ((i + 1) < orderByFields.length) {
					if (orderByComparator.isAscending() ^ previous) {
						query.append(ORDER_BY_ASC_HAS_NEXT);
					}
					else {
						query.append(ORDER_BY_DESC_HAS_NEXT);
					}
				}
				else {
					if (orderByComparator.isAscending() ^ previous) {
						query.append(ORDER_BY_ASC);
					}
					else {
						query.append(ORDER_BY_DESC);
					}
				}
			}
		}
		else {
			query.append(BusinessTypeModelImpl.ORDER_BY_JPQL);
		}

		String sql = query.toString();

		Query q = session.createQuery(sql);

		q.setFirstResult(0);
		q.setMaxResults(2);

		QueryPos qPos = QueryPos.getInstance(q);

		if (bindButy_Description) {
			qPos.add(Buty_Description);
		}

		if (orderByComparator != null) {
			Object[] values = orderByComparator.getOrderByConditionValues(businessType);

			for (Object value : values) {
				qPos.add(value);
			}
		}

		List<BusinessType> list = q.list();

		if (list.size() == 2) {
			return list.get(1);
		}
		else {
			return null;
		}
	}

	/**
	 * Removes all the business types where Buty_Description = &#63; from the database.
	 *
	 * @param Buty_Description the buty_ description
	 * @throws SystemException if a system exception occurred
	 */
	@Override
	public void removeByFinder_Buty_Description(String Buty_Description)
		throws SystemException {
		for (BusinessType businessType : findByFinder_Buty_Description(
				Buty_Description, QueryUtil.ALL_POS, QueryUtil.ALL_POS, null)) {
			remove(businessType);
		}
	}

	/**
	 * Returns the number of business types where Buty_Description = &#63;.
	 *
	 * @param Buty_Description the buty_ description
	 * @return the number of matching business types
	 * @throws SystemException if a system exception occurred
	 */
	@Override
	public int countByFinder_Buty_Description(String Buty_Description)
		throws SystemException {
		FinderPath finderPath = FINDER_PATH_COUNT_BY_FINDER_BUTY_DESCRIPTION;

		Object[] finderArgs = new Object[] { Buty_Description };

		Long count = (Long)FinderCacheUtil.getResult(finderPath, finderArgs,
				this);

		if (count == null) {
			StringBundler query = new StringBundler(2);

			query.append(_SQL_COUNT_BUSINESSTYPE_WHERE);

			boolean bindButy_Description = false;

			if (Buty_Description == null) {
				query.append(_FINDER_COLUMN_FINDER_BUTY_DESCRIPTION_BUTY_DESCRIPTION_1);
			}
			else if (Buty_Description.equals(StringPool.BLANK)) {
				query.append(_FINDER_COLUMN_FINDER_BUTY_DESCRIPTION_BUTY_DESCRIPTION_3);
			}
			else {
				bindButy_Description = true;

				query.append(_FINDER_COLUMN_FINDER_BUTY_DESCRIPTION_BUTY_DESCRIPTION_2);
			}

			String sql = query.toString();

			Session session = null;

			try {
				session = openSession();

				Query q = session.createQuery(sql);

				QueryPos qPos = QueryPos.getInstance(q);

				if (bindButy_Description) {
					qPos.add(Buty_Description);
				}

				count = (Long)q.uniqueResult();

				FinderCacheUtil.putResult(finderPath, finderArgs, count);
			}
			catch (Exception e) {
				FinderCacheUtil.removeResult(finderPath, finderArgs);

				throw processException(e);
			}
			finally {
				closeSession(session);
			}
		}

		return count.intValue();
	}

	private static final String _FINDER_COLUMN_FINDER_BUTY_DESCRIPTION_BUTY_DESCRIPTION_1 =
		"businessType.Buty_Description IS NULL";
	private static final String _FINDER_COLUMN_FINDER_BUTY_DESCRIPTION_BUTY_DESCRIPTION_2 =
		"businessType.Buty_Description = ?";
	private static final String _FINDER_COLUMN_FINDER_BUTY_DESCRIPTION_BUTY_DESCRIPTION_3 =
		"(businessType.Buty_Description IS NULL OR businessType.Buty_Description = '')";

	public BusinessTypePersistenceImpl() {
		setModelClass(BusinessType.class);
	}

	/**
	 * Caches the business type in the entity cache if it is enabled.
	 *
	 * @param businessType the business type
	 */
	@Override
	public void cacheResult(BusinessType businessType) {
		EntityCacheUtil.putResult(BusinessTypeModelImpl.ENTITY_CACHE_ENABLED,
			BusinessTypeImpl.class, businessType.getPrimaryKey(), businessType);

		businessType.resetOriginalValues();
	}

	/**
	 * Caches the business types in the entity cache if it is enabled.
	 *
	 * @param businessTypes the business types
	 */
	@Override
	public void cacheResult(List<BusinessType> businessTypes) {
		for (BusinessType businessType : businessTypes) {
			if (EntityCacheUtil.getResult(
						BusinessTypeModelImpl.ENTITY_CACHE_ENABLED,
						BusinessTypeImpl.class, businessType.getPrimaryKey()) == null) {
				cacheResult(businessType);
			}
			else {
				businessType.resetOriginalValues();
			}
		}
	}

	/**
	 * Clears the cache for all business types.
	 *
	 * <p>
	 * The {@link com.liferay.portal.kernel.dao.orm.EntityCache} and {@link com.liferay.portal.kernel.dao.orm.FinderCache} are both cleared by this method.
	 * </p>
	 */
	@Override
	public void clearCache() {
		if (_HIBERNATE_CACHE_USE_SECOND_LEVEL_CACHE) {
			CacheRegistryUtil.clear(BusinessTypeImpl.class.getName());
		}

		EntityCacheUtil.clearCache(BusinessTypeImpl.class.getName());

		FinderCacheUtil.clearCache(FINDER_CLASS_NAME_ENTITY);
		FinderCacheUtil.clearCache(FINDER_CLASS_NAME_LIST_WITH_PAGINATION);
		FinderCacheUtil.clearCache(FINDER_CLASS_NAME_LIST_WITHOUT_PAGINATION);
	}

	/**
	 * Clears the cache for the business type.
	 *
	 * <p>
	 * The {@link com.liferay.portal.kernel.dao.orm.EntityCache} and {@link com.liferay.portal.kernel.dao.orm.FinderCache} are both cleared by this method.
	 * </p>
	 */
	@Override
	public void clearCache(BusinessType businessType) {
		EntityCacheUtil.removeResult(BusinessTypeModelImpl.ENTITY_CACHE_ENABLED,
			BusinessTypeImpl.class, businessType.getPrimaryKey());

		FinderCacheUtil.clearCache(FINDER_CLASS_NAME_LIST_WITH_PAGINATION);
		FinderCacheUtil.clearCache(FINDER_CLASS_NAME_LIST_WITHOUT_PAGINATION);
	}

	@Override
	public void clearCache(List<BusinessType> businessTypes) {
		FinderCacheUtil.clearCache(FINDER_CLASS_NAME_LIST_WITH_PAGINATION);
		FinderCacheUtil.clearCache(FINDER_CLASS_NAME_LIST_WITHOUT_PAGINATION);

		for (BusinessType businessType : businessTypes) {
			EntityCacheUtil.removeResult(BusinessTypeModelImpl.ENTITY_CACHE_ENABLED,
				BusinessTypeImpl.class, businessType.getPrimaryKey());
		}
	}

	/**
	 * Creates a new business type with the primary key. Does not add the business type to the database.
	 *
	 * @param Buty_ID the primary key for the new business type
	 * @return the new business type
	 */
	@Override
	public BusinessType create(int Buty_ID) {
		BusinessType businessType = new BusinessTypeImpl();

		businessType.setNew(true);
		businessType.setPrimaryKey(Buty_ID);

		return businessType;
	}

	/**
	 * Removes the business type with the primary key from the database. Also notifies the appropriate model listeners.
	 *
	 * @param Buty_ID the primary key of the business type
	 * @return the business type that was removed
	 * @throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException if a business type with the primary key could not be found
	 * @throws SystemException if a system exception occurred
	 */
	@Override
	public BusinessType remove(int Buty_ID)
		throws NoSuchBusinessTypeException, SystemException {
		return remove((Serializable)Buty_ID);
	}

	/**
	 * Removes the business type with the primary key from the database. Also notifies the appropriate model listeners.
	 *
	 * @param primaryKey the primary key of the business type
	 * @return the business type that was removed
	 * @throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException if a business type with the primary key could not be found
	 * @throws SystemException if a system exception occurred
	 */
	@Override
	public BusinessType remove(Serializable primaryKey)
		throws NoSuchBusinessTypeException, SystemException {
		Session session = null;

		try {
			session = openSession();

			BusinessType businessType = (BusinessType)session.get(BusinessTypeImpl.class,
					primaryKey);

			if (businessType == null) {
				if (_log.isWarnEnabled()) {
					_log.warn(_NO_SUCH_ENTITY_WITH_PRIMARY_KEY + primaryKey);
				}

				throw new NoSuchBusinessTypeException(_NO_SUCH_ENTITY_WITH_PRIMARY_KEY +
					primaryKey);
			}

			return remove(businessType);
		}
		catch (NoSuchBusinessTypeException nsee) {
			throw nsee;
		}
		catch (Exception e) {
			throw processException(e);
		}
		finally {
			closeSession(session);
		}
	}

	@Override
	protected BusinessType removeImpl(BusinessType businessType)
		throws SystemException {
		businessType = toUnwrappedModel(businessType);

		Session session = null;

		try {
			session = openSession();

			if (!session.contains(businessType)) {
				businessType = (BusinessType)session.get(BusinessTypeImpl.class,
						businessType.getPrimaryKeyObj());
			}

			if (businessType != null) {
				session.delete(businessType);
			}
		}
		catch (Exception e) {
			throw processException(e);
		}
		finally {
			closeSession(session);
		}

		if (businessType != null) {
			clearCache(businessType);
		}

		return businessType;
	}

	@Override
	public BusinessType updateImpl(
		au.com.billingbuddy.porlet.services.model.BusinessType businessType)
		throws SystemException {
		businessType = toUnwrappedModel(businessType);

		boolean isNew = businessType.isNew();

		BusinessTypeModelImpl businessTypeModelImpl = (BusinessTypeModelImpl)businessType;

		Session session = null;

		try {
			session = openSession();

			if (businessType.isNew()) {
				session.save(businessType);

				businessType.setNew(false);
			}
			else {
				session.merge(businessType);
			}
		}
		catch (Exception e) {
			throw processException(e);
		}
		finally {
			closeSession(session);
		}

		FinderCacheUtil.clearCache(FINDER_CLASS_NAME_LIST_WITH_PAGINATION);

		if (isNew || !BusinessTypeModelImpl.COLUMN_BITMASK_ENABLED) {
			FinderCacheUtil.clearCache(FINDER_CLASS_NAME_LIST_WITHOUT_PAGINATION);
		}

		else {
			if ((businessTypeModelImpl.getColumnBitmask() &
					FINDER_PATH_WITHOUT_PAGINATION_FIND_BY_FINDER_BUTY_DESCRIPTION.getColumnBitmask()) != 0) {
				Object[] args = new Object[] {
						businessTypeModelImpl.getOriginalButy_Description()
					};

				FinderCacheUtil.removeResult(FINDER_PATH_COUNT_BY_FINDER_BUTY_DESCRIPTION,
					args);
				FinderCacheUtil.removeResult(FINDER_PATH_WITHOUT_PAGINATION_FIND_BY_FINDER_BUTY_DESCRIPTION,
					args);

				args = new Object[] { businessTypeModelImpl.getButy_Description() };

				FinderCacheUtil.removeResult(FINDER_PATH_COUNT_BY_FINDER_BUTY_DESCRIPTION,
					args);
				FinderCacheUtil.removeResult(FINDER_PATH_WITHOUT_PAGINATION_FIND_BY_FINDER_BUTY_DESCRIPTION,
					args);
			}
		}

		EntityCacheUtil.putResult(BusinessTypeModelImpl.ENTITY_CACHE_ENABLED,
			BusinessTypeImpl.class, businessType.getPrimaryKey(), businessType);

		return businessType;
	}

	protected BusinessType toUnwrappedModel(BusinessType businessType) {
		if (businessType instanceof BusinessTypeImpl) {
			return businessType;
		}

		BusinessTypeImpl businessTypeImpl = new BusinessTypeImpl();

		businessTypeImpl.setNew(businessType.isNew());
		businessTypeImpl.setPrimaryKey(businessType.getPrimaryKey());

		businessTypeImpl.setButy_ID(businessType.getButy_ID());
		businessTypeImpl.setButy_Description(businessType.getButy_Description());
		businessTypeImpl.setButy_Status(businessType.getButy_Status());

		return businessTypeImpl;
	}

	/**
	 * Returns the business type with the primary key or throws a {@link com.liferay.portal.NoSuchModelException} if it could not be found.
	 *
	 * @param primaryKey the primary key of the business type
	 * @return the business type
	 * @throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException if a business type with the primary key could not be found
	 * @throws SystemException if a system exception occurred
	 */
	@Override
	public BusinessType findByPrimaryKey(Serializable primaryKey)
		throws NoSuchBusinessTypeException, SystemException {
		BusinessType businessType = fetchByPrimaryKey(primaryKey);

		if (businessType == null) {
			if (_log.isWarnEnabled()) {
				_log.warn(_NO_SUCH_ENTITY_WITH_PRIMARY_KEY + primaryKey);
			}

			throw new NoSuchBusinessTypeException(_NO_SUCH_ENTITY_WITH_PRIMARY_KEY +
				primaryKey);
		}

		return businessType;
	}

	/**
	 * Returns the business type with the primary key or throws a {@link au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException} if it could not be found.
	 *
	 * @param Buty_ID the primary key of the business type
	 * @return the business type
	 * @throws au.com.billingbuddy.porlet.services.NoSuchBusinessTypeException if a business type with the primary key could not be found
	 * @throws SystemException if a system exception occurred
	 */
	@Override
	public BusinessType findByPrimaryKey(int Buty_ID)
		throws NoSuchBusinessTypeException, SystemException {
		return findByPrimaryKey((Serializable)Buty_ID);
	}

	/**
	 * Returns the business type with the primary key or returns <code>null</code> if it could not be found.
	 *
	 * @param primaryKey the primary key of the business type
	 * @return the business type, or <code>null</code> if a business type with the primary key could not be found
	 * @throws SystemException if a system exception occurred
	 */
	@Override
	public BusinessType fetchByPrimaryKey(Serializable primaryKey)
		throws SystemException {
		BusinessType businessType = (BusinessType)EntityCacheUtil.getResult(BusinessTypeModelImpl.ENTITY_CACHE_ENABLED,
				BusinessTypeImpl.class, primaryKey);

		if (businessType == _nullBusinessType) {
			return null;
		}

		if (businessType == null) {
			Session session = null;

			try {
				session = openSession();

				businessType = (BusinessType)session.get(BusinessTypeImpl.class,
						primaryKey);

				if (businessType != null) {
					cacheResult(businessType);
				}
				else {
					EntityCacheUtil.putResult(BusinessTypeModelImpl.ENTITY_CACHE_ENABLED,
						BusinessTypeImpl.class, primaryKey, _nullBusinessType);
				}
			}
			catch (Exception e) {
				EntityCacheUtil.removeResult(BusinessTypeModelImpl.ENTITY_CACHE_ENABLED,
					BusinessTypeImpl.class, primaryKey);

				throw processException(e);
			}
			finally {
				closeSession(session);
			}
		}

		return businessType;
	}

	/**
	 * Returns the business type with the primary key or returns <code>null</code> if it could not be found.
	 *
	 * @param Buty_ID the primary key of the business type
	 * @return the business type, or <code>null</code> if a business type with the primary key could not be found
	 * @throws SystemException if a system exception occurred
	 */
	@Override
	public BusinessType fetchByPrimaryKey(int Buty_ID)
		throws SystemException {
		return fetchByPrimaryKey((Serializable)Buty_ID);
	}

	/**
	 * Returns all the business types.
	 *
	 * @return the business types
	 * @throws SystemException if a system exception occurred
	 */
	@Override
	public List<BusinessType> findAll() throws SystemException {
		return findAll(QueryUtil.ALL_POS, QueryUtil.ALL_POS, null);
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
	public List<BusinessType> findAll(int start, int end)
		throws SystemException {
		return findAll(start, end, null);
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
	@Override
	public List<BusinessType> findAll(int start, int end,
		OrderByComparator orderByComparator) throws SystemException {
		boolean pagination = true;
		FinderPath finderPath = null;
		Object[] finderArgs = null;

		if ((start == QueryUtil.ALL_POS) && (end == QueryUtil.ALL_POS) &&
				(orderByComparator == null)) {
			pagination = false;
			finderPath = FINDER_PATH_WITHOUT_PAGINATION_FIND_ALL;
			finderArgs = FINDER_ARGS_EMPTY;
		}
		else {
			finderPath = FINDER_PATH_WITH_PAGINATION_FIND_ALL;
			finderArgs = new Object[] { start, end, orderByComparator };
		}

		List<BusinessType> list = (List<BusinessType>)FinderCacheUtil.getResult(finderPath,
				finderArgs, this);

		if (list == null) {
			StringBundler query = null;
			String sql = null;

			if (orderByComparator != null) {
				query = new StringBundler(2 +
						(orderByComparator.getOrderByFields().length * 3));

				query.append(_SQL_SELECT_BUSINESSTYPE);

				appendOrderByComparator(query, _ORDER_BY_ENTITY_ALIAS,
					orderByComparator);

				sql = query.toString();
			}
			else {
				sql = _SQL_SELECT_BUSINESSTYPE;

				if (pagination) {
					sql = sql.concat(BusinessTypeModelImpl.ORDER_BY_JPQL);
				}
			}

			Session session = null;

			try {
				session = openSession();

				Query q = session.createQuery(sql);

				if (!pagination) {
					list = (List<BusinessType>)QueryUtil.list(q, getDialect(),
							start, end, false);

					Collections.sort(list);

					list = new UnmodifiableList<BusinessType>(list);
				}
				else {
					list = (List<BusinessType>)QueryUtil.list(q, getDialect(),
							start, end);
				}

				cacheResult(list);

				FinderCacheUtil.putResult(finderPath, finderArgs, list);
			}
			catch (Exception e) {
				FinderCacheUtil.removeResult(finderPath, finderArgs);

				throw processException(e);
			}
			finally {
				closeSession(session);
			}
		}

		return list;
	}

	/**
	 * Removes all the business types from the database.
	 *
	 * @throws SystemException if a system exception occurred
	 */
	@Override
	public void removeAll() throws SystemException {
		for (BusinessType businessType : findAll()) {
			remove(businessType);
		}
	}

	/**
	 * Returns the number of business types.
	 *
	 * @return the number of business types
	 * @throws SystemException if a system exception occurred
	 */
	@Override
	public int countAll() throws SystemException {
		Long count = (Long)FinderCacheUtil.getResult(FINDER_PATH_COUNT_ALL,
				FINDER_ARGS_EMPTY, this);

		if (count == null) {
			Session session = null;

			try {
				session = openSession();

				Query q = session.createQuery(_SQL_COUNT_BUSINESSTYPE);

				count = (Long)q.uniqueResult();

				FinderCacheUtil.putResult(FINDER_PATH_COUNT_ALL,
					FINDER_ARGS_EMPTY, count);
			}
			catch (Exception e) {
				FinderCacheUtil.removeResult(FINDER_PATH_COUNT_ALL,
					FINDER_ARGS_EMPTY);

				throw processException(e);
			}
			finally {
				closeSession(session);
			}
		}

		return count.intValue();
	}

	/**
	 * Initializes the business type persistence.
	 */
	public void afterPropertiesSet() {
		String[] listenerClassNames = StringUtil.split(GetterUtil.getString(
					com.liferay.util.service.ServiceProps.get(
						"value.object.listener.au.com.billingbuddy.porlet.services.model.BusinessType")));

		if (listenerClassNames.length > 0) {
			try {
				List<ModelListener<BusinessType>> listenersList = new ArrayList<ModelListener<BusinessType>>();

				for (String listenerClassName : listenerClassNames) {
					listenersList.add((ModelListener<BusinessType>)InstanceFactory.newInstance(
							getClassLoader(), listenerClassName));
				}

				listeners = listenersList.toArray(new ModelListener[listenersList.size()]);
			}
			catch (Exception e) {
				_log.error(e);
			}
		}
	}

	public void destroy() {
		EntityCacheUtil.removeCache(BusinessTypeImpl.class.getName());
		FinderCacheUtil.removeCache(FINDER_CLASS_NAME_ENTITY);
		FinderCacheUtil.removeCache(FINDER_CLASS_NAME_LIST_WITH_PAGINATION);
		FinderCacheUtil.removeCache(FINDER_CLASS_NAME_LIST_WITHOUT_PAGINATION);
	}

	private static final String _SQL_SELECT_BUSINESSTYPE = "SELECT businessType FROM BusinessType businessType";
	private static final String _SQL_SELECT_BUSINESSTYPE_WHERE = "SELECT businessType FROM BusinessType businessType WHERE ";
	private static final String _SQL_COUNT_BUSINESSTYPE = "SELECT COUNT(businessType) FROM BusinessType businessType";
	private static final String _SQL_COUNT_BUSINESSTYPE_WHERE = "SELECT COUNT(businessType) FROM BusinessType businessType WHERE ";
	private static final String _ORDER_BY_ENTITY_ALIAS = "businessType.";
	private static final String _NO_SUCH_ENTITY_WITH_PRIMARY_KEY = "No BusinessType exists with the primary key ";
	private static final String _NO_SUCH_ENTITY_WITH_KEY = "No BusinessType exists with the key {";
	private static final boolean _HIBERNATE_CACHE_USE_SECOND_LEVEL_CACHE = GetterUtil.getBoolean(PropsUtil.get(
				PropsKeys.HIBERNATE_CACHE_USE_SECOND_LEVEL_CACHE));
	private static Log _log = LogFactoryUtil.getLog(BusinessTypePersistenceImpl.class);
	private static BusinessType _nullBusinessType = new BusinessTypeImpl() {
			@Override
			public Object clone() {
				return this;
			}

			@Override
			public CacheModel<BusinessType> toCacheModel() {
				return _nullBusinessTypeCacheModel;
			}
		};

	private static CacheModel<BusinessType> _nullBusinessTypeCacheModel = new CacheModel<BusinessType>() {
			@Override
			public BusinessType toEntityModel() {
				return _nullBusinessType;
			}
		};
}