<template>
  <div>
    <el-table
      :data="tableData"
      style="width: 70%">
      <el-table-column
        prop="loan_id"
        label="贷款号"
        width="100">
      </el-table-column>
      <el-table-column
        prop="loan_money"
        label="贷款金额"
        width="130">
      </el-table-column>
      <el-table-column
        prop="loan_state"
        label="贷款状态"
        width="130">
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
  name: 'CyaLoan',
  data: function () {
    return {
      tableData: []
    }
  },
  mounted: function () {
    let _this = this
    axios.request({
      url: 'http://localhost:8000/api/loan/',
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
