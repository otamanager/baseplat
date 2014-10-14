package com.ota.common.index;

import com.jfinal.aop.Before;
import com.jfinal.ext.route.ControllerBind;
import com.jfinal.plugin.ehcache.CacheInterceptor;
import com.jfinal.plugin.ehcache.CacheName;
import com.jfinal.plugin.ehcache.EvictInterceptor;
import com.ota.base.Constant;
import com.ota.common.validator.MsgValidator;
import com.ota.ext.Controller;
import com.ota.ext.ShiroExt;
import com.ota.module.system.model.User;

@CacheName(value = "/index/msg")
@ControllerBind(controllerKey = "/index/msg")
public class MsgController extends Controller {

	/***
	 * 使用页面缓存 注意：经常变动的不能使用缓存 与权限相关的 不能用页面缓存 可使用 sql 缓存
	 * 
	 */
	@Before(value = { CacheInterceptor.class })
	public void list() {
		setAttr("list", Msg.dao.list());

		render(Constant.URL.VIEW_INDEX_MSG);

	}

	@Before(value = { EvictInterceptor.class, MsgValidator.class })
	public void add() {
		User user = ShiroExt.getSessionAttr(Constant.SESSION_USER);
		renderJsonResult(getModel(Msg.class).set("uid", user.getId()).saveAndDate());

	}

}
