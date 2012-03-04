teamcity = require '../lib/teamcity'
should = require 'should'

service_conf = {
   hostname: '',
   username: '',
   password: ''
}

describe 'Teamcity', () ->
   describe '#compute_settings', () ->
      it 'should return settings with short url', (done) ->
         teamcity.test.compute_settings 'id1', undefined, service_conf, (expected) ->
            expected.path.should.include 'add2Queue=id1'
            expected.path.should.not.include 'env.name=BRANCH'
            done()

      it 'should return settings with long url if branch is set', (done) ->
         teamcity.test.compute_settings 'id1', 'branch1', service_conf, (expected) ->
            expected.path.should.include 'add2Queue=id1'
            expected.path.should.include 'env.name=BRANCH&env.value=branch1'
            done()

   describe '#add_2_queue', () ->
      it 'should warn user if configuration problem', (done) ->
         teamcity.test.add_2_queue 'id1', 'branch1', {}, undefined, (message) ->
            message.should.be.ok
            message.should.include 'credentials'
            done()

   describe '#build', () ->
      it 'should call error if no Id is set', (done) ->
         teamcity.build undefined, undefined, undefined, (e) ->
            should.exist e
            should.exist e.message
            done()

