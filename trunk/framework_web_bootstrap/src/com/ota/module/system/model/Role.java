package com.ota.module.system.model;

import java.util.ArrayList;
import java.util.List;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Db;
import com.ota.common.model.easyui.Tree;
import com.ota.common.shiro.ShiroCache;
import com.ota.ext.ListUtil;
import com.ota.ext.Model;
import com.ota.util.Validate;

@TableBind(tableName = "system_role")
public class Role extends Model<Role> {
	private static final long serialVersionUID = -5747359745192545106L;
	public static Role dao = new Role();

	public List<String> getResUrl(String name) {
		return Res.dao.getAttr(sql("system.res.getResUrl"), "url", name);

	}

	public List<Role> getRole(int uid) {
		return Role.dao.find(sql("system.role.getRole"), uid);
	}

	@Override
	public List<Role> list() {
		List<Role> list = Role.dao.find(sql("system.role.list"));

		for (Role r : list) {
			List<Res> res = Res.dao.getRes(r.getId());
			r.put("res_ids", ListUtil.listToString(res, "id"));
			r.put("res_names", ListUtil.listToString(res, "name"));
		}

		return list;
	}

	public List<Tree> getTree(int id) {
		// 根据用户角色来获取 列表
		List<Tree> trees = new ArrayList<Tree>();

		for (Role res : getChild(id)) {
			Tree tree = new Tree(res.getId(), res.getPid(), res.getName(), res.getIconCls(), res, false);

			tree.children = getTree(res.getId());
			if (tree.children.size() > 0)
				tree.changeState();

			trees.add(tree);
		}
		return trees;
	}

	public List<Role> getChild(int id) {
		return dao.find(sql("system.role.getChild"), id);

	}

	public boolean grant(int roleId, String resIds) {
		boolean result = Db.deleteById("system_role_res", "role_id", roleId);
		if (!Validate.isEmpty(resIds))
			result = Res.dao.batchAdd(roleId, resIds);

		ShiroCache.clearAuthorizationInfoAll();

		return result;
	}

}
