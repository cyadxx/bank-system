<template>
  <div>
    <el-row :gutter="30">
      <el-col :span="12">
        <el-card class="box-card" shadow="hover">
          <div slot="header" class="clearfix">
            <span>储蓄总金额 年视图</span>
            <el-button style="float: right; padding: 3px 0" type="text" @click="getSavingYearStat">刷新视图</el-button>
          </div>
          <ve-line :data="savingYearChartData" :data-zoom="savingYearDataZoom"></ve-line>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card class="box-card" shadow="hover">
          <div slot="header" class="clearfix">
            <span>储蓄总金额 季度视图</span>
            <el-button style="float: right; padding: 3px 0" type="text" @click="getSavingQuarterStat">刷新视图</el-button>
          </div>
          <ve-line :data="savingQuarterChartData" :data-zoom="savingQuarterDataZoom" :extend="savingQuarterExtend"></ve-line>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="30">
      <el-col :span="12">
        <el-card class="box-card" shadow="hover">
          <div slot="header" class="clearfix">
            <span>储蓄总金额 月视图</span>
            <el-button style="float: right; padding: 3px 0" type="text" @click="getSavingMonthStat">刷新视图</el-button>
          </div>
          <ve-line :data="savingMonthChartData" :data-zoom="savingMonthDataZoom" :extend="savingMonthExtend"></ve-line>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card class="box-card" shadow="hover">
          <div slot="header" class="clearfix">
            <span>支票总金额 年视图</span>
            <el-button style="float: right; padding: 3px 0" type="text" @click="getCheckingYearStat">刷新视图</el-button>
          </div>
          <ve-line :data="checkingYearChartData" :data-zoom="dataZoomDefault"></ve-line>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="30">
      <el-col :span="12">
        <el-card class="box-card" shadow="hover">
          <div slot="header" class="clearfix">
            <span>支票总金额 季度视图</span>
            <el-button style="float: right; padding: 3px 0" type="text" @click="getCheckingQuarterStat">刷新视图</el-button>
          </div>
          <ve-line :data="checkingQuarterChartData" :data-zoom="dataZoomDefault" :extend="extendDefault"></ve-line>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card class="box-card" shadow="hover">
          <div slot="header" class="clearfix">
            <span>支票总金额 月视图</span>
            <el-button style="float: right; padding: 3px 0" type="text" @click="getCheckingMonthStat">刷新视图</el-button>
          </div>
          <ve-line :data="checkingMonthChartData" :data-zoom="dataZoomDefault" :extend="extendDefault"></ve-line>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="30">
      <el-col :span="12">
        <el-card class="box-card" shadow="hover">
          <div slot="header" class="clearfix">
            <span>贷款总金额 年视图</span>
            <el-button style="float: right; padding: 3px 0" type="text" @click="getLoanYearStat">刷新视图</el-button>
          </div>
          <ve-line :data="loanYearChartData" :data-zoom="dataZoomDefault"></ve-line>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card class="box-card" shadow="hover">
          <div slot="header" class="clearfix">
            <span>贷款总金额 季度视图</span>
            <el-button style="float: right; padding: 3px 0" type="text" @click="getLoanQuarterStat">刷新视图</el-button>
          </div>
          <ve-line :data="loanQuarterChartData" :data-zoom="dataZoomDefault" :extend="extendDefault"></ve-line>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="30">
      <el-col :span="12">
        <el-card class="box-card" shadow="hover">
          <div slot="header" class="clearfix">
            <span>贷款总金额 月视图</span>
            <el-button style="float: right; padding: 3px 0" type="text" @click="getLoanMonthStat">刷新视图</el-button>
          </div>
          <ve-line :data="loanMonthChartData" :data-zoom="dataZoomDefault" :extend="extendDefault"></ve-line>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'CyaStat',
  data: function () {
    return {
      extendDefault: {
        'xAxis.0.axisLabel.rotate': 80
      },
      savingQuarterExtend: {
        'xAxis.0.axisLabel.rotate': 80
      },
      savingMonthExtend: {
        'xAxis.0.axisLabel.rotate': 80
      },
      dataZoomDefault: [{
        type: 'slider',
        start: 0,
        end: 100
      }],
      savingYearDataZoom: [{
        type: 'slider',
        start: 0,
        end: 100
      }],
      savingQuarterDataZoom: [{
        type: 'slider',
        start: 0,
        end: 100
      }],
      savingMonthDataZoom: [{
        type: 'slider',
        start: 0,
        end: 100
      }],
      savingYearChartData: {
        // columns: ['year', '上海支行', '东京支行', '乌鲁木齐支行', '北京支行', '南京支行', '合肥支行', '广州支行', '纽约支行', '青岛支行'],
        columns: [],
        rows: [
          // {'year': '2016', '合肥支行': 3123.0},
          // {'year': '2017', '合肥支行': 2222},
          // {'year': '2018', '合肥支行': 123.0},
          // {'year': '2019', '合肥支行': 3178},
          // {'year': '2020', '合肥支行': 982}
        ]
      },
      savingQuarterChartData: {
        columns: [],
        rows: [
          // {'quarter': '2019-1', '合肥支行': 2222},
          // {'quarter': '2019-2', '合肥支行': 123.0},
          // {'quarter': '2019-3', '合肥支行': 3178},
          // {'quarter': '2019-4', '合肥支行': 3123.0},
          // {'quarter': '2020-1', '合肥支行': 2222},
          // {'quarter': '2020-2', '合肥支行': 123.0},
          // {'quarter': '2020-3', '合肥支行': 3178},
          // {'quarter': '2020-4', '合肥支行': 982}
        ]
      },
      savingMonthChartData: {
        columns: [],
        rows: []
      },
      checkingYearChartData: {
        columns: [],
        rows: []
      },
      checkingQuarterChartData: {
        columns: [],
        rows: []
      },
      checkingMonthChartData: {
        columns: [],
        rows: []
      },
      loanYearChartData: {
        columns: [],
        rows: []
      },
      loanQuarterChartData: {
        columns: [],
        rows: []
      },
      loanMonthChartData: {
        columns: [],
        rows: []
      },
      chartData: {
        columns: ['年份', '合肥支行', '南京支行', '东京支行', '巴黎支行', '纽约支行'],
        rows: [
          { '年份': '2017', '合肥支行': 32371, '南京支行': 19810, '东京支行': 0, '巴黎支行': 0, '纽约支行': 0 },
          { '年份': '2018', '合肥支行': 12328, '南京支行': 4398, '东京支行': 0, '巴黎支行': 0, '纽约支行': 0 },
          { '年份': '2019', '合肥支行': 92381, '南京支行': 52910, '东京支行': 0, '巴黎支行': 0, '纽约支行': 0 }
        ]
      }
    }
  },
  methods: {
    getSavingYearStat: function () {
      let _this = this
      console.log('getSavingYearStat')
      this.$message('getSavingYearStat')
      axios.get('http://localhost:8000/api/account/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'account_type': 'saveaccount',
          'time_type': 'year'
        }
      }).then(function (response) {
        console.log('get yearly view of saving account:')
        console.log(response.data)
        _this.savingYearChartData.rows = response.data
        console.log('response.data[0] = ', response.data[0])
        _this.savingYearChartData.columns = Object.keys(response.data[0])
      }).catch(function (error) {
        console.log('get yearly view of saving account error:')
        console.log(error.response)
      })
    },
    getSavingQuarterStat: function () {
      let _this = this
      console.log('getSavingQuarterStat')
      this.$message('getSavingQuarterStat')
      axios.get('http://localhost:8000/api/account/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'account_type': 'saveaccount',
          'time_type': 'quarter'
        }
      }).then(function (response) {
        console.log('get quarterly view of saving account:')
        console.log(response.data)
        _this.savingQuarterChartData.rows = response.data
        _this.savingQuarterChartData.columns = Object.keys(response.data[0])
      }).catch(function (error) {
        console.log('get quarterly view of saving account error:')
        console.log(error.response)
      })
    },
    getSavingMonthStat: function () {
      let _this = this
      console.log('getSavingMonthStat')
      axios.get('http://localhost:8000/api/account/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'account_type': 'saveaccount',
          'time_type': 'month'
        }
      }).then(function (response) {
        console.log('get monthly view of saving account:')
        console.log(response.data)
        _this.savingMonthChartData.rows = response.data
        _this.savingMonthChartData.columns = Object.keys(response.data[0])
        console.log('_this.savingMonthChartData = ', _this.savingMonthChartData)
      }).catch(function (error) {
        console.log('get monthly view of saving account error:')
        console.log(error.response)
      })
    },
    getCheckingYearStat: function () {
      let _this = this
      console.log('getCheckingYearStat')
      axios.get('http://localhost:8000/api/account/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'account_type': 'checkaccount',
          'time_type': 'year'
        }
      }).then(function (response) {
        console.log('get yearly view of checking account:')
        console.log(response.data)
        _this.checkingYearChartData.rows = response.data
        _this.checkingYearChartData.columns = Object.keys(response.data[0])
      }).catch(function (error) {
        console.log('get yearly view of checking account error:')
        console.log(error.response)
      })
    },
    getCheckingQuarterStat: function () {
      let _this = this
      console.log('getCheckingQuarterStat')
      axios.get('http://localhost:8000/api/account/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'account_type': 'checkaccount',
          'time_type': 'quarter'
        }
      }).then(function (response) {
        console.log('get quarterly view of checking account:')
        console.log(response.data)
        _this.checkingQuarterChartData.rows = response.data
        _this.checkingQuarterChartData.columns = Object.keys(response.data[0])
      }).catch(function (error) {
        console.log('get quarterly view of checking account error:')
        console.log(error.response)
      })
    },
    getCheckingMonthStat: function () {
      let _this = this
      console.log('getCheckingMonthStat')
      axios.get('http://localhost:8000/api/account/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'account_type': 'checkaccount',
          'time_type': 'month'
        }
      }).then(function (response) {
        console.log('get monthly view of checking account:')
        console.log(response.data)
        _this.checkingMonthChartData.rows = response.data
        _this.checkingMonthChartData.columns = Object.keys(response.data[0])
      }).catch(function (error) {
        console.log('get monthly view of checking account error:')
        console.log(error.response)
      })
    },
    getLoanYearStat: function () {
      let _this = this
      console.log('getLoanYearStat')
      this.$message('getLoanYearStat')
      axios.get('http://localhost:8000/api/loan/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'func': 'stat',
          'time_type': 'year'
        }
      }).then(function (response) {
        console.log('get yearly view of loan:')
        console.log(response.data)
        _this.loanYearChartData.rows = response.data
        _this.loanYearChartData.columns = Object.keys(response.data[0])
      }).catch(function (error) {
        console.log('get yearly view of loan error:')
        console.log(error.response)
      })
    },
    getLoanQuarterStat: function () {
      let _this = this
      console.log('getLoanQuarterStat')
      axios.get('http://localhost:8000/api/loan/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'func': 'stat',
          'time_type': 'quarter'
        }
      }).then(function (response) {
        console.log('get quarterly view of loan:')
        console.log(response.data)
        _this.loanQuarterChartData.rows = response.data
        _this.loanQuarterChartData.columns = Object.keys(response.data[0])
      }).catch(function (error) {
        console.log('get quarterly view of loan error:')
        console.log(error.response)
      })
    },
    getLoanMonthStat: function () {
      let _this = this
      console.log('getLoanMonthStat')
      axios.get('http://localhost:8000/api/loan/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'func': 'stat',
          'time_type': 'month'
        }
      }).then(function (response) {
        console.log('get monthly view of loan:')
        console.log(response.data)
        _this.loanMonthChartData.rows = response.data
        _this.loanMonthChartData.columns = Object.keys(response.data[0])
      }).catch(function (error) {
        console.log('get monthly view of loan error:')
        console.log(error.response)
      })
    }
  },
  mounted: function () {
    this.getSavingYearStat()
    console.log('savingYearChartData = ', this.savingYearChartData)
    this.getSavingQuarterStat()
    console.log('savingQuarterChartData = ', this.savingQuarterChartData)
    this.getSavingMonthStat()
    this.getCheckingYearStat()
    this.getCheckingQuarterStat()
    this.getCheckingMonthStat()
    this.getLoanYearStat()
    this.getLoanQuarterStat()
    this.getLoanMonthStat()
  }
}
</script>

<style scoped>
.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}

.clearfix:after {
  clear: both
}

.el-row {
  margin-bottom: 20px;
}

.el-card {
  border-radius: 25px;
}

.ve-line {
  height: auto; /* 调节该值可以调节 card 的高度，默认为 400 px */
}
</style>
