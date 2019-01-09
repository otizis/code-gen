<template>
  <${entity}Detail :is-edit="true"/>
</template>

<script>
import ${entity}Detail from './components/${entity}Detail'

export default {
  name: 'EditForm',
  components: { ${entity}Detail }
}
</script>

