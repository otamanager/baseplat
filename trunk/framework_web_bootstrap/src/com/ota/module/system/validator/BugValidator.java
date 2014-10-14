package com.ota.module.system.validator;

import com.jfinal.core.Controller;
import com.ota.ext.Validator;

public class BugValidator extends Validator {

	@Override
	protected void validate(Controller c) {
		validateString("bug.name", 1, 50, "名称不能超过50个字符");
		validateString("bug.des", 0, 10000, "字符不能为空 或者太多了");

	}

}
