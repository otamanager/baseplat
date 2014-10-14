package com.ota.module.system.controller;

import com.jfinal.aop.Before;
import com.jfinal.ext.route.ControllerBind;
import com.ota.base.Constant;
import com.ota.common.shiro.ShiroCache;
import com.ota.ext.Controller;
import com.ota.module.system.model.User;
import com.ota.module.system.validator.UserValidator;

@ControllerBind(controllerKey = "/system/user", viewPath = Constant.URL.SYSTEM)
public class UserController extends Controller<User> {

	public void list() {

		renderJson(User.dao.listByDataGrid(getDataGrid(), getFrom(User.dao.tableName)));
	}

	@Override
	public void delete() {
		renderJsonResult(User.dao.deleteById(getPara("id")));
	}

	public void batchDelete() {
		renderJsonResult(User.dao.batchDelete(getPara("ids")));
	}

	public void batchGrant() {

		Integer[] role_ids = getParaValuesToInt("role_ids");
		String ids = getPara("ids");

		renderJsonResult(User.dao.batchGrant(role_ids, ids));

		ShiroCache.clearAuthorizationInfoAll();

	}

	@Before(value = { UserValidator.class })
	public void add() {
		renderJsonResult(getModel(User.class).encrypt().saveAndDate());
	}

	@Override
	@Before(value = { UserValidator.class })
	public void edit() {
		renderJsonResult(getModel(User.class).encrypt().update());
	}

	public void grant() {
		Integer[] role_ids = getParaValuesToInt("role_ids");

		renderJsonResult(User.dao.grant(role_ids, getModel(User.class).getId()));

		ShiroCache.clearAuthorizationInfoAll();

	}

}
