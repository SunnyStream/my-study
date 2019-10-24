package com.study.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.study.MyConstant;
import com.study.mapper.ProjectMapper;
import com.study.model.ProjectModel;
import com.study.result.PageParam;
import com.study.result.PageResult;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * <p>
 * 项目（如公司里某个项目） 服务实现类
 * </p>
 *
 * @author wsm
 * @since 2019-07-16
 */
@Service
public class ProjectService extends ServiceImpl<ProjectMapper, ProjectModel> {

    @Autowired
    private ProjectMapper projectMapper;

    public PageResult getPage(PageParam pageParam) {
        int pageIndex = pageParam.getPageIndex();
        int pageSize = pageParam.getPageSize();
//        int pageStart = pageParam.getPageStart();
        String sort = pageParam.getSort();
        JSONObject object = new JSONObject(pageParam.getCondition());
        String name = object.getString("name").trim();
        String code = object.getString("code");
        String regionId = object.getString("regionId");
        String isEnable = object.getString("isEnable");

        QueryWrapper qw = new QueryWrapper();
        if (!StringUtils.isEmpty(name)) {
            qw.like("name", name);
        }
        if (!StringUtils.isEmpty(code)) {
            qw.eq("code", code);
        }
        if (!StringUtils.isEmpty(regionId)) {
            qw.eq("region_id", regionId);
        }
        if (!StringUtils.isEmpty(isEnable)) {
            qw.eq("isEnable", isEnable);
        }
//        if (!StringUtils.isEmpty(sort)) {
//            qw.orderBy(sort,false);
//        }

        Page page = new Page();
        int total = 0;
        if (pageIndex != MyConstant.Zero && pageSize != MyConstant.Zero) {
            page = new Page(pageIndex, pageSize);
            total = projectMapper.selectCount(qw);
        }
        List records = projectMapper.selectPage(page, qw).getRecords();
        PageResult pageResult = new PageResult(pageIndex, pageSize, total, records);
        return pageResult;
    }
}
