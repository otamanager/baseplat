package com.ota.module.system.validator;

import com.jfinal.core.Controller;
import com.ota.ext.Validator;

public class ResValidator extends Validator {

	@Override
	protected void validate(Controller c) {
		validateString("res.iconCls", false, 0, 50, "图标有问题");
		validateString("res.des", false, 0, 50, "备注不能超过50个字符");
		validateString("res.name", false, 0, 30, "名字不能超过30个字符");
		validateInteger("res.seq", 1, 1000, "必需设置 排序");
		validateInteger("res.type", 1, 2, "类型错误");

	}

}
