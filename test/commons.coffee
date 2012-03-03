commons = require '../lib/commons'
should = require 'should'

describe 'Commons', () ->
   describe '#configuration', () ->
      it 'should not return undefined', (done) ->
         commons.configuration (expected) ->
            should.exist(expected)
            done()
         , 'dontexist', false
      it 'should return properties', (done) ->
         commons.configuration (expected) ->
            expected.should.have.property 'key', 'value'
            done()
         , './test/commons.properties', false
