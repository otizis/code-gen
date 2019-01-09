package ${package.Controller};

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import ${package.Entity}.${entity};
import ${package.Service}.${table.serviceName};
import com.code5a.customer.common.beans.R;
import com.code5a.customer.common.beans.NeedLogin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
<#if restControllerStyle>
import org.springframework.web.bind.annotation.RestController;
<#else>
import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
import ${superControllerClassPackage};
</#if>

/**
 * <p>
 * ${table.comment!} 前端控制器
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if restControllerStyle>
@RestController
<#else>
@Controller
</#if>
@RequestMapping("<#if package.ModuleName??>/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")
<#if kotlin>
class ${table.controllerName}<#if superControllerClass??> : ${superControllerClass}()</#if>
<#else>
<#if superControllerClass??>
public class ${table.controllerName} extends ${superControllerClass} {
<#else>
public class ${table.controllerName} {
</#if>
    @Autowired
    private ${table.serviceName} entityService;


    /**
     * 分页
     */
    @PostMapping("/page")
    @NeedLogin
    public R page(@RequestBody Map map)
    {
        int pageNo = (int)map.get("pageNo");
        int size = (int)map.get("size");

        IPage<${entity}> pageResult = entityService.page(new Page<>(pageNo, size), new QueryWrapper<>());

        return R.ok().put("page", pageResult);
    }


    /**
     * 列表
     */
    @PostMapping("/list")
    @NeedLogin
    public R list(@RequestBody ${entity} entity)
    {
        return R.ok().put("list", entityService.list(new QueryWrapper<>(entity)));
    }


    /**
     * 信息
     */
    @PostMapping("/detail/{id}")
    @NeedLogin
    public R detail(@PathVariable("id") Integer id)
    {
        ${entity} entity = entityService.getById(id);
        return R.ok().put("entity", entity);
    }


    /**
     * 保存
     */
    @PostMapping("/save")
    @NeedLogin
    public R save(@RequestBody ${entity} entity)
    {
        if(entityService.save(entity))
        {
            return R.ok();
        }
        return R.error();
    }

    /**
     * 修改
     */
    @PostMapping("/update")
    @NeedLogin
    public R update(@RequestBody ${entity} entity)
    {
        if(entityService.updateById(entity))
        {
            return R.ok();
        }
        return R.error();
    }

    /**
     * 删除
     */
    @PostMapping("/delete")
    @NeedLogin
    public R delete(@RequestBody ${entity} entity)
    {
        if(entityService.removeById(entity.getId()))
        {
            return R.ok();
        }
        return R.error();
    }

}
</#if>
