<template>
  <header>
    <md-layout md-gutter>
      <md-layout md-flex="5"></md-layout>
      <md-layout>
        <md-icon @click="goToHome" id="logo-icon" md-iconset="fa fa-bus" class="logo md-size-1x"></md-icon>
        <h1 @click="goToHome" class="logo">encontre seu onibus</h1>
      </md-layout>
      
      <md-layout md-align="end" class="nav-right">
        <nav>
          <a target="_blank" href="https://github.com/caiogranero/aqui-tem-rota">GitHub</a>
          <router-link to="contato">Contato</router-link>
          <router-link to="sobre">Sobre</router-link>          
        </nav>
      </md-layout>
      <md-layout md-flex="5"></md-layout>
    </md-layout>
  </header>
</template>

<script>
export default {
  name: 'Navbar',
  methods: {
    goToHome () {
      this.$router.push('/')
    }
  }
}
</script>

<style scoped>
header{
  -moz-box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.30);
  -webkit-box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.30);
  box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.30);
  background-color: #fff;
  position: relative;
  width: 100%;
  z-index: 99;
  top: 0;
  padding-top: 10px;
  padding-bottom: 15px;
}

.nav-right a{
  float: right;
  margin-right: 50px;
  color: #637282;
  margin-top: 20px;
  font-size: 15px;
  letter-spacing: 0.5px;
}

.nav-right a:hover{
  color: #1b2733;
  text-decoration: none;
}

#logo-icon {
  margin: 15px;
}

.logo {
  cursor: pointer;
}
</style>