<template>
  <div>
    <el-table
      :data="tableData"
      style="width: 70%">
      <el-table-column
        prop="branch_name"
        label="支行名"
        width="180">
      </el-table-column>
      <el-table-column
        prop="branch_assets"
        label="支行资产"
        width="180">
      </el-table-column>
      <el-table-column
        prop="branch_city"
        label="所在城市">
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'CyaBranch',
  data: function () {
    return {
      tableData: [{
        branch_name: '2016-05-02',
        branch_assets: '王小虎',
        branch_city: '上海市普陀区金沙江路 1518 弄'
      }, {
        branch_name: '2016-05-04',
        branch_assets: '王小虎',
        branch_city: '上海市普陀区金沙江路 1517 弄'
      }, {
        branch_name: '2016-05-01',
        branch_assets: '王小虎',
        branch_city: '上海市普陀区金沙江路 1519 弄'
      }]
    }
  },
  mounted: function () {
    let _this = this
    axios.request({
      url: 'http://localhost:8000/api/branch/',
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
