<template>
  <div>
    <el-table
      :data="tableData"
      style="width: 90%">
      <el-table-column
        prop="account_id"
        label="账户号"
        width="100">
      </el-table-column>
      <el-table-column
        prop="account_balance"
        label="账户余额"
        width="130">
      </el-table-column>
      <el-table-column
        prop="account_opendate"
        label="开户日期"
        width="250">
      </el-table-column>
      <el-table-column
        prop="account_type"
        label="账户类型"
        width="180">
      </el-table-column>
      <el-table-column
        prop="staff_staff"
        label="负责员工"
        width="250">
      </el-table-column>
      <el-table-column
        prop="branch_branch_name"
        label="所属支行">
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'CyaAccount',
  data: function () {
    return {
      tableData: []
    }
  },
  mounted: function () {
    let _this = this
    axios.request({
      url: 'http://localhost:8000/api/account/',
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
