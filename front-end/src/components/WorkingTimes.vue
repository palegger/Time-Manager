<template>
    <div class="title-container">
        <h1>Current {{ range }} Working Times</h1>
    </div>
    <div id="working-times-container">
        <WorkingTime 
        class="single-working-time" v-for="(workingTime, index) in workingTimes" 
        v-bind:key="index" v-bind:id="workingTime.id"
        v-bind:start="workingTime.start" v-bind:end="workingTime.end"/>
    </div>
</template>
<script>
import WorkingTime from './WorkingTime.vue'
import moment from "moment";

export default {
    name: "WorkingTimes",
    components: {
        WorkingTime
    },
    data : function () {
        return {
            workingTimes : [],
            range : "month"
        }
    },
    mounted : async function () {
        this.workingTimes = await this.getWorkingTimes()
    },
    methods : {
        getWorkingTimes : async function (date = null) {
            if (!date) date = moment(); //Current date
            let start, end;
            if (this.range == "month") {
                start = moment().startOf("month")
                end = moment().endOf("month")
            }
            let startStr = start.format("YYYY-MM-DD HH:mm:ss")
            let endStr = end.format("YYYY-MM-DD HH:mm:ss")
            let user = JSON.parse(localStorage.getItem("user"))
            let body = {
                start : startStr,
                end : endStr
            }
            const { data } = await this.customFetch("POST", `workingtimes/user/${user.id}`, body)

            this.rangeStart = start;
            this.rangeEnd = end;
            return data.data;
        }
    }
}
</script>
<style>
    #working-times-container {
        height: 100%;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-around;
    }
    #working-times-container .single-working-time {
        height: 200px;
        margin: 20px;
    }

    @media screen and (min-width: 640px) {
        #working-times-container {
        margin-left: 50px;
        }
        #working-times-container .single-working-time {
            width: 200px; 
        }
    }
    @media screen and (max-width: 640px) {
        #working-times-container .single-working-time {
            width: calc(50% - 40px); 
        }
    }
</style>
