package com.study.controller;


import com.study.currency.result.PageParam;
import com.study.currency.result.PageResult;
import com.study.currency.result.ResultView;
import com.study.currency.utils.CreateUtil;
import com.study.model.RecruitPlatformModel;
import com.study.service.RecruitPlatformService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONException;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * <p>
 * 招聘平台表 前端控制器
 * </p>
 *
 * @author wsm123
 * @since 2019-02-28
 */
@Api(description = "招聘平台控制器")
@RestController
@RequestMapping("/recruitPlatform")
public class RecruitPlatformController {

    @Autowired
    private RecruitPlatformService recruitPlatformService;

    @ApiOperation(value = "查询全部", notes = "")
    @GetMapping("/getAll")
    public ResultView getAll() {
        List<RecruitPlatformModel> models = recruitPlatformService.selectList(null);
        return ResultView.success(models);
    }

    @ApiOperation(value = "分页条件查询", notes = "提交参数：{\"pageIndex\":1,\"pageSize\":10,\"sort\":\"name desc\",\"condition\":\"{\'name\':\'\',\'isEnable\':\'\'}\"}")
    @PostMapping("/getPage")
    public ResultView getPage(@RequestBody PageParam pageParam) throws JSONException {
        PageResult pageResult = recruitPlatformService.getPage(pageParam);
        return ResultView.success(pageResult);
    }

    @ApiOperation(value = "根据id查询", notes = "")
    @GetMapping("/getById/{id}")
    public ResultView getById(@PathVariable Long id) {
        RecruitPlatformModel model = recruitPlatformService.selectById(id);
        return ResultView.success(model);
    }

    @ApiOperation(value = "新增", notes = "")
    @PostMapping("/add")
    public ResultView add(@RequestBody RecruitPlatformModel model) {
        Date date = new Date();
        model.setId(CreateUtil.id());
        model.setCreateTime(date);
        model.setUpdateTime(date);
        recruitPlatformService.insert(model);
        return ResultView.success(model);
    }

    @ApiOperation(value = "修改", notes = "")
    @PostMapping("/update")
    public ResultView update(@RequestBody RecruitPlatformModel model) {
        Date date = new Date();
        model.setUpdateTime(date);
        recruitPlatformService.updateById(model);
        return ResultView.success(model);
    }

    @ApiOperation(value = "根据id删除", notes = "")
    @DeleteMapping("/deleteById/{id}")
    public ResultView deleteById(@PathVariable Long id) {
        recruitPlatformService.deleteById(id);
        return ResultView.success();
    }

    @ApiOperation(value = "根据ids删除", notes = "")
    @DeleteMapping("/deleteByIds")
    public ResultView deleteByIds(@RequestParam Long[] ids) {
        recruitPlatformService.deleteBatchIds(Arrays.asList(ids));
        return ResultView.success();
    }
}

