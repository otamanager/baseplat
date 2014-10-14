package com.ota.common.index;

import java.util.Collections;
import java.util.List;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.ota.ext.Model;

@TableBind(tableName = "index_msg")
public class Msg extends Model<Msg> {
	private static final long serialVersionUID = -128801010211787215L;

	public static Msg dao = new Msg();

	public List<Msg> list() {
		List<Msg> list = dao.find(sql("index.msg.list"));
		Collections.reverse(list);
		return list;
	}

}
