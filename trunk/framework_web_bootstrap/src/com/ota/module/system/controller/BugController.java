package com.ota.module.system.controller;

import com.jfinal.aop.Before;
import com.jfinal.ext.route.ControllerBind;
import com.ota.base.Constant;
import com.ota.ext.Controller;
import com.ota.module.system.model.Bug;
import com.ota.module.system.validator.BugValidator;

@ControllerBind(controllerKey = "/system/bug", viewPath = Constant.URL.SYSTEM)
public class BugController extends Controller {

	public void list() {

		renderJson(Bug.dao.list(getDataGrid(), getFrom(null)));
	}

	@Before(value = { BugValidator.class })
	public void add() {
		renderJsonResult(getModel(Bug.class).saveAndCreateDate());

	}

	@Before(value = { BugValidator.class })
	public void edit() {
		renderJsonResult(getModel(Bug.class).updateAndModifyDate());

	}

	public void delete() {
		renderJsonResult(Bug.dao.deleteById(getPara("id")));
	}

}
