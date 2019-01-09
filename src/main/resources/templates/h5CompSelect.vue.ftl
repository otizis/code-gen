<template>
    <el-select
        :value="value"
        :multiple="multiple"
        :placeholder="text"
        style="width:100%"
        clearable
        @change="change">
        <el-option
                v-for="item in options"
                :key="item.id"
                :label="item.name"
                :value="item.id"/>
    </el-select>
</template>
<script>
    import { fetchAll } from '@/api/${table.entityPath}'
    export default {
        name: '${entity}SelectComp',
        props: {
            value: {
                type: [Array, Number, String],
                default: null
            },
            multiple: {
                type: Boolean,
                default: false
            },
            text: {
                type: String,
                default: '请选择'
            }
        },
        data() {
            return {
                options: []
            }
        },
        created() {
            fetchAll({}).then(resp => {
                this.options = resp.list
        })
        },
        methods: {
            change(val) {
                this.$emit('input', val)
            }
        }
    }
</script>

