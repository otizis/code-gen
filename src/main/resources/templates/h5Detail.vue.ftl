<template>
  <div class="createPost-container">
    <el-form ref="postForm" :model="postForm" :rules="rules" class="form-container">

      <sticky :class-name="'sub-navbar '+postForm.status">
        <el-button v-loading="loading" style="margin-left: 10px;" @click="$router.go(-1)">返回</el-button>
        <el-button v-loading="loading" style="margin-left: 10px;" type="success" @click="submitForm">提交</el-button>
      </sticky>

      <div class="createPost-main-container">

        <div class="postInfo-container">
          <#list table.fields as field>
          <el-row>
            <el-col :span="8">
              <el-form-item style="margin-bottom: 40px;" prop="${field.propertyName}" label="${field.comment}">
                <el-input v-model="postForm.${field.propertyName}" />
              </el-form-item>
            </el-col>
          </el-row>
          </#list>

        </div>

      </div>
    </el-form>

  </div>
</template>

<script>
import Sticky from '@/components/Sticky' // 粘性header组件

import { fetchInfo, create, update } from '@/api/${table.entityPath}'

const defaultForm = {
<#list table.fields as field>
  ${field.propertyName} : '', //${field.comment}
</#list>
}

export default {
  name: '${entity}Detail',
  components: { Sticky },
  props: {
    isEdit: {
      type: Boolean,
      default: false
    }
  },
  data() {
    const validateRequire = (rule, value, callback) => {
      if (value === '') {
        this.$message({
          message: rule.field + '为必传项',
          type: 'error'
        })
        callback(new Error(rule.field + '为必传项'))
      } else {
        callback()
      }
    }
    return {
      postForm: Object.assign({}, defaultForm),
      loading: false,
      userListOptions: [],
      rules: {
        <#list table.fields as field>
          ${field.propertyName}: [{ validator: validateRequire }],
        </#list>
      }
    }
  },
  computed: {
    lang() {
      return this.$store.getters.language
    }
  },
  created() {
    if (this.isEdit) {
      const id = this.$route.params && this.$route.params.id
      this.fetchData(id)
    } else {
      this.postForm = Object.assign({}, defaultForm)
    }
  },
  methods: {
    fetchData(id) {
      fetchInfo(id).then(response => {
        this.postForm = response.entity

        // Set tagsview title
        this.setTagsViewTitle()
      }).catch(err => {
        console.log(err)
      })
    },
    setTagsViewTitle() {
      const title = this.lang === 'zh' ? '修改' : 'Edit'
      const route = Object.assign({}, this.$route, { title: title + '-' + this.postForm.id })
      this.$store.dispatch('updateVisitedView', route)
    },
    submitForm() {
      console.log(this.postForm)
      this.$refs.postForm.validate(valid => {
        if (valid) {
          this.loading = true
          var result = this.isEdit ? update(this.postForm) : create(this.postForm)
          result.then(resp => {
            this.$notify({
              title: '成功',
              message: '创建成功',
              type: 'success',
              duration: 2000
            })
            this.$router.go(-1)
          }).catch(err => {
            console.log(err)
          })
          this.loading = false
        } else {
          console.log('error submit!!')
          return false
        }
      })
    }
  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
@import "src/styles/mixin.scss";
.createPost-container {
  position: relative;
  .createPost-main-container {
    padding: 40px 45px 20px 50px;
    .postInfo-container {
      position: relative;
      @include clearfix;
      margin-bottom: 10px;
      .postInfo-container-item {
        float: left;
      }
    }
    .editor-container {
      min-height: 500px;
      margin: 0 0 30px;
      .editor-upload-btn-container {
        text-align: right;
        margin-right: 10px;
        .editor-upload-btn {
          display: inline-block;
        }
      }
    }
  }
  .word-counter {
    width: 40px;
    position: absolute;
    right: -10px;
    top: 0px;
  }
}
</style>
