# build time tests for tally plugin
# see http://mochajs.org/

tally = require '../client/tally'
expect = require 'expect.js'

describe 'tally plugin', ->

  describe 'expand', ->

    it 'can make itallic', ->
      result = tally.expand 'hello *world*'
      expect(result).to.be 'hello <i>world</i>'
