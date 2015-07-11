expect = require('chai').expect

Robot       = require('hubot/src/robot')
TextMessage = require('hubot/src/message').TextMessage

describe 'hi', ->
  robot = null
  user = null
  adapter = null

  beforeEach (done) ->
    robot = new Robot(null, 'mock-adapter', false, 'hubot')

    robot.adapter.on 'connected', ->
      require('../scripts/hi')(robot)
      user = robot.brain.userForId '1',
        name: 'mocha'
        room: '#mocha'
      adapter = robot.adapter
      done()
    robot.run()

  afterEach -> robot.shutdown()

  it 'responds "Hi"', (done) ->
    adapter.on 'reply', (envelope, strings) ->
      expect(envelope.user.name).to.equal('mocha')
      expect(strings[0]).to.equal("Hi I'm meshi tsuji bot")
      done()

    adapter.receive(new TextMessage(user, 'hubot Hi'))
