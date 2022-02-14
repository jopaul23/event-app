const mongoose = require('mongoose')

const eventSchemaa = mongoose.Schema({
    name : {
        type :String,
        min :1,
        max : 255,
        required : [true,"name required"]
    },
    userEmail : {
        type :String,
        required: [true,"email required"],
        min :10,
        max : 255,
    },
    school:{
        type:String,
        required:[true,"school required"]
    },
    startingTime : {
        type :Date,
    },
    endingTime:{
        type : Date,
    },
    startingLocation:{
        type: String
    },
    endingLocation:{
        type:String,
    }
});

module.exports = mongoose.model("Event",eventSchemaa)