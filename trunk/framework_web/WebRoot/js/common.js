var comUtil = {
	/** 同级页面跳转,可接受无限个参数， */
	goUrl : function() {
		var args = arguments;
		var str = "";
		for ( var i = 0; i < args.length; i++) {
			if (i == 0) {
				if (i != args.length - 1) {
					str += args[i] + "&";
					continue;
				}
			}
			if (i % 2 != 0) {
				str += args[i] + "=";
			} else {
				str += args[i];
				if (i != args.length - 1) {
					str += "&";
				}
			}
		}
		window.location.href = str;
	},

	/** 父级页面跳转,可接受无限个参数 */
	goParentUrl : function() {
		var args = arguments;
		var str = "";
		for ( var i = 0; i < args.length; i++) {
			if (i == 0) {
				if (i != args.length - 1) {
					str += args[i] + "&";
					continue;
				}
			}
			if (i % 2 != 0) {
				str += args[i] + "=";
			} else {
				str += args[i];
				if (i != args.length - 1) {
					str += "&";
				}
			}
		}
		parent.window.location.href = str;
	},

	/** checkbox 全不选 ，全选，反选 */
	checkBoxSelect : function(obj, name) {
		$("input[name = '" + name + "']").attr("checked", obj.checked);
	},

	/** 自定义alert */
	alert : function(msg, callback) {
		$.dialog({
			content : msg,
			width : 300,
			height : 70,
			resize : false,
			lock : true,
			cancel : false,
			ok : function() {
				comUtil.callOnClick(callback);
			}
		});
	},
	/** 自定义确认框 */
	confirm : function(msg, callbackConfirm, callbackCancel) {
		$.dialog({
			content : msg,
			width : 300,
			resize : false,
			height : 70,
			lock : true,
			ok : function() {
				comUtil.callOnClick(callbackConfirm);
			},
			cancel : function() {
				comUtil.callOnClick(callbackCancel);
			}
		});
	},

	/** 开启蒙板 */
	showMask : function() {
		$
				.dialog({
					id : '_loadding',
					content : "<div style='height:19px;line-height:19px;width:220px;text-align:center;'><img src='/images/loadding.gif'/></div>",
					padding : 0,
					title : false,
					resize : false,
					lock : true,
					cancel : false
				});
	},

	/** 隐藏蒙板 */
	hideMask : function() {
		$.dialog({
			id : "_loadding"
		}).close();
	},

	/** 弹出框-根据url确定打开页面 */
	openByUrl : function(_title, _id, _width, _height, _url) {
		$.dialog.open(_url, {
			title : _title + "（按Esc关闭窗口）",
			id : _id,
			width : _width,
			height : _height,
			resize : false,
			lock : true
		});
	},

	/** 弹出框-根据页面dom元素打开页面 */
	openByDom : function(_title, _dialogId, _width, _height, _domId) {
		$.dialog({
			title : _title,
			content : document.getElementById(_domId),
			id : _dialogId,
			padding : 0,
			width : _width,
			height : _height,
			resize : false,
			lock : true
		});
	},
	/** 根据id关闭dialog */
	closeDialogById : function(_id) {
		$.dialog.get(_id).close();
	},
	/** 根据Id关闭dialog */
	closeDialog : function(_id) {
		parent.art.dialog.list[_id].close();
	},
	/** 回调函数 */
	callOnClick : function(callback) {// private
		if (typeof (callback) == 'function') {
			callback();
		}
	},

	/** 去除字符串左右空格 */
	trim : function(str) {
		if (typeof (str) == "string") {
			var tempLtrim = str.replace(/(^\s*)/g, "");// 去掉左空格
			var tempRtrim = tempLtrim.replace(/(\s*$)/g, "");//
			return tempRtrim;
		} else {
			return str;
		}
	},

	/** 剔除非数字字符 */
	rNotDigt : function(obj) {
		var reg = /[^0-9]*/g;
		obj.value = obj.value.replace(reg, '');
	},

	/** 快捷键 */
	IsDigit : function() {
		return ((event.keyCode >= 48) && (event.keyCode <= 57));
	},

	/**
	 * 根据checkbox的name，拼接成指定type的字符串 name：checkbox的name type：拼接类型（比如","）
	 */
	getCheckedBoxsValByName : function(name, type) {
		var str = "";
		var $arr = $("input[name='" + name + "']:checked");
		$arr.each(function(i, obj) {
			if ((i + 1) == $arr.length) {
				str += $(obj).val();
			} else {
				str += $(obj).val() + type;
			}
		});
		return str;
	},
	getCheckedBoxsIdByName : function(name, type) {
		var str = "";
		var $arr = $("input[name='" + name + "']:checked");
		$arr.each(function(i, obj) {
			if ((i + 1) == $arr.length) {
				str += $(obj).attr("id");
			} else {
				str += $(obj).attr("id") + type;
			}
		});
		return str;
	},
	/**
	 * 把数组arr内的元素拼接成以指定type分隔的字符串（例如：aaa,bbb,cccs） arr:数组
	 * attr:如果数组内是对象形式，此参数则是指定对象的某个属性 type:分隔符
	 */
	arrayToStr : function(arr, attr, type) {
		var str = "";
		for ( var i = 0; i < arr.length; i++) {
			if (attr == null) {
				if ((i + 1) == arr.length) {
					str += arr[i];
				} else {
					str += arr[i] + type;
				}
			} else {
				if ((i + 1) == arr.length) {
					str += eval("arr[i]." + attr);
				} else {
					str += eval("arr[i]." + attr) + type;
				}
			}
		}
		return str;
	},
	/**
	 * 根据checkbox的name，获得选中的长度 name：checkbox的name
	 */
	getCheckedBoxsLengthByName : function(name) {
		return $("input[name='" + name + "']:checked").length;
	},
	/**
	 * 判断是否为空，空返回true val：需要判断的值
	 */
	isEmpty : function(val) {
		if (val == null || comUtil.trim(val).length < 1) {
			return true;
		} else {
			return false;
		}
	},
	/**
	 * 给指定的对象改变class样式 obj：对象 removeClass：需要移除的class newClass：需要添加的class
	 */
	changeClass : function(obj, removeClass, newClass) {
		$(obj).removeClass(removeClass);
		$(obj).addClass(newClass);
	},
	/**
	 * 计算两个日期的天数差 startDate：开始时间 endDate：结束时间
	 */
	getDateDiff : function(startDate, endDate) {
		var re = /^(\d{4})\S(\d{1,2})\S(\d{1,2})$/;
		var dt1, dt2;
		if (re.test(startDate)) {
			dt1 = new Date(RegExp.$1, RegExp.$2 - 1, RegExp.$3);
		}
		if (re.test(endDate)) {
			dt2 = new Date(RegExp.$1, RegExp.$2 - 1, RegExp.$3);
		}
		return Math.floor((dt2 - dt1) / (1000 * 60 * 60 * 24));
	},
	/**
	 * 格式化金额为2位小数 price：需要格式化的金额
	 */
	price_format : function(price) {
		// if(typeof(PRICE_FORMAT) == 'undefined'){
		// PRICE_FORMAT = '&yen;%s';
		// }
		return comUtil.number_format(price, 2);
		// return PRICE_FORMAT.replace('%s', price);
	},
	/**
	 * 私有方法，禁止直接调用 num：需要格式化的金额 ext：小数点位数
	 */
	number_format : function(num, ext) {
		if (ext < 0) {
			return num;
		}
		num = Number(num);
		if (isNaN(num)) {
			num = 0;
		}
		var _str = num.toString();
		var _arr = _str.split('.');
		var _int = _arr[0];
		var _flt = _arr[1];
		if (_str.indexOf('.') == -1) {
			/* 找不到小数点，则添加 */
			if (ext == 0) {
				return _str;
			}
			var _tmp = '';
			for ( var i = 0; i < ext; i++) {
				_tmp += '0';
			}
			_str = _str + '.' + _tmp;
		} else {
			if (_flt.length == ext) {
				return _str;
			}
			/* 找得到小数点，则截取 */
			if (_flt.length > ext) {
				_str = _str.substr(0, _str.length - (_flt.length - ext));
				if (ext == 0) {
					_str = _int;
				}
			} else {
				for ( var i = 0; i < ext - _flt.length; i++) {
					_str += '0';
				}
			}
		}

		return _str;
	},
	/**
	 * 删除指定数组内的指定值 array：需要删除的源数组 value：需要删除的值
	 */
	removeByVal : function(array, value) {
		array.splice($.inArray(value, array), 1);
	}
};
/**
 * 给页面的蓝色按钮添加鼠标移入移除的样式
 */
$(function() {
	$(".btn_nosel").mousemove(function() {
		comUtil.changeClass(this, 'btn_nosel', 'btn_sel');
	}).mouseout(function() {
		comUtil.changeClass(this, 'btn_sel', 'btn_nosel');
	});
	$(".btn_nosel_long").mousemove(function() {
		comUtil.changeClass(this, 'btn_nosel_long', 'btn_sel_long');
	}).mouseout(function() {
		comUtil.changeClass(this, 'btn_sel_long', 'btn_nosel_long');
	});
	$(".btn_nosel_small").mousemove(function() {
		comUtil.changeClass(this, 'btn_nosel_small', 'btn_sel_small');
	}).mouseout(function() {
		comUtil.changeClass(this, 'btn_sel_small', 'btn_nosel_small');
	});

});
