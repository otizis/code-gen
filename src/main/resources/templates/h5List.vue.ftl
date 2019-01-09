<template>
  <div class="app-container">
      <el-row style="padding-bottom:30px">
          <el-col>
              <router-link :to="'/${table.entityPath}/create${entity}/'">
                  <el-button type="primary" size="small" icon="el-icon-plus">新增</el-button>
              </router-link>
          </el-col>
      </el-row>
    <el-table v-loading="listLoading" :data="list" border fit highlight-current-row style="width: 100%">
<#list table.fields as field>
      <el-table-column align="center" label="${field.comment}">
        <template slot-scope="scope">
          <span>{{ scope.row.${field.propertyName} }}</span>
        </template>
      </el-table-column>
</#list>
    <el-table-column align="center" label="操作" width="120">
      <template slot-scope="scope">
        <router-link :to="'/${table.entityPath}/edit${entity}/'+scope.row.id">
          <el-button type="primary" size="small" icon="el-icon-edit">编辑</el-button>
        </router-link>
      </template>
    </el-table-column>
    </el-table>

    <div class="pagination-container">
      <el-pagination
        :current-page="listQuery.pageNo"
        :page-sizes="[10, 20, 30, 50]"
        :page-size="listQuery.size"
        :total="total"
        background
        layout="total, sizes, prev, pager, next, jumper"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"/>
    </div>

  </div>
</template>

<script>
import { fetchPage, delById } from '@/api/${table.entityPath}'

export default {
  name: '${entity}List',
  filters: {
  },
  data() {
    return {
      list: null,
      total: 0,
      listLoading: true,
      listQuery: {
        pageNo: 1,
        size: 20
      }
    }
  },
  created() {
    this.getList()
  },
  activated() {
    this.getList()
  },
  methods: {
    getList() {
      this.listLoading = true
      fetchPage(this.listQuery).then(response => {
        this.list = response.page.records
        this.total = response.page.total
        this.listLoading = false
      })
    },
    handleSizeChange(val) {
      this.listQuery.size = val
      this.getList()
    },
    handleCurrentChange(val) {
      this.listQuery.pageNo = val
      this.getList()
    },
      delItem(item) {
          this.$confirm('是否删除？')
                  .then(_ => {
              return delById(item.id)
          })
          .then(resp => {
                  if (resp.code === 0) {
                  this.getList()
              }
          })
    }
  }
}
</script>

<style scoped>
.edit-input {
  padding-right: 100px;
}
.cancel-btn {
  position: absolute;
  right: 15px;
  top: 10px;
}
</style>
