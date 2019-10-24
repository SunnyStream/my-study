package com.study.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.study.MyConstant;
import com.study.mapper.RoleMapper;
import com.study.model.RoleModel;
import com.study.result.PageParam;
import com.study.result.PageResult;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * <p>
 * 角色 服务实现类
 * </p>
 *
 * @author wsm
 * @since 2019-07-18
 */
@Service
public class RoleService extends ServiceImpl<RoleMapper, RoleModel> {

    @Autowired
    private RoleMapper roleMapper;

    public PageResult getPage(PageParam pageParam) {
        int pageIndex = pageParam.getPageIndex();
        int pageSize = pageParam.getPageSize();
//        int pageStart = pageParam.getPageStart();
        String sort = pageParam.getSort();
        JSONObject object = new JSONObject(pageParam.getCondition());
        String name = object.getString("name").trim();
        String code = object.getString("code");
        String projectId = object.getString("projectId");
        String isEnable = object.getString("isEnable");

        QueryWrapper qw = new QueryWrapper();
        if (!StringUtils.isEmpty(name)) {
            qw.like("name", name);
        }
        if (!StringUtils.isEmpty(code)) {
            qw.eq("code", code);
        }
        if (!StringUtils.isEmpty(projectId)) {
            qw.eq("project_id", projectId);
        }
        if (!StringUtils.isEmpty(isEnable)) {
            qw.eq("isEnable", isEnable);
        }
//        if (!StringUtils.isEmpty(sort)) {
//            qw.orderBy(sort);
//        }

        Page page = new Page();
        int total = 0;
        if (pageIndex != MyConstant.Zero && pageSize != MyConstant.Zero) {
            page = new Page(pageIndex, pageSize);
            total = roleMapper.selectCount(qw);
        }
        List records = roleMapper.selectPage(page, qw).getRecords();
        PageResult pageResult = new PageResult(pageIndex, pageSize, total, records);
        return pageResult;
    }
}
