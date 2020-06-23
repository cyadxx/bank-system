<template>
  <div>
    <el-container>
      <el-aside width="200px">
        <el-menu
          :default-active="activeMenu"
          class="el-menu-vertical-demo"
          @open="handleOpen"
          @close="handleClose"
          background-color="#545c64"
          text-color="#fff"
          active-text-color="#ffd04b"
          router>
        <!-- <el-menu
          :default-active="activeMenu"
          class="el-menu-vertical-demo"
          @open="handleOpen"
          @close="handleClose"
          background-color="#304156"
          text-color="#bfcbd9"
          active-text-color="#409EFF"
          router> -->
          <el-menu-item-group>
            <template slot="title">银行</template>
            <el-menu-item index="home">
              <i class="el-icon-office-building"></i>
              <span slot="title">首页</span>
            </el-menu-item>
          </el-menu-item-group>
          <el-menu-item-group>
            <template slot="title">统计</template>
            <el-menu-item index="stat">
              <i class="el-icon-pie-chart"></i>
              <span slot="title">业务统计</span>
            </el-menu-item>
          </el-menu-item-group>
          <el-menu-item-group>
            <template slot="title">管理</template>
            <el-menu-item index="branch">
              <i class="el-icon-school"></i>
              <span slot="title">支行管理</span>
            </el-menu-item>
            <el-menu-item index="dept">
              <i class="el-icon-suitcase-1"></i>
              <span slot="title">部门管理</span>
            </el-menu-item>
            <el-menu-item index="staff">
              <i class="el-icon-bank-card"></i>
              <span slot="title">员工管理</span>
            </el-menu-item>
            <el-menu-item index="customer">
              <i class="el-icon-s-custom"></i>
              <span slot="title">客户管理</span>
            </el-menu-item>
            <el-menu-item index="account">
              <i class="el-icon-wallet"></i>
              <span slot="title">账户管理</span>
            </el-menu-item>
            <el-menu-item index="loan">
              <i class="el-icon-coin"></i>
              <span slot="title">贷款管理</span>
            </el-menu-item>
          </el-menu-item-group>
        </el-menu>
      </el-aside>
      <el-main>
        <router-view/>
      </el-main>
    </el-container>
  </div>
</template>

<script>
export default {
  name: 'HomePage',
  data: function () {
    return {
      activeRouter: ''
    }
  },
  computed: {
    activeMenu: function () {
      const route = this.$route
      const { meta, path } = route
      // console.log('meta: ' + meta + ' path: ' + path)
      // console.log('meta.activeMenu: ' + meta.activeMenu)
      // if set path, the sidebar will highlight the path you set
      if (meta.activeMenu) {
        console.log('meta.activeMenu: ' + meta.activeMenu)
        return meta.activeMenu
      }
      console.log('path:' + path + ' typeof path: ' + typeof (path))
      console.log('path.substr(1): ' + path.substr(1))
      return path.substr(1)
    }
  },
  methods: {
    handleOpen: function (key, keyPath) {
      console.log(key, keyPath)
    },
    handleClose: function (key, keyPath) {
      console.log(key, keyPath)
    }
  }
}
</script>

<style scoped>
.el-aside {
  background-color: #D3DCE6;
  color: #333;
  line-height: 100%;
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
}

.el-main {
  /*background-color: #E9EEF3;*/
  position: absolute;
  left: 200px;
  right: 0;
  top: 0;
  bottom: 0;
  color: #333;
}

body > .el-container {
  margin-bottom: 40px;
}

.el-menu-item {
  text-align: center;
}

.el-menu {
  height: 100%;
}
</style>
