<template>
  <div>
    <el-row>
      <el-table
        :data="tableData"
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
          label="二者关系"
          width="100">
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
              size="mini"
              @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
            <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-row>
    <el-row>
      <h3>添加新客户</h3>
    </el-row>
    <el-row>
      <el-form :inline="true" :model="addCusForm" :rules="addCusRules" label-width="100px" class="demo-form-inline">
        <el-form-item label="身份证号" prop="custom_id">
          <el-input v-model="addCusForm.custom_id" placeholder="客户身份证号"></el-input>
        </el-form-item>
        <el-form-item label="姓名" prop="custom_name">
          <el-input v-model="addCusForm.custom_name" placeholder="姓名"></el-input>
        </el-form-item>
        <el-form-item label="手机号" prop="custom_phone">
          <el-input v-model="addCusForm.custom_phone" placeholder="手机号"></el-input>
        </el-form-item>
        <el-form-item label="地址" prop="custom_address">
          <el-input v-model="addCusForm.custom_address" placeholder="家庭住址"></el-input>
        </el-form-item>
        <el-form-item label="联系人姓名" prop="contact_name">
          <el-input v-model="addCusForm.contact_name" placeholder="联系人姓名"></el-input>
        </el-form-item>
        <el-form-item label="联系人电话" prop="contact_phone">
          <el-input v-model="addCusForm.contact_phone" placeholder="联系人电话"></el-input>
        </el-form-item>
        <el-form-item label="联系人邮箱" prop="contact_email">
          <el-input v-model="addCusForm.contact_email" placeholder="联系人邮箱"></el-input>
        </el-form-item>
        <el-form-item label="二者关系" prop="contact_custom_relation">
          <el-input v-model="addCusForm.contact_custom_relation" placeholder="二者关系"></el-input>
        </el-form-item>
        <el-form-item class="button-right">
          <el-button type="primary" @click="addCusSubmit">添加</el-button>
        </el-form-item>
      </el-form>
    </el-row>

    <el-dialog title="修改客户信息" :visible.sync="dialogFormVisible">
      <el-form :inline="true" :model="editCusForm" :rules="addCusRules" label-width="100px" class="demo-form-inline">
        <el-form-item label="身份证号" prop="custom_id">
          <el-input v-model="editCusForm.custom_id" placeholder="客户身份证号"></el-input>
        </el-form-item>
        <el-form-item label="姓名" prop="custom_name">
          <el-input v-model="editCusForm.custom_name" placeholder="姓名"></el-input>
        </el-form-item>
        <el-form-item label="手机号" prop="custom_phone">
          <el-input v-model="editCusForm.custom_phone" placeholder="手机号"></el-input>
        </el-form-item>
        <el-form-item label="地址" prop="custom_address">
          <el-input v-model="editCusForm.custom_address" placeholder="家庭住址"></el-input>
        </el-form-item>
        <el-form-item label="联系人姓名" prop="contact_name">
          <el-input v-model="editCusForm.contact_name" placeholder="联系人姓名"></el-input>
        </el-form-item>
        <el-form-item label="联系人电话" prop="contact_phone">
          <el-input v-model="editCusForm.contact_phone" placeholder="联系人电话"></el-input>
        </el-form-item>
        <el-form-item label="联系人邮箱" prop="contact_email">
          <el-input v-model="editCusForm.contact_email" placeholder="联系人邮箱"></el-input>
        </el-form-item>
        <el-form-item label="二者关系" prop="contact_custom_relation">
          <el-input v-model="editCusForm.contact_custom_relation" placeholder="二者关系"></el-input>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="commitEdit">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'CyaCustomer',
  data: function () {
    return {
      tableData: [],
      addCusForm: {
        custom_id: '',
        custom_name: '',
        custom_phone: '',
        custom_address: '',
        contact_name: '',
        contact_phone: '',
        contact_email: '',
        contact_custom_relation: ''
      },
      addCusRules: {
        custom_id: [
          { required: true, message: '请输入客户身份证号', trigger: 'blur' },
          { min: 18, max: 18, message: '长度为 18 个字符', trigger: 'blur' }
        ],
        custom_name: [
          { required: true, message: '请输入客户姓名', trigger: 'change' },
          { min: 1, max: 10, message: '长度在 1 到 10 个字符', trigger: 'change' }
        ],
        custom_phone: [
          { required: true, message: '请输入客户电话', trigger: 'change' },
          { min: 7, max: 11, message: '长度在 7 到 11 个字符', trigger: 'change' }
        ],
        custom_address: [
          { required: true, message: '请输入客户地址', trigger: 'change' },
          { min: 1, max: 100, message: '长度在 1 到 100 个字符', trigger: 'change' }
        ],
        contact_name: [
          { required: true, message: '请输入联系人姓名', trigger: 'change' },
          { min: 1, max: 10, message: '长度在 1 到 10 个字符', trigger: 'change' }
        ],
        contact_phone: [
          { required: true, message: '请输入联系人电话', trigger: 'change' },
          { min: 7, max: 11, message: '长度在 7 到 11 个字符', trigger: 'change' }
        ],
        contact_email: [
          { required: true, message: '请输入联系人邮箱', trigger: 'blur' },
          { min: 1, max: 30, message: '长度在 1 到 30 个字符', trigger: 'change' }
        ],
        contact_custom_relation: [
          { required: true, message: '请输入二者关系', trigger: 'blur' },
          { min: 1, max: 10, message: '长度在 1 到 10 个字符', trigger: 'change' }
        ]
      },
      dialogFormVisible: false,
      editCusForm: {
        custom_id: '',
        custom_name: '',
        custom_phone: '',
        custom_address: '',
        contact_name: '',
        contact_phone: '',
        contact_email: '',
        contact_custom_relation: ''
      },
      formLabelWidth: '120px'
    }
  },
  mounted: function () {
    let _this = this
    axios.request({
      url: 'http://localhost:8000/api/customer/',
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    }).then(function (response) {
      console.log(response.data)
      console.log('type:', typeof (response.data))
      _this.tableData = response.data
    })
  },
  methods: {
    updateCusTable: function (_this) { // 更新客户列表，在添加、删除、修改之后
      axios.get('http://localhost:8000/api/customer/', {
        headers: {
          'Content-Type': 'application/json'
        }
      }).then(function (response) {
        console.log('update table:')
        console.log(response.data)
        _this.tableData = response.data
      })
    },
    addCusSubmit: function () {
      let _this = this
      console.log('submit new customer')
      axios.request({
        url: 'http://localhost:8000/api/customer/',
        method: 'POST',
        data: this.addCusForm
      }).then(function (response) { // 添加新的客户后更新表格
        console.log('post then:')
        if (response.data.errmsg !== undefined) {
          console.log(response.data.errmsg)
          _this.$alert(response.data.errmsg, '添加出错')
        }
        _this.updateCusTable(_this)
      })
    },
    handleEdit: function (index, row) {
      console.log('edit: ', index, row)
      this.editCusForm = Object.assign({}, this.tableData[index]) // 深度复制
      this.dialogFormVisible = true
    },
    commitEdit: function () { // TODO
      let _this = this
      console.log('commit edit')
      axios.put('http://localhost:8000/api/customer/', this.editCusForm, {
        headers: {
          'Content-Type': 'application/json'
        }
      }).then(function (response) {
        console.log('response after edit customer info')
        console.log(response)
        _this.updateCusTable(_this)
      }).catch(function (error) {
        console.log('edit customer info error:')
        console.log(error)
        _this.$alert(error, '修改出错')
      })
      this.dialogFormVisible = false
    },
    handleDelete: function (index, row) {
      let _this = this
      console.log(index, row)
      console.log('typeof index: ' + typeof (index))
      console.log('typeof row: ' + typeof (row))
      axios.delete('http://localhost:8000/api/customer/', {
        headers: {
          'Content-Type': 'application/json'
        },
        data: this.tableData[index]
      }).then(function (response) {
        console.log('received info for delete method: ', response)
        if (response.data.errmsg !== undefined) {
          _this.$alert(response.data.errmsg, '删除出错')
        } else { // 只有成功删除时才需要更新表格
          _this.updateCusTable(_this)
        }
      }).catch(function (error) {
        console.log('error: ' + error)
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
