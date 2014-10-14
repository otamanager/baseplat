package com.ota.common.model.echart;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MapChart {
	public List<String> legendDate = new ArrayList<String>();
	public List<Map> mapDate = new ArrayList<Map>();
	public List<Map> pieDate = new ArrayList<Map>();

	public int max;

	public void setMapDate(String name, int value, boolean select) {
		Map map = new HashMap();
		map.put("name", name);
		map.put("value", value);
		map.put("selected", select);

		if (value > max)
			max = value;

		mapDate.add(map);
	}

	public void setPieDate(String name, int value, boolean select) {

		Map map = new HashMap();
		map.put("name", name);
		map.put("value", value);
		map.put("selected", select);
		pieDate.add(map);

	}

}
