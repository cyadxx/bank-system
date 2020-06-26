<template>
  <div>
    <el-row>
      <el-table
        :data="tableData"
        style="width: 100%">
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
          label="所属支行"
          width="180">
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
              size="mini" plain
              @click="handleViewCus(scope.$index, scope.row)">查看贷款客户</el-button>
            <el-button
              size="mini"
              type="primary" plain
              @click="handleViewPayment(scope.$index, scope.row)">发放情况</el-button>
            <el-button
              size="mini"
              type="danger" plain
              :disabled="(scope.row.loan_state == '1') ? true : false"
              @click="handleDelete(scope.$index, scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-row>

    <el-row>
      <h3>添加贷款</h3>
    </el-row>
    <el-row>
      <el-form :inline="true" :model="addLoanForm" :rules="addLoanRules" ref="addLoanForm" label-width="90px" class="demo-form-inline">
        <el-form-item label="贷款号" prop="loan_id">
          <el-input v-model="addLoanForm.loan_id" placeholder="贷款号"></el-input>
        </el-form-item>
        <el-form-item label="贷款金额" prop="loan_money">
          <el-input type="number" v-model.number="addLoanForm.loan_money" placeholder="贷款金额"></el-input>
        </el-form-item>
        <el-form-item label="所属支行" prop="branch_branch_name">
          <el-select v-model="addLoanForm.branch_branch_name" placeholder="请选择所属支行" @change="branchChanged">
            <el-option
              v-for="item in brOptions"
              :key="item.branch_name"
              :label="item.branch_name"
              :value="item.branch_name">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="负责员工" prop="staff_staff">
          <el-select v-model="addLoanForm.staff_staff" :disabled="staffDis" :placeholder="staffDis ? '请先选择支行' : '请选择负责员工'">
            <el-option
              v-for="item in staffOptions"
              :key="item.staff_id"
              :label="item.staff_name"
              :value="item.staff_id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="贷款客户" prop="customer_id_list">
          <el-select v-model="addLoanForm.customer_id_list" multiple placeholder="请选择贷款客户">
            <el-option
              v-for="item in customerOptions"
              :key="item.id"
              :label="item.custom_name"
              :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item class="button-right">
          <el-button type="primary" size="medium" @click="addLoanSubmit">添加</el-button>
        </el-form-item>
      </el-form>
    </el-row>

    <!--点击“查看客户贷款”按钮的弹出框-->
    <el-dialog title="该贷款所属的客户信息" :visible.sync="customerDialogFormVisible" width="80%">
      <el-table
        :data="cusTableData"
        style="width: 100%">
        <el-table-column
          prop="custom_id"
          label="客户身份证号"
          width="200">
        </el-table-column>
        <el-table-column
          prop="custom_name"
          label="姓名"
          width="100">
        </el-table-column>
        <el-table-column
          prop="custom_phone"
          label="手机号"
          width="130">
        </el-table-column>
        <el-table-column
          prop="custom_address"
          label="家庭住址"
          width="160">
        </el-table-column>
        <el-table-column
          prop="contact_name"
          label="联系人姓名"
          width="100">
        </el-table-column>
        <el-table-column
          prop="contact_phone"
          label="联系人电话"
          width="140">
        </el-table-column>
        <el-table-column
          prop="contact_email"
          label="联系人邮箱"
          width="170">
        </el-table-column>
        <el-table-column
          prop="contact_custom_relation"
          label="二者关系">
        </el-table-column>
      </el-table>

      <div slot="footer" class="dialog-footer">
        <el-button @click="customerDialogFormVisible = false">关 闭</el-button>
      </div>
    </el-dialog>

    <!--点击“发放情况”按钮的弹出框-->
    <el-dialog title="该贷款的发放情况" :visible.sync="payDialogFormVisible" width="50%">
      <el-row>
        <el-table
          :data="payTableData"
          style="width: 100%">
          <el-table-column
            prop="loan_loan"
            label="贷款号"
            width="150">
          </el-table-column>
          <el-table-column
            prop="pay_id"
            label="付款号"
            width="150">
          </el-table-column>
          <el-table-column
            prop="pay_date"
            label="付款发放时间"
            width="300">
          </el-table-column>
          <el-table-column
            prop="pay_account"
            label="付款金额">
          </el-table-column>
        </el-table>
      </el-row>
      <el-row><h3>发放贷款</h3></el-row>
      <el-row>
        <el-form :inline="true" :model="addPayForm" :rules="addPayRules" ref="addPayForm" label-width="90px" class="demo-form-inline">
          <el-form-item label="付款号" prop="pay_id">
            <el-input v-model="addPayForm.pay_id" placeholder="付款号"></el-input>
          </el-form-item>
          <el-form-item label="付款金额" prop="pay_account">
            <el-input type="number" v-model.number="addPayForm.pay_account" placeholder="付款金额"></el-input>
          </el-form-item>
          <el-form-item label="付款时间" prop="pay_date">
            <el-date-picker
              v-model="addPayForm.pay_date"
              type="datetime"
              value-format="yyyy-MM-dd HH:mm:ss"
              :picker-options="pickerOptions"
              placeholder="请选择付款时间">
            </el-date-picker>
          </el-form-item>
          <el-form-item class="button-right">
            <el-button type="primary" size="medium" @click="payForLoan" :disabled="payButtonDisable">发放</el-button>
          </el-form-item>
        </el-form>
      </el-row>
    </el-dialog>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'CyaLoan',
  data: function () {
    return {
      tableData: [],
      cusTableData: [],
      payTableData: [],
      openLoanIndex: -1, // 当前被打开查看付款记录的贷款在 tableData 中的 index
      payButtonDisable: false,
      customerDialogFormVisible: false,
      payDialogFormVisible: false,
      staffDis: true,
      brOptions: [],
      staffOptions: [],
      customerOptions: [],
      pickerOptions: {
        disabledDate: function (time) {
          return time.getTime() > Date.now()
        }
      },
      addLoanForm: {
        loan_id: '',
        loan_money: 1000,
        loan_state: '0', // 默认是未发放
        staff_staff: '',
        branch_branch_name: '',
        customer_id_list: [] // 新增贷款表单中选择的贷款客户。可以用 addLoanForm.splice(5, 1) 删除
      },
      addLoanRules: {
        loan_id: [
          { required: true, message: '请输入贷款号', trigger: 'change' },
          { min: 1, max: 10, message: '长度在 1 到 10 个字符', trigger: 'change' }
        ],
        loan_money: [
          { required: true, message: '请输入贷款金额且不要输入除数字外的字符', trigger: 'change' },
          { type: 'number', message: '请不要输入除数字外的字符', trigger: 'change' }
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
        ]
      },
      addPayForm: {
        loan_loan: '',
        pay_id: '',
        pay_date: '',
        pay_account: ''
      },
      addPayRules: {
        pay_id: [
          { required: true, message: '请输入付款号', trigger: 'blur' },
          { min: 1, max: 4, message: '长度在 1 到 4 个字符', trigger: 'blur' },
          { validator: this.validatePayId, trigger: 'change' }
        ],
        pay_account: [
          { required: true, message: '请输入付款金额且不要输入除数字外的字符', trigger: 'blur' },
          { type: 'number', message: '请不要输入除数字外的字符', trigger: 'blur' },
          { validator: this.validatePayMoney, trigger: 'change' }
        ],
        pay_date: [
          { required: true, message: '请选择付款时间', trigger: 'blur' }
        ]
      }
    }
  },
  mounted: function () {
    let _this = this
    this.getLoanInfo(this) // 获取所有贷款信息
    // 获取所有支行信息
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
      console.log(error)
    })
    // 获取所有客户信息
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
      console.log(error)
    })
  },
  methods: {
    // 获取所有贷款信息并更新表格
    getLoanInfo: function (_this) {
      console.log('get all loan info:')
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
        if (_this.tableData[_this.openLoanIndex].loan_state === '2') {
          console.log('payButtonDisable = true')
          _this.payButtonDisable = true
        }
      }).catch(function (error) {
        console.log('get loan info error:')
        console.log(error.response)
      })
    },
    getPayInfo: function (_this) {
      console.log('get pay info:')
      axios.get('http://localhost:8000/api/pay/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'loan_id': this.tableData[this.openLoanIndex].loan_id
        }
      }).then(function (response) {
        console.log('get pay info:')
        console.log(response.data)
        _this.payTableData = response.data
      }).catch(function (error) {
        console.log('get pay info error:')
        console.log(error.response)
      })
    },
    // 提交新的贷款信息
    addLoanSubmit: function () {
      let _this = this
      console.log('add new loan')
      console.log('    loan_id: ', this.addLoanForm.loan_id)
      console.log('    loan_account: ', this.addLoanForm.loan_money)
      console.log('    typeof(loan_account): ', typeof (this.addLoanForm.loan_money))
      console.log('    loan_state: ', this.addLoanForm.loan_state)
      console.log('    branch: ', this.addLoanForm.branch_branch_name)
      console.log('    staff: ', this.addLoanForm.staff_staff)
      console.log('    customers: ', this.addLoanForm.customer_id_list)

      this.$refs.addLoanForm.validate((valid) => {
        if (valid) { // 只有信息检查正确的时候才可以提交
          console.log('form is validated, send the request')
          axios.post('http://localhost:8000/api/loan/', this.addLoanForm, { // 注意 addLoanForm 多了一个 customer_id_list
            headers: {
              'Content-Type': 'application/json'
            }
          }).then(function (response) {
            console.log('add new loan suuccessfully:')
            console.log(response.data)
            _this.$message('添加贷款信息成功')
            _this.getLoanInfo(_this) // 更新loantable
          }).catch(function (error) {
            console.log('post loan info error:')
            console.log(error.response)
            _this.$alert(error.response.data.errmsg, '添加贷款出错')
          })
        } else {
          console.log('add Loan Submit error')
          this.$alert('请按照输入框下的提示输入正确的信息', '添加贷款信息出错')
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
            'branch_name': this.addLoanForm.branch_branch_name
          }
        }).then(function (response) {
          console.log('update staff selector:')
          console.log(response.data)
          _this.staffOptions = response.data
        }).catch(function (error) {
          console.log('get staff info error:')
          console.log(error)
        })
        this.staffDis = false
      }
      callback()
    },
    validatePayId: function (rule, value, callback) {
      for (let i = 0; i < this.payTableData.length; i++) {
        if (value === this.payTableData[i].pay_id) {
          callback(new Error('付款号不能重复'))
        }
      }
      callback()
    },
    // 检查填写的发放贷款表单中的发放金额是否已经超过贷款总金额
    validatePayMoney: function (rule, value, callback) {
      let total = this.tableData[this.openLoanIndex].loan_money
      let paidTotal = 0
      for (let i = 0; i < this.payTableData.length; i++) {
        paidTotal += this.payTableData[i].pay_account
      }
      console.log('paidTotal = ' + paidTotal)
      if (paidTotal + this.addPayForm.pay_account > total) {
        callback(new Error('发放总金额已超过贷款金额'))
      } else {
        callback()
      }
    },
    // 每次修改所选支行时调用
    branchChanged: function () {
      console.log('br change')
      this.addLoanForm.staff_staff = '' // 每次修改支行时将之前选择的员工清除
    },
    // 查看一个贷款对应的客户
    handleViewCus: function (index, row) {
      let _this = this
      console.log('view customers: ', index, row)
      this.customerDialogFormVisible = true
      axios.get('http://localhost:8000/api/loan/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'loan_id': row.loan_id
        }
      }).then(function (response) {
        console.log('get customer table:')
        console.log(response.data)
        _this.cusTableData = response.data
      }).catch(function (error) {
        console.log('get customers info error:')
        console.log(error.response)
      })
    },
    // 发放贷款
    handleViewPayment: function (index, row) {
      let _this = this
      this.openLoanIndex = index
      console.log('make loan: ', index, row)
      this.payButtonDisable = false
      this.addPayForm = { loan_loan: row.loan_id, pay_id: '', pay_date: '', pay_account: '' }
      console.log('payButtonDisable = ', this.payButtonDisable)
      if (row.loan_state === '2') {
        console.log('payButtonDisable = true')
        this.payButtonDisable = true
      }
      this.payDialogFormVisible = true
      axios.get('http://localhost:8000/api/pay/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'loan_id': row.loan_id
        }
      }).then(function (response) {
        console.log('get pay for loan info:')
        console.log(response.data)
        _this.payTableData = response.data
      }).catch(function (error) {
        console.log('get pay info error:')
        console.log(error.response)
      })
    },
    payForLoan: function () {
      let _this = this
      console.log('发放贷款')
      console.log('addPayForm:', this.addPayForm)
      console.log('addPayForm.pay_date: ', this.addPayForm.pay_date, '   typeof pay_date: ', typeof (this.addPayForm.pay_date))
      this.$refs.addPayForm.validate((valid) => {
        if (valid) { // 只有 form 内容通过了检查才会提交
          axios.post('http://localhost:8000/api/pay/', this.addPayForm, {
            headers: {
              'Content-Type': 'application/json'
            }
          }).then(function (response) {
            console.log('pay for loan suuccessfully:')
            console.log(response.data)
            _this.$message('贷款发放成功')
            _this.getPayInfo(_this) // payTableData
            _this.getLoanInfo(_this) // 更新 loan table（可能该贷款已发放完，更新贷款状态）
          }).catch(function (error) {
            console.log('pay for loan error:')
            console.log(error.response)
          })
        } else {
          console.log('pay for loan error')
          this.$alert('请按照提示输入正确的信息', '付款信息出错')
          return false
        }
      })
    },
    // 删除贷款
    handleDelete: function (index, row) {
      let _this = this
      console.log('delete: ', index, row)
      // (this.tableData[index] === row) = true
      axios.delete('http://localhost:8000/api/loan/', {
        headers: {
          'Content-Type': 'application/json'
        },
        data: row
      }).then(function (response) {
        console.log('received info for delete loan method: ', response)
        _this.getLoanInfo(_this) // 更新 loan table
      }).catch(function (error) {
        console.log('delete loan error: ' + error)
        _this.$alert('删除贷款信息出错', '删除出错')
      })
    }
  }
}
</script>

<style scoped>
.button-right {
  float: right;
}
</style>
