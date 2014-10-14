package com.ota.module.system.controller;

import com.jfinal.aop.Before;
import com.jfinal.ext.route.ControllerBind;
import com.ota.base.Constant;
import com.ota.common.shiro.ShiroCache;
import com.ota.ext.Controller;
import com.ota.module.system.model.Role;
import com.ota.module.system.validator.RoleValidator;

@ControllerBind(controllerKey = "/system/role", viewPath = Constant.URL.SYSTEM)
public class RoleController extends Controller {

	public void list() {
		renderJson(Role.dao.list());
	}

	public void tree() {

		int pid = getParaToInt("id", 0);
		renderJson(Role.dao.getTree(pid));

	}

	public void grant() {
		Role role = getModel(Role.class);
		String res_ids = getPara("res_ids");
		renderJsonResult(Role.dao.grant(role.getId(), res_ids));

		ShiroCache.clearAuthorizationInfoAll();

	}

	@Override
	@Before(value = { RoleValidator.class })
	public void add() {
		renderJsonResult(getModel(Role.class).save());
	}

	@Override
	@Before(value = { RoleValidator.class })
	public void edit() {
		renderJsonResult(getModel(Role.class).update());
	}

	public void delete() {
		renderJsonResult(Role.dao.deleteById(getPara("id")));
	}

}
