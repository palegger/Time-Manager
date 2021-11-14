<template>
    <div class="card-template">
        <div class="card-header">
            Working time #{{id}}
        </div>
        <div class="card-body">
            <p>{{formatDate(start)}}</p>
            <p>{{formatDate(end)}}</p>
        </div>
    </div>
</template>
<script>
import moment from "moment";
export default {
    name: "WorkingTime",
    props : {
        id : Number,
        start : String,
        end : String
    },
    data : function () {
        return {
        }
    },
    created : function () {
    },
    methods : {
        formatDate : function (dateStr) {
            return moment(dateStr).format("DD/MM/YYYY HH[h]mm")
        }
    }
}
</script>
