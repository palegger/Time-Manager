<template>
    <div id="team-container">
        <div class="card-template">
            <div class="card-header title">
                Team management
            </div>
            <div class="card-body form-container">
                <div class="form-row">
                    <label class="label-choice">Create your team</label>
                    <label class="label-choice">Join existing team</label>
                </div>
                <div class="form-row">
                    <input v-model="inputTeamName" placeholder="Your team name" type="text">
                    <input v-model="inputTeamId" placeholder="The team ID" type="text">
                </div>  
                <div class="form-row">
                    <button v-on:click="createTeam()" class="form-action-button">Create</button>
                    <button v-on:click="joinTeam(inputTeamId)" class="form-action-button">Join</button>
                </div>  
            </div>
        </div>

        <div id="teams-container">
            <div v-for="(team, index) in teams" v-bind:key="index" class="card-template team-card">
                <div class="card-header">
                    Team #{{team.id}}
                </div>
                <div class="card-body">
                    {{team.name}}
                </div>
            </div>
        </div>
    </div>
</template>
<script>

export default {
    name: "Team",
    props : {
    
    },
    data : function () {
        return {
            inputTeamName : "",
            inputTeamId : "",
            teams : []
        }
    },
    created : function () {
        this.refreshTeamList();
    },
    methods : {
        createTeam : async function () {
            const { response, data } = await this.customFetch("POST", `teams/${this.inputTeamName}`)
            if (response.status == 201 || response.status == 200) {
                this.inputTeamName = ""
                await this.joinTeam(data.data.id);
            } else if(response.status == 401) {
                alert("You don't have the necessary rights")
            } else {
                alert("The team could not be created")
            }
        },
        joinTeam : async function (teamId) {
            let user = JSON.parse(localStorage.getItem("user"))

            const { response } = await this.customFetch("POST", `teams/add/${teamId}/${user.id}`)
            if (response.status == 201) {
                console.log("You are now part of team "+teamId)
                this.refreshTeamList();
            } else {
                alert("Could not join team #"+teamId+". \nError occured")
            }
        },
        refreshTeamList : async function () {
            this.teams = [];

            let user = JSON.parse(localStorage.getItem("user"))

            const { response, data } = await this.customFetch("GET", `/teams/teams/${user.id}`)
            
            if(response.status == 200) {
                if (data.data.length > 0 )
                    data.data.forEach( team => {
                        this.getTeamInfos(team.teamID);
                    })
            }
        },
        getTeamInfos : async function (teamId) {
            const { response, data } = await this.customFetch("GET", `teams/${teamId}`)
            if(response.status == 200) {
                this.teams.push(data.data)
                return data.data
            }
            else return null;
        }
    }
}
</script>
<style scoped>
    #team-container {
        padding: 50px 0px;
    }

    .label-choice {
        display: flex 0 0 50%;
        text-align: center;
    }



    #teams-container {
        height: auto;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-around;
        padding-top: 50px;
    }
    #teams-container .single-team {
        height: 200px;
        margin: 20px;
    }
    .team-card {
        margin: 10px 0px;
        width: 10em;
    }
    @media screen and (min-width: 640px) {
        #teams-container .single-team {
            width: 200px; 
        }
    }
    @media screen and (max-width: 640px) {
        #teams-container .single-team {
            width: calc(50% - 40px); 
        }
    }
</style>
