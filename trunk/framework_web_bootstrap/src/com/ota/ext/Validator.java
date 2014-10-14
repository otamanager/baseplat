package com.ota.ext;

import com.jfinal.core.Controller;

public abstract class Validator extends com.jfinal.validate.Validator {

	/***
	 * 默认 error msg
	 */
	public static final String ERROR_MSG = "msg";

	@Override
	protected void handleError(Controller c) {
		c.renderJson(ERROR_MSG, c.getAttr(ERROR_MSG));
	}

	protected void addError(String errorMessage) {
		super.addError(ERROR_MSG, errorMessage);
	}

	protected void validateRequiredString(String field, String errorMessage) {
		super.validateRequiredString(field, ERROR_MSG, errorMessage);
	}

	protected void validateString(String field, int minLen, int maxLen, String errorMessage) {
		super.validateString(field, minLen, maxLen, ERROR_MSG, errorMessage);
	}

	protected void validateInteger(String field, int min, int max, String errorMessage) {
		super.validateInteger(field, min, max, ERROR_MSG, errorMessage);
	}

	protected void validateString(String field, boolean notBlank, int minLen, int maxLen, String errorMessage) {
		super.validateString(field, notBlank, minLen, maxLen, ERROR_MSG, errorMessage);
	}

}
