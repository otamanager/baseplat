package com.ota.module.system.model;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.ota.ext.Model;

@TableBind(tableName = "system_bug")
public class Bug extends Model<Bug> {
	private static final long serialVersionUID = 3706516534681611550L;

	public static Bug dao = new Bug();

}
