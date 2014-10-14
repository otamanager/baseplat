package com.ota.module.system.validator;

import com.jfinal.core.Controller;
import com.ota.ext.Validator;
import com.ota.module.system.model.User;
import com.ota.util.Validate;

public class UserValidator extends Validator {

	@Override
	protected void validate(Controller c) {

		validateString("user.name", 1, 20, "名称不能为空 并且不能超过20个字符");
		validateString("user.des", false, 0, 100, "描述不能超过100个字符");
		validateString("user.pwd", 5, 100, "密码不能为空 并且在5 到100个字符");

		if (Validate.isEmpty(c.getPara("user.id")) && User.dao.checkNameExist(c.getPara("user.name")))
			addError("用户名已存在");

	}

}
