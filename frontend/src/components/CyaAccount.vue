<template>
  <div>
    <el-row>
      <h3>查询</h3>
    </el-row>
    <el-row>
      <el-form :inline="true" :model="queryAccountForm" :rules="queryAccountRules" ref="queryAccountForm" label-width="95px" class="demo-form-inline">
        <el-row>
          <el-form-item label="账户类型" prop="account_type">
            <el-select v-model="queryAccountForm.account_type" placeholder="请选择账户类型">
              <el-option
                v-for="item in typeOptions"
                :key="item.type"
                :label="item.type_name"
                :value="item.type">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="利率" prop="interset_rate" v-if="!queryFormIntersetRateDisabled">
            <el-input type="number" v-model.number="queryAccountForm.interset_rate"
              placeholder="利率" :disabled="queryFormIntersetRateDisabled">
            </el-input>
          </el-form-item>
          <el-form-item label="货币类型" prop="currency_type" v-if="!queryFormCurrencyTypeDisabled">
            <el-input v-model="queryAccountForm.currency_type" placeholder="货币类型"
              :disabled="queryFormCurrencyTypeDisabled">
            </el-input>
          </el-form-item>
          <el-form-item label="透支额" prop="credit_line" v-if="!queryFormCreditLineDisabled">
            <el-input type="number" v-model.number="queryAccountForm.credit_line"
              placeholder="透支额" :disabled="queryFormCreditLineDisabled">
            </el-input>
          </el-form-item>
        </el-row>
        <el-row>
          <el-form-item label="账户号" prop="account_id">
            <el-input v-model="queryAccountForm.account_id" placeholder="账户号"></el-input>
          </el-form-item>
          <el-form-item label="账户余额" prop="account_balance_range">
            <el-input type="number" v-model.number="queryAccountForm.account_balance_range" placeholder="账户余额"></el-input>
          </el-form-item>
          <el-form-item label="开户日期" prop="account_opendate_range">
            <el-date-picker
              v-model="queryAccountForm.account_opendate_range"
              type="datetimerange"
              range-separator="至"
              start-placeholder="开始日期"
              end-placeholder="结束日期"
              value-format="yyyy-MM-dd HH:mm:ss"
              :picker-options="pickerOptions">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="所属支行" prop="branch_branch_name">
            <el-select v-model="queryAccountForm.branch_branch_name" placeholder="请选择所属支行" @change="branchChangedInQueryForm">
              <el-option
                v-for="item in brOptions"
                :key="item.branch_name"
                :label="item.branch_name"
                :value="item.branch_name">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="负责员工" prop="staff_staff">
            <el-select v-model="queryAccountForm.staff_staff" :disabled="staffDisInQueryForm" :placeholder="staffDisInQueryForm ? '请先选择支行' : '请选择负责员工'">
              <el-option
                v-for="item in staffOptionsInQueryForm"
                :key="item.staff_id"
                :label="item.staff_name"
                :value="item.staff_id">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="账户所有者" prop="customer_id_list">
            <el-select v-model="queryAccountForm.customer_id_list" multiple placeholder="请选择开户客户">
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
          <el-button type="primary" size="medium" @click="queryAccSubmit">查询</el-button>
        </el-form-item>
        <el-form-item class="button-right">
          <el-button size="medium" @click="clearQueryForm">清空</el-button>
        </el-form-item>
      </el-form>
    </el-row>

    <el-row>
      <h3>账户列表</h3>
    </el-row>
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
              @click="handleDeleteAcc(scope.$index, scope.row)">删除</el-button>
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

    <!--点击“详情”按钮的弹出框-->
    <el-dialog title="该账户的详细信息" :before-close="handleViewDetailDialogClose" :visible.sync="accDetailDialogFormVisible" width="80%">
      <h3 v-if="saveaccountDisplay">本账户是储蓄账户</h3>
      <h3 v-else>本账户是支票账户</h3>

      <el-form :inline="true" :model="saveCheckAccForm" :rules="saveCheckAccRules" ref="saveCheckAccForm" class="demo-form-inline">
        <el-form-item label="利率" prop="interset_rate" v-if="saveaccountDisplay">
          <el-input type="number" v-model.number="saveCheckAccForm.interset_rate"
            :disabled="!editSaveCheckInfo" placeholder="利率">
          </el-input>
        </el-form-item>
        <el-form-item label="货币类型" prop="currency_type" v-if="saveaccountDisplay">
          <el-input :disabled="!editSaveCheckInfo" v-model="saveCheckAccForm.currency_type" placeholder="货币类型"></el-input>
        </el-form-item>
        <el-form-item label="透支额" prop="credit_line" v-if="!saveaccountDisplay">
          <el-input type="number" v-model.number="saveCheckAccForm.credit_line"
            :disabled="!editSaveCheckInfo" placeholder="透支额">
          </el-input>
        </el-form-item>
        <el-form-item v-if="!editSaveCheckInfo">
          <el-button type="primary" plain size="large" @click="handleEditSaveCheck">修改</el-button>
        </el-form-item>
        <el-form-item v-if="editSaveCheckInfo">
          <el-button type="primary" plain size="large" @click="handleEditSaveCheckCommit">提交</el-button>
        </el-form-item>
        <el-form-item v-if="editSaveCheckInfo">
          <el-button plain size="large" @click="handleEditSaveCheckCancel">取消</el-button>
        </el-form-item>
      </el-form>

      <h3>账户的所有者</h3>
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
        <!-- <el-table-column
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
        </el-table-column> -->
        <el-table-column
          prop="last_visit"
          label="最后访问该账户的时间"
          width="200">
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-popover
              placement="top"
              trigger="manual"
              v-model="popoverVisible[scope.$index]">
              <el-date-picker
                v-model="changedAccessAccountLastDate"
                type="datetime"
                value-format="yyyy-MM-dd HH:mm:ss"
                :picker-options="pickerOptions"
                placeholder="请选择开户日期">
              </el-date-picker>
              <el-button
                @click="handleAccessAccountCommit(scope.$index, scope.row)"
                type="primary" plain>提交</el-button>
              <el-button
                slot="reference"
                size="mini"
                type="primary" plain
                @click="handleAccessAccount(scope.$index, scope.row)">访问账户</el-button>
            </el-popover>
            <el-button
              :disabled="cusTableData.length === 1"
              size="mini"
              type="danger" plain
              @click="handleDeleteAccOwner(scope.$index, scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <h4>添加账户所有者</h4>
      <el-form :inline="true" :model="addAccountOwnerForm" :rules="addAccountOwnerRules" ref="addAccountOwnerForm" label-width="120px" class="demo-form-inline">
        <el-form-item label="加入账户日期" prop="last_visit">
          <el-date-picker
            v-model="addAccountOwnerForm.last_visit"
            type="datetime"
            value-format="yyyy-MM-dd HH:mm:ss"
            :picker-options="pickerOptions"
            placeholder="请选择开户日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="账户所有者" prop="customer">
          <el-select v-model="addAccountOwnerForm.customer" placeholder="请选择开户客户">
            <el-option
              v-for="item in customerOptions"
              :key="item.id"
              :label="item.custom_name"
              :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" plain size="large" @click="addAccountOwnerSubmit">添 加</el-button>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="handleViewDetailDialogClose">关 闭</el-button>
      </div>
    </el-dialog>

    <!--点击“修改”按钮的弹出框-->
    <el-dialog title="修改账户信息" :visible.sync="accEditDialogFormVisible">
      <el-form :inline="true" :model="editAccountForm" :rules="editAccountRules" ref="editAccountForm" label-width="100px" class="demo-form-inline">
        <el-row>
          <el-form-item label="账户号" prop="account_id">
            {{ editAccountForm.account_id }}
          </el-form-item>
          <el-form-item label="账户类型" prop="account_type">
            {{ editAccountForm.account_type }}
          </el-form-item>
        </el-row>
        <el-row>
          <el-form-item label="账户余额" prop="account_balance">
            <el-input type="number" v-model.number="editAccountForm.account_balance" placeholder="账户余额"></el-input>
          </el-form-item>
          <el-form-item label="开户日期" prop="account_opendate">
            <el-date-picker
              disabled
              v-model="editAccountForm.account_opendate"
              type="datetime"
              value-format="yyyy-MM-dd HH:mm:ss"
              :picker-options="pickerOptions"
              placeholder="请选择开户日期">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="所属支行" prop="branch_branch_name">
            <el-select v-model="editAccountForm.branch_branch_name" placeholder="请选择所属支行" @change="branchChangedInEditForm">
              <el-option
                v-for="item in brOptions"
                :key="item.branch_name"
                :label="item.branch_name"
                :value="item.branch_name">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="负责员工" prop="staff_staff">
            <el-select v-model="editAccountForm.staff_staff" :disabled="staffDisInEditForm" :placeholder="staffDisInEditForm ? '请先选择支行' : '请选择负责员工'">
              <el-option
                v-for="item in staffOptionsInEditForm"
                :key="item.staff_id"
                :label="item.staff_name"
                :value="item.staff_id">
              </el-option>
            </el-select>
          </el-form-item>
        </el-row>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="accEditDialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="commitAccEdit">确 定</el-button>
      </div>
    </el-dialog>
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
      staffDisInEditForm: true,
      staffDisInQueryForm: true,
      brOptions: [],
      staffOptions: [],
      staffOptionsInEditForm: [],
      staffOptionsInQueryForm: [],
      customerOptions: [],
      accDetailDialogFormVisible: false,
      accEditDialogFormVisible: false,
      cusTableData: [],
      deleteAccOwnerDisabled: false,
      openAccIndex: 0,
      popoverVisible: [],
      changedAccessAccountLastDate: '',
      saveaccountDisplay: true,
      editSaveCheckInfo: false,
      saveCheckAccForm: {
        account_account: '',
        interset_rate: '',
        currency_type: '',
        credit_line: ''
      },
      saveCheckAccFormBackup: {},
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
          { required: true, message: '请选则开户客户', trigger: 'change' }
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
      },
      queryAccountForm: {
        account_id: '',
        account_balance_range: '', // 返回比该值大的账户余额的账户
        account_type: '',
        account_opendate_range: '',
        branch_branch_name: '',
        staff_staff: '',
        customer_id_list: [], // 新增贷款表单中选择的开户客户。可以用 queryAccountForm.splice(6, 1) 删除
        interset_rate: '',
        currency_type: '',
        credit_line: ''
      },
      queryAccountRules: {
        account_id: [
          { min: 1, max: 6, message: '长度在 1 到 6 个字符', trigger: 'change' }
        ],
        account_balance_range: [
          { type: 'number', message: '请不要输入除数字外的字符', trigger: 'change' }
        ],
        branch_branch_name: [
          { validator: this.validateChooseBrInQueryForm, trigger: 'change' }
        ],
        interset_rate: [
          { type: 'number', message: '请不要输入除数字外的字符', trigger: 'change' },
          { validator: this.validateInterestRate, trigger: 'change' }
        ],
        currency_type: [
          { min: 1, max: 10, message: '长度在 1 到 10 个字符', trigger: 'change' }
        ],
        credit_line: [
          { type: 'number', message: '请不要输入除数字外的字符', trigger: 'change' }
        ]
      },
      editAccountForm: {
        account_id: '',
        account_balance: '',
        account_type: '',
        account_opendate: '',
        branch_branch_name: '',
        staff_staff: ''
      },
      editAccountRules: {
        // account_id: [
        //   { required: true, message: '请输入账户号', trigger: 'change' },
        //   { min: 1, max: 6, message: '长度在 1 到 6 个字符', trigger: 'change' }
        // ],
        account_balance: [
          { required: true, message: '请输入账户余额', trigger: 'change' },
          { type: 'number', message: '请不要输入除数字外的字符', trigger: 'change' }
        ],
        // account_type: [
        //   { required: true, message: '请选择账户类型', trigger: 'change' }
        // ],
        account_opendate: [
          { required: true, message: '请选择开户日期', trigger: 'change' }
        ],
        staff_staff: [
          { required: true, message: '请选择负责员工', trigger: 'change' }
        ],
        branch_branch_name: [
          { required: true, message: '请选择所属支行', trigger: 'change' },
          { validator: this.validateChooseBrInEditForm, trigger: 'change' }
        ]
      },
      saveCheckAccRules: {
        interset_rate: [
          { required: true, message: '请输入利率', trigger: 'change' },
          { type: 'number', message: '请不要输入除数字外的字符', trigger: 'change' },
          { validator: this.validateInterestRate, trigger: 'change' }
        ],
        currency_type: [
          { required: true, message: '请输入货币类型', trigger: 'change' },
          { min: 1, max: 10, message: '长度在 1 到 10 个字符', trigger: 'change' }
        ],
        credit_line: [
          { required: true, message: '请输入透支额', trigger: 'change' },
          { type: 'number', message: '请不要输入除数字外的字符', trigger: 'change' }
        ]
      },
      addAccountOwnerForm: {
        account_account: '',
        customer: '',
        last_visit: '',
        acc_type: '',
        belong_branch: ''
      },
      addAccountOwnerRules: {
        account_account: [
          { required: true, message: '请输入账户号', trigger: 'change' },
          { min: 1, max: 6, message: '长度在 1 到 6 个字符', trigger: 'change' }
        ],
        customer_id: [
          { required: true, message: '请选则加入账户的客户', trigger: 'change' }
        ],
        last_visit: [
          { required: true, message: '请选择加入账户的日期', trigger: 'change' }
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
    },
    queryFormIntersetRateDisabled: function () {
      if ((this.queryAccountForm.account_type === '') || (this.queryAccountForm.account_type === 'checkaccount')) {
        // 未选择账户类型或账户类型是支票账户时禁用
        return true
      } else if (this.queryAccountForm.account_type === 'saveaccount') {
        return false
      } else {
        print('queryFormIntersetRateDisabled error!')
        return true
      }
    },
    queryFormCurrencyTypeDisabled: function () {
      return this.queryFormIntersetRateDisabled
    },
    queryFormCreditLineDisabled: function () {
      if ((this.queryAccountForm.account_type === '') || (this.queryAccountForm.account_type === 'saveaccount')) {
        // 未选择账户类型或账户类型是支票账户时禁用
        return true
      } else if (this.queryAccountForm.account_type === 'checkaccount') {
        return false
      } else {
        print('queryFormCreditLineDisabled error!')
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
    getSaveAccountInfo: function (_this) {
      axios.get('http://localhost:8000/api/saveacc/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'account_id': _this.accTableData[_this.openAccIndex].account_id
        }
      }).then(function (response) {
        console.log('get save account table:')
        console.log(response.data[0].currency_type)
        _this.saveCheckAccForm.account_account = response.data[0].account_account
        _this.saveCheckAccForm.interset_rate = response.data[0].interset_rate
        _this.saveCheckAccForm.currency_type = response.data[0].currency_type
        _this.saveCheckAccForm.credit_line = ''
      }).catch(function (error) {
        console.log('get save account info error:')
        console.log(error.response)
      })
    },
    getCheckAccountInfo: function (_this) {
      axios.get('http://localhost:8000/api/checkacc/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'account_id': _this.accTableData[_this.openAccIndex].account_id
        }
      }).then(function (response) {
        console.log('get check account table:')
        console.log(response.data)
        _this.saveCheckAccForm.account_account = response.data[0].account_account
        _this.saveCheckAccForm.interset_rate = ''
        _this.saveCheckAccForm.currency_type = ''
        _this.saveCheckAccForm.credit_line = response.data[0].credit_line
      }).catch(function (error) {
        console.log('get check account info error:')
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
    branchChangedInEditForm: function () {
      console.log('br change')
      this.editAccountForm.staff_staff = '' // 每次修改支行时将之前选择的员工清除
    },
    branchChangedInQueryForm: function () {
      console.log('br change')
      this.queryAccountForm.staff_staff = '' // 每次修改支行时将之前选择的员工清除
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
            _this.$alert(error.response.data.errmsg, '添加新账户出错')
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
    validateChooseBrInEditForm: function (rule, value, callback) {
      let _this = this
      console.log('validate choose br in edit form:')
      if (value !== '') {
        axios.get('http://localhost:8000/api/staff/', {
          headers: {
            'Content-Type': 'application/json'
          },
          params: {
            'branch_name': this.editAccountForm.branch_branch_name
          }
        }).then(function (response) {
          console.log('update staff selector in edit form:')
          console.log(response.data)
          _this.staffOptionsInEditForm = response.data
        }).catch(function (error) {
          console.log('get staff info error:')
          console.log(error.response)
        })
        this.staffDisInEditForm = false
      }
      callback()
    },
    validateChooseBrInQueryForm: function (rule, value, callback) {
      let _this = this
      console.log('validate choose br in query form:')
      if (value !== '') {
        axios.get('http://localhost:8000/api/staff/', {
          headers: {
            'Content-Type': 'application/json'
          },
          params: {
            'branch_name': this.queryAccountForm.branch_branch_name
          }
        }).then(function (response) {
          console.log('update staff selector in query form:')
          console.log(response.data)
          _this.staffOptionsInQueryForm = response.data
        }).catch(function (error) {
          console.log('get staff info error:')
          console.log(error.response)
        })
        this.staffDisInQueryForm = false
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
      // 需要获取每个客户访问该账户的日期
      // 思路：发请求给 account，通过 manytomanyfield
      let _this = this
      console.log('view account detail:')
      console.log('index = ', index, '    row = ', row)
      this.openAccIndex = index
      this.saveaccountDisplay = (row.account_type === 'saveaccount')
      this.accDetailDialogFormVisible = true
      axios.get('http://localhost:8000/api/account/', {
        headers: {
          'Content-Type': 'application/json'
        },
        params: {
          'account_id': row.account_id
        }
      }).then(function (response) {
        console.log('get customer table:')
        console.log(response.data)
        _this.cusTableData = response.data
        console.log('cusTableData.length = ', _this.cusTableData.length)
      }).catch(function (error) {
        console.log('get customers info error:')
        console.log(error.response)
      })
      if (this.saveaccountDisplay === true) { // 储蓄账户
        this.getSaveAccountInfo(this)
      } else { // 支票账户
        this.getCheckAccountInfo(this)
      }
    },
    handleViewDetailDialogClose: function (done) {
      this.popoverVisible = []
      console.log('close dialog')
      console.log('popoverVisible', this.popoverVisible)
      // done()
      this.accDetailDialogFormVisible = false
    },
    handleEdit: function (index, row) {
      // let _this = this
      console.log('edit account info:')
      console.log('index = ', index, '    row = ', row)
      this.accEditDialogFormVisible = true // 打开修改账户信息的 dialog
      this.editAccountForm = Object.assign({}, row) // 复制
    },
    commitAccEdit: function () {
      let _this = this
      console.log('commit edited account info:')
      axios.put('http://localhost:8000/api/account/', this.editAccountForm, {
        headers: {
          'Content-Type': 'application/json'
        }
      }).then(function (response) {
        console.log('response after edit account info')
        console.log(response)
        _this.getAccountInfo(_this)
      }).catch(function (error) {
        console.log('edit account info error:')
        console.log(error.response)
        _this.$alert(error.response, '修改账户信息出错')
      })
      this.accEditDialogFormVisible = false
    },
    // 删除账户
    handleDeleteAcc: function (index, row) {
      let _this = this
      console.log('delete account:')
      console.log('index = ', index, '    row = ', row)
      axios.delete('http://localhost:8000/api/account/', {
        headers: {
          'Content-Type': 'application/json'
        },
        data: row
      }).then(function (response) {
        console.log('received info for delete account method: ', response)
        _this.getAccountInfo(_this) // 更新 account table
        _this.$message('删除账户成功')
      }).catch(function (error) {
        console.log('delete account error: ' + error)
        _this.$alert('删除账户出错', '删除出错')
      })
    },
    handleEditSaveCheck: function () {
      this.editSaveCheckInfo = true
      this.saveCheckAccFormBackup = Object.assign({}, this.saveCheckAccForm) // 复制
    },
    handleEditSaveCheckCancel: function () {
      this.editSaveCheckInfo = false
      this.saveCheckAccForm = Object.assign({}, this.saveCheckAccFormBackup)
    },
    handleEditSaveCheckCommit: function () {
      let _this = this
      console.log('edit save or check info:')
      console.log('this.saveCheckAccForm', this.saveCheckAccForm)
      this.editSaveCheckInfo = false
      this.$refs.saveCheckAccForm.validate((valid) => {
        if (valid) {
          console.log('saveCheckAccForm validate pass !!!!!!!!!!!!!!!')
          if (this.saveaccountDisplay === true) { // 修改了储蓄账户
            axios.put('http://localhost:8000/api/saveacc/', this.saveCheckAccForm, {
              headers: {
                'Content-Type': 'application/json'
              }
            }).then(function (response) {
              console.log('edit save account suuccessfully:')
              console.log(response.data)
              _this.$message('修改储蓄账户信息成功')
              _this.getSaveAccountInfo(_this)
            }).catch(function (error) {
              console.log('edit save account info error:')
              console.log(error.response)
              _this.$alert(error.response.data, '修改储蓄账户出错')
              _this.saveCheckAccForm = Object.assign({}, _this.saveCheckAccFormBackup)
            })
          } else { // 修改了支票账户
            axios.put('http://localhost:8000/api/checkacc/', this.saveCheckAccForm, {
              headers: {
                'Content-Type': 'application/json'
              }
            }).then(function (response) {
              console.log('edit check account suuccessfully:')
              console.log(response.data)
              _this.$message('修改支票账户信息成功')
              _this.getCheckAccountInfo(_this)
            }).catch(function (error) {
              console.log('edit check account info error:')
              console.log(error.response)
              _this.$alert(error.response.data, '修改支票账户出错')
              _this.saveCheckAccForm = Object.assign({}, _this.saveCheckAccFormBackup)
            })
          }
        } else {
          console.log('edit save check account Submit error')
          this.$alert('请按照输入框下的提示输入正确的信息', '修改出错')
          this.editSaveCheckInfo = true
          return false
        }
      })
    },
    handleAccessAccount: function (index, row) {
      console.log('access this account')
      console.log('index = ', index, '    row = ', row)
      if (this.popoverVisible[index] === true) {
        this.popoverVisible = []
      } else {
        this.popoverVisible = []
        this.popoverVisible[index] = !this.popoverVisible[index]
      }
      console.log('popoverVisible[index] = ', this.popoverVisible[index])
      this.changedAccessAccountLastDate = new Date(row.last_visit)
    },
    // 账户拥有者访问账户，向 cusacc/ 发请求，内容是 custom_id, account_id, last_visit
    handleAccessAccountCommit: function (index, row) {
      let _this = this
      console.log('access this account commit')
      console.log('index = ', index, '    row = ', row)
      let accessAccountDict = {
        'custom_id': row.id,
        'account_id': this.accTableData[this.openAccIndex].account_id,
        'last_visit': this.changedAccessAccountLastDate
      }
      console.log('accessAccountDict = ', accessAccountDict)
      axios.put('http://localhost:8000/api/cusacc/', accessAccountDict, {
        headers: {
          'Content-Type': 'application/json'
        }
      }).then(function (response) {
        console.log('response after access account')
        console.log(response)
        // 要更新客户的信息，关闭日期输入框
        _this.popoverVisible = []
        let __this = _this
        axios.get('http://localhost:8000/api/account/', {
          headers: {
            'Content-Type': 'application/json'
          },
          params: {
            'account_id': _this.accTableData[_this.openAccIndex].account_id
          }
        }).then(function (response) {
          console.log('get customer table:')
          console.log(response.data)
          __this.cusTableData = response.data // note
          console.log('cusTableData.length = ', __this.cusTableData.length)
        }).catch(function (error) {
          console.log('get customers info error:')
          console.log(error.response)
        })
        _this.$message('访问账户成功')
      }).catch(function (error) {
        console.log('access account error:')
        console.log(error)
        _this.$alert(error, '访问账户出错')
      })
    },
    handleDeleteAccOwner: function (index, row) {
      let _this = this
      console.log('access this account')
      console.log('index = ', index, '    row = ', row)
      let deleteAccountDict = {
        'custom_id': row.id,
        'account_id': this.accTableData[this.openAccIndex].account_id
      }
      console.log('deleteAccountDict = ', deleteAccountDict)
      axios.delete('http://localhost:8000/api/cusacc/', {
        headers: {
          'Content-Type': 'application/json'
        },
        data: deleteAccountDict
      }).then(function (response) {
        console.log('received info for delete customer_jas_account: ', response)
        // 更新 customer table
        let __this = _this
        axios.get('http://localhost:8000/api/account/', {
          headers: {
            'Content-Type': 'application/json'
          },
          params: {
            'account_id': _this.accTableData[_this.openAccIndex].account_id
          }
        }).then(function (response) {
          console.log('get customer table:')
          console.log(response.data)
          __this.cusTableData = response.data // note
          console.log('cusTableData.length = ', __this.cusTableData.length)
        }).catch(function (error) {
          console.log('get customers info error:')
          console.log(error.response)
        })
        _this.$message('删除账户所有者成功')
      }).catch(function (error) {
        console.log('delete customer_has_account error: ' + error)
        _this.$alert(error, '删除账户所有者出错')
      })
    },
    addAccountOwnerSubmit: function () {
      let _this = this
      console.log('add account owner submit')

      this.$refs.addAccountOwnerForm.validate((valid) => {
        if (valid) {
          console.log('addAccountOwnerForm is validated, send the request')
          this.addAccountOwnerForm.account_account = this.accTableData[this.openAccIndex].account_id
          this.addAccountOwnerForm.acc_type = this.accTableData[this.openAccIndex].account_type
          this.addAccountOwnerForm.belong_branch = this.accTableData[this.openAccIndex].branch_branch_name
          console.log('addAccountOwnerForm = ', this.addAccountOwnerForm)
          axios.post('http://localhost:8000/api/cusacc/', this.addAccountOwnerForm, {
            headers: {
              'Content-Type': 'application/json'
            }
          }).then(function (response) {
            console.log('add new account owner suuccessfully:')
            console.log(response.data)
            // 更新 customer table
            let __this = _this
            axios.get('http://localhost:8000/api/account/', {
              headers: {
                'Content-Type': 'application/json'
              },
              params: {
                'account_id': _this.accTableData[_this.openAccIndex].account_id
              }
            }).then(function (response) {
              console.log('get customer table:')
              console.log(response.data)
              __this.cusTableData = response.data // note
              console.log('cusTableData.length = ', __this.cusTableData.length)
            }).catch(function (error) {
              console.log('get customers info error:')
              console.log(error.response)
            })
            _this.$message('添加新账户成功')
          }).catch(function (error) {
            console.log('post account info error:')
            console.log(error.response)
            _this.$alert(error.response.data, '添加账户所有者出错')
          })
        } else {
          console.log('add account owner Submit error')
          this.$alert('请按照输入框下的提示输入正确的信息', '添加新账户所有者出错')
          return false
        }
      })
    },
    queryAccSubmit: function () {
      console.log('queryAccSubmit')
      console.log('queryAccountForm = ', this.queryAccountForm)
      let _this = this
      this.$refs.queryAccountForm.validate((valid) => {
        if (valid) {
          console.log('query info is valid, perform the query')
          axios.get('http://localhost:8000/api/account/', {
            headers: {
              'Content-Type': 'application/json'
            },
            params: this.queryAccountForm
          }).then(function (response) {
            console.log('query accounts according to the filter info:')
            console.log(response.data)
            _this.accTableData = response.data
            console.log('_this.tableData = ', _this.accTableData)
          }).catch(function (error) {
            console.log('query account info error')
            console.log(error.response)
            _this.$alert(error.response, '查询账户信息出错')
          })
        } else {
          console.log('queryAccSubmit error')
          this.$alert('请按照提示输入正确的信息', '按条件查询账户出错')
          return false
        }
      })
    },
    clearQueryForm: function () {
      console.log('clear account query form')
      this.queryAccountForm = {
        account_id: '',
        account_balance_range: 0,
        account_type: '',
        account_opendate_range: '',
        branch_branch_name: '',
        staff_staff: '',
        customer_id_list: [], // 新增贷款表单中选择的开户客户。可以用 queryAccountForm.splice(6, 1) 删除
        interset_rate: 1,
        currency_type: '',
        credit_line: 0
      }
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

.edit-button {
  margin-top: 10px;
}

.detail-info {
  width: 206px;
}
</style>
