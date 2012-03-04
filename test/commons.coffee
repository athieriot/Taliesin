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

   describe '#init_logger', () ->
      it 'should initialize the logger', () ->
         commons.init_logger()
         should.exist commons.logger

      it 'should set verbose level if needed', () ->
         commons.init_logger(true)
         should.exist commons.logger
         commons.logger.transports['console'].level.should.equal 'verbose'
