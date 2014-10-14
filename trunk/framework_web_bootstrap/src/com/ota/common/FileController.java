package com.ota.common;

import com.jfinal.ext.route.ControllerBind;
import com.ota.ext.Controller;
import com.ota.util.KindEditor;

@ControllerBind(controllerKey = "/common/file")
public class FileController extends Controller {

	public void upload() {
		renderJson(KindEditor.upload(this));
	}

	public void fileManage() {
		renderJson(KindEditor.fileManage(getRequest()));
	}

}
