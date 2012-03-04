teamcity = require '../lib/teamcity'
should = require 'should'

describe 'Teamcity', () ->
   describe '#add_2_queue', () ->
      it 'should return settings with short url', (done) ->
         teamcity.test.add_2_queue 'id1', undefined, (expected) ->
            expected.path.should.include 'add2Queue=id1'
            expected.path.should.not.include 'env.name=BRANCH'
            done()

      it 'should return settings with long url if branch is set', (done) ->
         teamcity.test.add_2_queue 'id1', 'branch1', (expected) ->
            expected.path.should.include 'add2Queue=id1'
            expected.path.should.include 'env.name=BRANCH&env.value=branch1'
            done()

   describe '#build', () ->
      it 'should call error if no Id is set', (done) ->
         teamcity.build undefined, undefined, undefined, (e) ->
            should.exist e
            should.exist e.message
            done()

