<template>
    <div class="card-template">
        <div class="card-header title">
            User Management
        </div>
        <div class="card-body form-container">
            <div v-if="connected" class="form-row">
                <label for="">ID : </label>
                <input v-model="id" type="text">
            </div>
            <div v-if="connected || newUser" class="form-row">
                <label for="">Email : </label>
                <input v-model="email" type="text">
            </div>
            <div v-if="connected || newUser" class="form-row">
                <label for="">Firstname : </label>
                <input v-model="firstname" type="text">
            </div>
            <div v-if="connected || newUser" class="form-row">
                <label for="">Lastname : </label>
                <input v-model="lastname" type="text">
            </div>
            <div class="form-row">
                <label for="">Username : </label>
                <input v-model="username" type="text">
            </div>
            <div v-if="!connected || newUser" class="form-row">
                <label for="">Password : </label>
                <input v-model="password" type="password">
            </div>

            <div class="form-row form-row-wrap">
                <button class="form-action-button" v-if="!connected && newUser" v-on:click="createUser()" style="background:#E7BB41">Sign up</button>
                <button class="form-action-button" v-if="connected" v-on:click="updateUser()">Update</button>
                <button class="form-action-button" v-if="connected" v-on:click="getInfos()">Get Infos</button>
                <button class="form-action-button" v-if="connected" v-on:click="deleteUser()">Delete</button>
                <button class="form-action-button" v-if="!connected && !newUser" v-on:click="connect()" style="background:#E7BB41">Connect</button>
                <button class="form-action-button" v-if="connected" v-on:click="disconnect()" style="background:#E7BB41">Disconnect</button>
                <button class="form-action-button" v-if="connected" v-on:click="fillSelfInfos()">My infos</button>
                <button class="form-action-button" v-if="connected" v-on:click="clearFields()">Clear</button>
                <button class="form-action-button" v-if="!connected && !newUser" v-on:click="toggleNewUser()">New user</button>
                <button class="form-action-button" v-if="!connected && newUser" v-on:click="toggleNewUser()">Already registered</button>
            </div>
            <div class="form-row" v-if="connected">
                <p>Connected as {{connectedUsername}}</p>
            </div>
        </div>
    </div>
</template>

<script>

export default {
  name: 'User',
  components: {

  },
  data() {
    return {
        username : "",
        email : "",
        firstname : "",
        lastname : "",
        id : "",
        password : "",
        connected : false,
        connectedUsername: "",
        newUser: false
    }
  },
  updated() {
      console.log("update")
  },
  mounted() {
      this.autoConnect();
  },
  props: {
    // today: Date
  },
  methods: {
    createUser : async function () {
        if (this.checkUsernameAndEmail() != null) {
            alert(this.checkUsernameAndEmail());
            return;
        } 
        const body = {
            user : {
                firstname : this.firstname,
                lastname : this.lastname,
                mail : this.email,
                password : this.password,
                role : 0,
                username : this.username
            }
        }
        const { data } = await this.customFetch("POST", "users/sign_up", body)
        
        if(data.errors) {
            alert("An error occured")
        } else if (data.data) {
            this.id = data.data.id
            this.connect();
        }
    },
    updateUser : async function () {
        if (this.checkUsernameAndEmail() != null) {
            alert(this.checkUsernameAndEmail());
            return;
        } else if (this.id == "") {
            alert("ID must not be blank")
            return;
        }

        let selfInfo = JSON.parse(localStorage.getItem("user"))
        let body = {
            user : {
                firstname : this.firstname,
                lastname : this.lastname,
                mail : this.email,
                password : selfInfo.password,
                role : 0,
                username : this.username,
                changePassword : false,
            }
        }
        const { data } = await this.customFetch("PUT", `users/${this.id}`, body)

        if(data.errors) {
            alert("An error occured")
        } else if (data.data) {
            alert("Successful update")
        }
    },
    getInfos : async function () {
        if (this.id == "") {
            alert("ID must not be blank")
            return;
        }        
        const { data } = await this.customFetch("GET", `users/${this.id}`)
        this.username = data.data.username;
        this.firstname = data.data.firstname;
        this.lastname = data.data.lastname;
        this.email = data.data.mail;
        return data.data;
    },
    async deleteUser() {
        if (this.id == "") {
            alert("ID must not be blank")
            return;
        }
        const {response} = await this.customFetch("DELETE", `users/${this.id}`)
        if(response.status == 204) {
            alert("User deleted successfuly")
        } else if (response.status == 404) {
            alert("User not found")
        } else if (response.status == 401) {
            alert("Unauthorized operation")
        } else {
            alert("An error occured")
        }
    },  
    checkUsernameAndEmail() {
        if(this.email == "" || this.username == "") return "Username and email must not be blank";
        else if (/^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$/.exec(this.email) == null) return "Incorrect email format";
        else return null;
    },
    checkUsernameAndPassword() {
        if(this.username == "" || this.password == "") return "Username or password must not be blank";
        else return null;
    },
    async connect() {
        if (this.checkUsernameAndPassword() != null) {
            alert(this.checkUsernameAndPassword());
            return;
        } 
        const body = {
            username :  this.username,
            password : this.password
        }
        const { response, data } = await this.customFetch("POST", 'users/sign_in', body)

        if(response.status == 404) {
            alert("Bad Username or Password")
        } else if ( response.status == 200) {
            await this.setConnected(data.token)
        } else {
            alert("An error occured")
        }
    },
    disconnect: function () {
        this.setDisconnected();
        this.connected = false;
        this.$router.go("/login")
    },
    checkConnected : function () {
        let jwt = localStorage.getItem("jwt");
        if (jwt) {
            return true;
        } else {
            return false;
        }
    },
    autoConnect: async function () {

        if(this.checkConnected()) {
            this.id = this.getIdFromJwt()
            await this.getInfos();
            this.setConnected();
        }
    },
    setConnected : async function (jwt = null) {
        if (jwt) {
            localStorage.setItem("jwt", jwt)
            let payLoad = this.parseJwt(jwt)
            this.id = payLoad.userID
        }
        let user = await this.getInfos();
        this.newUser = false;
        this.connected = true;
        this.connectedUsername = user.username
        localStorage.setItem("user", JSON.stringify(user))
    },
    setDisconnected : function () {
        this.connected = false;
        this.connectedUsername = "";
        localStorage.removeItem("jwt")
        localStorage.removeItem("user")
    },
    getIdFromJwt : function () {
        let jwt = localStorage.getItem("jwt")
        let infos = this.parseJwt(jwt)
        return infos.userID
    },
    parseJwt : function (token) {
        var base64Url = token.split('.')[1];
        var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        var jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
            return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
        }).join(''));

        return JSON.parse(jsonPayload);
    },
    fillSelfInfos : function() {
        let user = JSON.parse(localStorage.getItem("user"))
        this.username = user.username;
        this.email = user.mail;
        this.firstname = user.firstname;
        this.lastname = user.lastname;
        this.id = user.id;
    },
    clearFields : function() {
        this.username = "";
        this.email = "";
        this.firstname = "";
        this.lastname = "";
        this.id = "";
    },
    toggleNewUser : function () {
        this.newUser = !this.newUser
    }
  }
}
</script>

<style scoped>


</style>
