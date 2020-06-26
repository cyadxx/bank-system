<template>
  <div>
    <el-row>
      <el-table
        :data="accTableData"
        style="width: 100%">
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
          width="150">
        </el-table-column>
        <el-table-column
          prop="staff_staff"
          label="负责员工"
          width="220">
        </el-table-column>
        <el-table-column
          prop="branch_branch_name"
          label="所属支行"
          width="140">
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
              size="mini" plain
              @click="handleViewDetail(scope.$index, scope.row)">详情</el-button>
            <el-button
              size="mini"
              type="primary" plain
              @click="handleEdit(scope.$index, scope.row)">修改</el-button>
            <el-button
              size="mini"
              type="danger" plain
              @click="handleDelete(scope.$index, scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-row>
    <el-row><h3>添加新账户</h3></el-row>
    <el-row>
      <el-form :inline="true" :model="addAccountForm" :rules="addAccountRules" ref="addAccountForm" label-width="95px" class="demo-form-inline">
        <el-row>
          <el-form-item label="账户类型" prop="account_type">
            <el-select v-model="addAccountForm.account_type" placeholder="请选择账户类型">
              <el-option
                v-for="item in typeOptions"
                :key="item.type"
                :label="item.type_name"
                :value="item.type">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="利率" prop="interset_rate" v-if="!intersetRateDisabled">
            <el-input type="number" v-model.number="addAccountForm.interset_rate"
              placeholder="利率" :disabled="intersetRateDisabled">
            </el-input>
          </el-form-item>
          <el-form-item label="货币类型" prop="currency_type" v-if="!currencyTypeDisabled">
            <el-input v-model="addAccountForm.currency_type" placeholder="货币类型"
              :disabled="currencyTypeDisabled">
            </el-input>
          </el-form-item>
          <el-form-item label="透支额" prop="credit_line" v-if="!creditLineDisabled">
            <el-input type="number" v-model.number="addAccountForm.credit_line"
              placeholder="透支额" :disabled="creditLineDisabled">
            </el-input>
          </el-form-item>
        </el-row>
        <el-row>
          <el-form-item label="账户号" prop="account_id">
            <el-input v-model="addAccountForm.account_id" placeholder="账户号"></el-input>
          </el-form-item>
          <el-form-item label="账户余额" prop="account_balance">
            <el-input type="number" v-model.number="addAccountForm.account_balance" placeholder="账户余额"></el-input>
          </el-form-item>
          <el-form-item label="开户日期" prop="account_opendate">
            <el-date-picker
              v-model="addAccountForm.account_opendate"
              type="datetime"
              value-format="yyyy-MM-dd HH:mm:ss"
              :picker-options="pickerOptions"
              placeholder="请选择开户日期">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="所属支行" prop="branch_branch_name">
            <el-select v-model="addAccountForm.branch_branch_name" placeholder="请选择所属支行" @change="branchChanged">
              <el-option
                v-for="item in brOptions"
                :key="item.branch_name"
                :label="item.branch_name"
                :value="item.branch_name">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="负责员工" prop="staff_staff">
            <el-select v-model="addAccountForm.staff_staff" :disabled="staffDis" :placeholder="staffDis ? '请先选择支行' : '请选择负责员工'">
              <el-option
                v-for="item in staffOptions"
                :key="item.staff_id"
                :label="item.staff_name"
                :value="item.staff_id">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="账户所有者" prop="customer_id_list">
            <el-select v-model="addAccountForm.customer_id_list" multiple placeholder="请选择开户客户">
              <el-option
                v-for="item in customerOptions"
                :key="item.id"
                :label="item.custom_name"
                :value="item.id">
              </el-option>
            </el-select>
          </el-form-item>
        </el-row>
        <el-form-item class="button-right">
          <el-button type="primary" size="medium" @click="addAccountSubmit">开 户</el-button>
        </el-form-item>
      </el-form>
    </el-row>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'CyaAccount',
  data: function () {
    return {
      accTableData: [],
      staffDis: true,
      brOptions: [],
      staffOptions: [],
      customerOptions: [],
      typeOptions: [{
        type: 'saveaccount',
        type_name: '储蓄账户'
      }, {
        type: 'checkaccount',
        type_name: '支票账户'
      }],
      pickerOptions: {
        disabledDate: function (time) {
          return time.getTime() > Date.now()
        }
      },
      addAccountForm: {
        account_id: '',
        account_balance: '',
        account_type: '',
        account_opendate: '',
        branch_branch_name: '',
        staff_staff: '',
        customer_id_list: [], // 新增贷款表单中选择的开户客户。可以用 addAccountForm.splice(6, 1) 删除
        interset_rate: '',
        currency_type: '',
        credit_line: ''
      },
      addAccountRules: {
        account_id: [
          { required: true, message: '请输入账户号', trigger: 'change' },
          { min: 1, max: 6, message: '长度在 1 到 6 个字符', trigger: 'change' }
        ],
        account_balance: [
          { required: true, message: '请输入账户余额', trigger: 'change' },
          { type: 'number', message: '请不要输入除数字外的字符', trigger: 'change' }
        ],
        account_type: [
          { required: true, message: '请选择账户类型', trigger: 'change' }
        ],
        account_opendate: [
          { required: true, message: '请选择开户日期', trigger: 'change' }
        ],
        staff_staff: [
          { required: true, message: '请选择负责员工', trigger: 'change' }
        ],
        branch_branch_name: [
          { required: true, message: '请选择所属支行', trigger: 'change' },
          { validator: this.validateChooseBr, trigger: 'change' }
        ],
        customer_id_list: [
          { required: true, message: '请选则贷款客户', trigger: 'change' }
        ],
        interset_rate: [
          { required: !this.intersetRateDisabled, message: '请输入利率', trigger: 'change' },
          { type: 'number', message: '请不要输入除数字外的字符', trigger: 'change' },
          { validator: this.validateInterestRate, trigger: 'change' }
        ],
        currency_type: [
          { required: !this.currencyTypeDisabled, message: '请输入货币类型', trigger: 'change' },
          { min: 1, max: 10, message: '长度在 1 到 10 个字符', trigger: 'change' }
        ],
        credit_line: [
          { required: !this.creditLineDisabled, message: '请输入透支额', trigger: 'change' },
          { type: 'number', message: '请不要输入除数字外的字符', trigger: 'change' }
        ]
      }
    }
  },
  computed: {
    intersetRateDisabled: function () {
      if ((this.addAccountForm.account_type === '') || (this.addAccountForm.account_type === 'checkaccount')) {
        // 未选择账户类型或账户类型是支票账户时禁用
        return true
      } else if (this.addAccountForm.account_type === 'saveaccount') {
        return false
      } else {
        print('intersetRateDisabled error!')
        return true
      }
    },
    currencyTypeDisabled: function () {
      return this.intersetRateDisabled
    },
    creditLineDisabled: function () {
      if ((this.addAccountForm.account_type === '') || (this.addAccountForm.account_type === 'saveaccount')) {
        // 未选择账户类型或账户类型是支票账户时禁用
        return true
      } else if (this.addAccountForm.account_type === 'checkaccount') {
        return false
      } else {
        print('creditLineDisabled error!')
        return true
      }
    }
  },
  methods: {
    // 获取所有账户信息
    getAccountInfo: function (_this) {
      axios.get('http://localhost:8000/api/account/', {
        headers: {
          'Content-Type': 'application/json'
        }
      }).then(function (response) {
        console.log(response.data)
        console.log('type:', typeof (response.data))
        _this.accTableData = response.data
      }).catch(function (error) {
        console.log('get account info error:')
        console.log(error.response)
      })
    },
    // 获取所有支行信息
    getBrInfo: function (_this) {
      axios.get('http://localhost:8000/api/branch/', {
        headers: {
          'Content-Type': 'application/json'
        }
      }).then(function (response) {
        console.log('update branch selector:')
        console.log(response.data)
        _this.brOptions = response.data
      }).catch(function (error) {
        console.log('get branch info error:')
        console.log(error.response)
      })
    },
    // 获取所有客户信息
    getCustomerInfo: function (_this) {
      axios.get('http://localhost:8000/api/customer/', {
        headers: {
          'Content-Type': 'application/json'
        }
      }).then(function (response) {
        console.log('get all customer info:')
        console.log(response.data)
        _this.customerOptions = response.data
      }).catch(function (error) {
        console.log('get customer info error:')
        console.log(error.response)
      })
    },
    // 每次修改所选支行时调用
    branchChanged: function () {
      console.log('br change')
      this.addAccountForm.staff_staff = '' // 每次修改支行时将之前选择的员工清除
    },
    // 开户
    addAccountSubmit: function () {
      let _this = this
      console.log('add new account')
      console.log('this.addAccountForm', this.addAccountForm)

      this.$refs.addAccountForm.validate((valid) => {
        if (valid) {
          console.log('form is validated, send the request')
          axios.post('http://localhost:8000/api/account/', this.addAccountForm, { // 注意 addAccountForm 多了一个 customer_id_list
            headers: {
              'Content-Type': 'application/json'
            }
          }).then(function (response) {
            console.log('add new account suuccessfully:')
            console.log(response.data)
            _this.$message('添加新账户成功')
            _this.getAccountInfo(_this) // 更新account table
          }).catch(function (error) {
            console.log('post account info error:')
            console.log(error.response)
            _this.$alert(error.response.data.errmsg, '添加贷款出错')
          })
        } else {
          console.log('add account Submit error')
          this.$alert('请按照输入框下的提示输入正确的信息', '添加新账户出错')
          return false
        }
      })
    },
    validateChooseBr: function (rule, value, callback) {
      let _this = this
      console.log('validate choose br')
      if (value !== '') {
        axios.get('http://localhost:8000/api/staff/', {
          headers: {
            'Content-Type': 'application/json'
          },
          params: {
            'branch_name': this.addAccountForm.branch_branch_name
          }
        }).then(function (response) {
          console.log('update staff selector:')
          console.log(response.data)
          _this.staffOptions = response.data
        }).catch(function (error) {
          console.log('get staff info error:')
          console.log(error.response)
        })
        this.staffDis = false
      }
      callback()
    },
    validateInterestRate: function (rule, value, callback) {
      if ((value <= 0) || (value > 1)) {
        callback(new Error('利率必须在 0 和 1 之间'))
      } else {
        callback()
      }
    },
    handleViewDetail: function (index, row) {
      console.log('view account detail:')
      console.log('index = ', index, '    row = ', row)
    },
    handleEdit: function (index, row) {
      console.log('edit account info:')
      console.log('index = ', index, '    row = ', row)
    },
    handleDelete: function (index, row) {
      console.log('delete account:')
      console.log('index = ', index, '    row = ', row)
    }
  },
  mounted: function () {
    this.getAccountInfo(this)
    this.getBrInfo(this)
    this.getCustomerInfo(this)
  }
}
</script>

<style scoped>
.button-right {
  float: right;
}
</style>
