import request from '@/utils/request'
var bpath = '<#if package.ModuleName??>/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>'
export function fetchPage(query) {
  return request({
    url: bpath + '/page',
    method: 'post',
    data: query
  })
}

export function fetchInfo(id) {
  return request({
    url: bpath + '/detail/' + id,
    method: 'post'
  })
}

export function fetchAll(query) {
  return request({
    url: bpath + '/list',
    method: 'post',
    data: query
  })
}

export function create(data) {
  return request({
    url: bpath + '/save',
    method: 'post',
    data
  })
}

export function update(data) {
  return request({
    url: bpath + '/update',
    method: 'post',
    data
  })
}

export function delById(id) {
    return request({
        url: bpath + '/delete',
        method: 'post',
        data: { id: id }
    })
}
