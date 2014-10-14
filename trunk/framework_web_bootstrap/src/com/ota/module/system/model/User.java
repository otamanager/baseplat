package com.ota.module.system.model;

import java.util.Iterator;
import java.util.List;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Db;
import com.ota.base.Constant;
import com.ota.common.model.easyui.DataGrid;
import com.ota.common.model.easyui.Form;
import com.ota.common.shiro.ShiroCache;
import com.ota.ext.ListUtil;
import com.ota.ext.Model;
import com.ota.ext.ShiroExt;
import com.ota.util.Sec;

@TableBind(tableName = "system_user")
public class User extends Model<User> {
	private static final long serialVersionUID = -7615377924993713398L;

	public static User dao = new User();

	/***
	 * 隐藏 id 1
	 */
	public DataGrid<User> listByDataGrid(DataGrid<User> dg, Form f) {
		dg = super.listByDataGrid(sql("system.user.list"), dg, f);
		Iterator<User> list = dg.rows.iterator();
		User now = ShiroExt.getSessionAttr(Constant.SESSION_USER);

		while (list.hasNext()) {
			User u = list.next();
			List<Role> role = Role.dao.getRole(u.getId());
			u.put("role_ids", ListUtil.listToString(role, "id"));
			u.put("role_names", ListUtil.listToString(role, "name"));
			if (u.getId() == 1 && now.getId() != 1)
				list.remove();
		}

		return dg;
	}

	public List<String> getRolesName(String loginName) {
		return getAttr(sql("system.role.getRolesName"), "name", loginName);
	}

	public boolean grant(Integer[] role_ids, Integer userId) {
		boolean result = Db.deleteById("system_user_role", "user_id", userId);

		if (role_ids == null)
			return result;

		Object[][] params = ListUtil.ArrayToArray(userId, role_ids);
		result = Db.batch("insert into system_user_role(user_id,role_id)  values(?,?)", params, role_ids.length).length > 0;

		ShiroCache.clearAuthorizationInfoAll();

		return result;
	}

	public User encrypt() {
		this.set("pwd", Sec.md5(this.getPwd()));
		return this;
	}

	public boolean batchGrant(Integer[] role_ids, String uids) {
		boolean result = Db.update("delete from system_user_role where user_id in (" + uids + ")") > 0;

		if (role_ids == null)
			return result;

		Object[][] params = ListUtil.ArrayToArray(uids, role_ids);

		result = Db.batch("insert into system_user_role(user_id,role_id)  values(?,?)", params, params.length).length > 0;

		ShiroCache.clearAuthorizationInfoAll();

		return result;
	}

}
