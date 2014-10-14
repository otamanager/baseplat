package com.ota.common.model.easyui;

import java.util.ArrayList;
import java.util.List;

/**
 * EasyUI tree模型
 * 
 * 
 */
public class Tree implements java.io.Serializable {
	public static final long serialVersionUID = 2592596759941016872L;

	public int id;
	public String text;
	public String state = "closed";// open,closed
	public boolean checked = false;
	public Object attributes;
	public List<Tree> children = new ArrayList<Tree>();
	public String iconCls;
	public int pid;

	public Tree(int id, int pid, String text, String icon, Object obj, boolean haveChild) {

		this.id = id;
		this.pid = pid;
		this.text = text;
		this.iconCls = icon;
		this.attributes = obj;

		if (!haveChild)
			changeState();

	}

	public void changeState() {
		this.state = "open";
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public Object getAttributes() {
		return attributes;
	}

	public void setAttributes(Object attributes) {
		this.attributes = attributes;
	}

	public List<Tree> getChildren() {
		return children;
	}

	public void setChildren(List<Tree> children) {
		this.children = children;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

}
