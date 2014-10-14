package com.ota.common.model.easyui;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.ota.ext.Model;

@SuppressWarnings("rawtypes")
public class TreeGrid<T extends Model> implements Serializable {
	private static final long serialVersionUID = -651409349713864935L;
	public int total;

	public List<Map> rows = new ArrayList<Map>();

	public void addRows(List<T> list) {

		for (Model m : list) {

			rows.add(m.getAttrs());
		}
	}

}
