package com.demo.system;

import com.jfinal.core.Controller;

/**
 * 用户管理
 */
public class UserController extends Controller {
	/**
	 * 对应页面的基路径
	 */
	public static final String BASE = "/pages/system/user/";

	public void index() {
		render(BASE + "listInit.jsp");
	}

	public void query() {
		setAttr("page", getModel(User.class).queryPage(1, 10));
		render(BASE + "listData.jsp");
	}

	public void showAdd() {
		setAttr("entity", User.dao.findById(getPara("id")));
		render(BASE + "input.jsp");
	}

	public void showView() {
		render(BASE + "view.jsp");
	}

	public void showModify() {
		render(BASE + "input.jsp");
	}

	public void add() {
		getModel(User.class).save();
		setAttr("msg", "success");
		renderJson();
	}
}
