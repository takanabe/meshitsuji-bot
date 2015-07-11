module.exports = (robot) ->
  robot.respond /HI$/i,(msg)->
    msg.send "PONG"
