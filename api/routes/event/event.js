const router = require("express").Router();
const { response } = require("express");
const Event = require("../../models/event");
const { route } = require("../auth/auth");
const authVerify = require("../auth/authVerify");


router.post("/post-event", authVerify, async (req, res) => {
  try {
    const event = new Event({
      userEmail: req.body.userEmail,
      name: req.body.name,
      startingLocation: req.body.startingLocation,
      endingLocation: req.body.endingLocation,
      startingTime: req.body.startingTime,
      endingTime: req.body.endingTime,
    });
    const savedEvent  = await event.save();
    return res.sendStatus(200)
  } catch (e) {
      console.log("Catched with exception ",e)
    return res.sendStatus(400);
  }
});


router.post('/get-events',authVerify,async (req,res)=>{
    try{
        const   result  =await Event.find(req.body)
        console.log(result)
        return res.status(200).send(result)
    }catch(e){
        console.log("catched ",e )
        return res.status(400)
    }
})

module.exports = router