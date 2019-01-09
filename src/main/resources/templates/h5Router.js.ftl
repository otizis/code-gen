/** When your routing table is too long, you can split it into small modules**/

import Layout from '@/views/layout/Layout'

const ${table.entityPath}Router = {
  path: '/${table.entityPath}',
  component: Layout,
  redirect: '/${table.entityPath}/list${entity}',
  name: '${table.entityPath}Mng',
  meta: {title: '${table.comment!}管理', permission: '${table.entityPath}Mng'},
  children: [
    {
      path: 'create${entity}',
      component: () => import('@/views/${table.entityPath}Mng/create'),
      name: 'Create${entity}',
      meta: { title: '新增${table.comment!}', permission: '${table.entityPath}Create' },
      hidden: true
    },
    {
      path: 'edit${entity}/:id(\\d+)',
      component: () => import('@/views/${table.entityPath}Mng/edit'),
      name: 'Edit${entity}',
      meta: { title: '修改${table.comment!}', permission: '${table.entityPath}Edit', noCache: true },
      hidden: true
    },
    {
      path: 'list${entity}',
      component: () => import('@/views/${table.entityPath}Mng/list'),
      name: 'Page${entity}',
      meta: {title: '${table.comment!}列表', permission: '${table.entityPath}List', noCache: true, icon: 'list', 'keep-alive': true}
    }
  ]
}

export default ${table.entityPath}Router
