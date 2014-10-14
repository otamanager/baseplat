package com.ota.module.system.controller;

import com.jfinal.aop.Before;
import com.jfinal.ext.route.ControllerBind;
import com.ota.base.Constant;
import com.ota.common.shiro.ShiroCache;
import com.ota.common.shiro.ShiroInterceptor;
import com.ota.ext.Controller;
import com.ota.module.system.model.Res;
import com.ota.module.system.validator.ResValidator;

@ControllerBind(controllerKey = "/system/res", viewPath = Constant.URL.SYSTEM)
public class ResController extends Controller {

	public void tree() {
		int pid = getParaToInt("id", 0);
		int type = getParaToInt("type", Res.TYPE_MEUE);
		renderJson(Res.dao.getTree(pid, type));

	}

	public void list() {
		renderJson(Res.dao.list(" order by seq "));
	}

	public void delete() {
		renderJsonResult(Res.dao.deleteById(getPara("id")));
		removeAuthorization();
	}

	@Before(value = { ResValidator.class })
	public void add() {
		renderJsonResult(getModel(Res.class).emptyRemove("pid").save());
		removeAuthorization();
	}

	@Before(value = { ResValidator.class })
	public void edit() {
		renderJsonResult(getModel(Res.class).update());
		removeAuthorization();

	}

	private void removeAuthorization() {
		ShiroCache.clearAuthorizationInfoAll();
		ShiroInterceptor.updateUrls();
	}

}
