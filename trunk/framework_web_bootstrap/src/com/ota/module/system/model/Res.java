package com.ota.module.system.model;

import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Db;
import com.ota.common.model.easyui.Tree;
import com.ota.ext.ListUtil;
import com.ota.ext.Model;
import com.ota.ext.ShiroExt;

@TableBind(tableName = "system_res")
public class Res extends Model<Res> {
	private static final long serialVersionUID = 9204284399513186930L;

	public static Res dao = new Res();

	/**
	 * type define
	 */
	public static int TYPE_MEUE = 1;
	public static final int TYPE_PERMISSION = 2;

	/**
	 * 转化为 easyui Tree 对象
	 * 
	 * @param type
	 * 
	 * @return
	 */
	public List<Tree> getTree(int id, int type) {
		// 根据用户角色来获取 列表
		List<Tree> trees = new ArrayList<Tree>();

		for (Res res : getChild(id, type)) {
			Tree tree = new Tree(res.getId(), res.getPid(), res.getName(), res.getIconCls(), res, false);

			tree.children = getTree(res.getId(), type);
			if (tree.children.size() > 0)
				tree.changeState();

			trees.add(tree);
		}

		return trees;
	}

	public List<String> getUrls() {
		return dao.getAttr(sql("system.res.getUrls"), "url");
	}

	public List<Res> getChild(int id, int type) {
		ShiroExt ext = new ShiroExt();
		List<Res> list = null;

		if (type == TYPE_MEUE)
			list = dao.find(sql("system.res.getChildAndType"), id, type);
		else if (type == TYPE_PERMISSION)
			list = dao.find(sql("system.res.getChild"), id);

		if (id == 0)
			return list;
		else if (TYPE_PERMISSION == type)
			return list;
		else {
			ListIterator<Res> itor = list.listIterator();
			while (itor.hasNext()) {
				Res r = itor.next();
				if (r.getStr("url") == null)
					continue;
				if (!ext.hasPermission(r.getStr("url")))
					itor.remove();
			}
		}

		return list;
	}

	/***
	 * 通过 role id 获得 res
	 * 
	 * @param r
	 * @return
	 */
	public List<Res> getRes(int id) {
		return dao.find(sql("system.res.getRes"), id);

	}

	public boolean batchAdd(int roleId, String resIds) {
		Object[][] params = ListUtil.stringToArray(roleId, resIds);

		Db.batch("insert into system_role_res(role_id,res_id)  values(?,?)", params, params.length);

		return true;
	}

}
