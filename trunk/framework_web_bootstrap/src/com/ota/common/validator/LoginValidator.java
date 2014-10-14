package com.ota.common.validator;

import com.jfinal.core.Controller;
import com.ota.base.Constant;
import com.ota.ext.Validator;
import com.ota.util.RSA;
import com.ota.util.Validate;

public class LoginValidator extends Validator {

	@Override
	protected void validate(Controller c) {
		validateRequiredString("key", "请重新登录");

		String key = c.getPara("key");
		if (!Validate.isEmpty(key)) {
			String[] result = RSA.decryptUsernameAndPwd(key);

			if (result == null)
				addError(ERROR_MSG, "用户名或密码不能为空");
		}

	}

	@Override
	protected void handleError(Controller c) {
		c.forwardAction(Constant.URL.LOGIN);
	}

}
