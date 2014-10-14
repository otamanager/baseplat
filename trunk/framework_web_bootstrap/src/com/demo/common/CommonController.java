package com.demo.common;

import com.demo.system.User;
import com.jfinal.core.Controller;

/**
 * CommonController
 */
public class CommonController extends Controller {

	public void index() {
		render("/pages/common/login.jsp");
	}

	public void main() {
		User user = getModel(User.class).queryBy();
		if (null == user) {
			render("/pages/common/login.jsp");
		} else {
			render("/pages/common/_header.jsp");
		}
	}
}
