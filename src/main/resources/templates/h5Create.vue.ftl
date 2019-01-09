<template>
  <${entity}Detail :is-edit="false"/>
</template>

<script>
import ${entity}Detail from './components/${entity}Detail'

export default {
  name: 'CreateForm',
  components: { ${entity}Detail }
}
</script>

