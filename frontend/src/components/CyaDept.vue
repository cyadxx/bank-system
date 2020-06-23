<template>
  <div>
    <el-table
      :data="tableData"
      style="width: 70%">
      <el-table-column
        prop="department_id"
        label="部门号"
        width="100">
      </el-table-column>
      <el-table-column
        prop="department_name"
        label="部门名"
        width="180">
      </el-table-column>
      <el-table-column
        prop="department_type"
        label="部门类型"
        width="130">
      </el-table-column>
      <el-table-column
        prop="manager_id"
        label="部门经理身份证号"
        width="300">
      </el-table-column>
      <el-table-column
        prop="branch_branch_name"
        label="所属支行名">
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'CyaDept',
  data: function () {
    return {
      tableData: []
    }
  },
  mounted: function () {
    let _this = this
    axios.request({
      url: 'http://localhost:8000/api/department/',
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    }).then(function (response) {
      console.log(response.data)
      console.log('type:', typeof (response.data))
      _this.tableData = response.data
    })
  }
}
</script>

<style scoped>

</style>
