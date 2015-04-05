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

package au.com.billingbuddy.porlet.services.model.impl;

import au.com.billingbuddy.porlet.services.model.BusinessType;

import com.liferay.portal.kernel.util.StringBundler;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.model.CacheModel;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;

/**
 * The cache model class for representing BusinessType in entity cache.
 *
 * @author Edicson Morales
 * @see BusinessType
 * @generated
 */
public class BusinessTypeCacheModel implements CacheModel<BusinessType>,
	Externalizable {
	@Override
	public String toString() {
		StringBundler sb = new StringBundler(7);

		sb.append("{Buty_ID=");
		sb.append(Buty_ID);
		sb.append(", Buty_Description=");
		sb.append(Buty_Description);
		sb.append(", Buty_Status=");
		sb.append(Buty_Status);
		sb.append("}");

		return sb.toString();
	}

	@Override
	public BusinessType toEntityModel() {
		BusinessTypeImpl businessTypeImpl = new BusinessTypeImpl();

		businessTypeImpl.setButy_ID(Buty_ID);

		if (Buty_Description == null) {
			businessTypeImpl.setButy_Description(StringPool.BLANK);
		}
		else {
			businessTypeImpl.setButy_Description(Buty_Description);
		}

		if (Buty_Status == null) {
			businessTypeImpl.setButy_Status(StringPool.BLANK);
		}
		else {
			businessTypeImpl.setButy_Status(Buty_Status);
		}

		businessTypeImpl.resetOriginalValues();

		return businessTypeImpl;
	}

	@Override
	public void readExternal(ObjectInput objectInput) throws IOException {
		Buty_ID = objectInput.readInt();
		Buty_Description = objectInput.readUTF();
		Buty_Status = objectInput.readUTF();
	}

	@Override
	public void writeExternal(ObjectOutput objectOutput)
		throws IOException {
		objectOutput.writeInt(Buty_ID);

		if (Buty_Description == null) {
			objectOutput.writeUTF(StringPool.BLANK);
		}
		else {
			objectOutput.writeUTF(Buty_Description);
		}

		if (Buty_Status == null) {
			objectOutput.writeUTF(StringPool.BLANK);
		}
		else {
			objectOutput.writeUTF(Buty_Status);
		}
	}

	public int Buty_ID;
	public String Buty_Description;
	public String Buty_Status;
}