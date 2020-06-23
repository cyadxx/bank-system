<template>
  <div>
    <el-table
      :data="tableData"
      style="width: 100%">
      <el-table-column
        prop="staff_id"
        label="员工号"
        width="200">
      </el-table-column>
      <el-table-column
        prop="staff_name"
        label="姓名"
        width="130">
      </el-table-column>
      <el-table-column
        prop="staff_phone"
        label="手机号"
        width="180">
      </el-table-column>
      <el-table-column
        prop="staff_address"
        label="家庭住址"
        width="180">
      </el-table-column>
      <el-table-column
        prop="staff_starttime"
        label="入职日期"
        width="200">
      </el-table-column>
      <el-table-column
        prop="staff_ismanager"
        label="是不是经理"
        width="130">
      </el-table-column>
      <el-table-column
        prop="department_department"
        label="所属部门">
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'CyaStaff',
  data: function () {
    return {
      tableData: []
    }
  },
  mounted: function () {
    let _this = this
    axios.request({
      url: 'http://localhost:8000/api/staff/',
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
