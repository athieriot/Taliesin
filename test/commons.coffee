commons = require '../lib/commons'
should = require 'should'

describe 'Commons', () ->
   describe '#configuration', () ->
      it 'should not return undefined', (done) ->
         commons.configuration (expected) ->
            should.exist(expected)
            done()
         , 'dontexist', false

      it 'should return properties in a file', (done) ->
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

   describe '#valid_properties', () ->
      it 'should return true if all present', () ->
         valid_one = {test: 'ok', other: 'ok'}
         expected = commons.valid_properties valid_one, 'test', 'other'
         expected.should.be.true
      it 'should return false if at least one miss', () ->
         valid_one = {test: 'ok', other: 'ok'}
         expected = commons.valid_properties valid_one, 'missing', 'test', 'other', 'yo'
         expected.should.not.be.true
