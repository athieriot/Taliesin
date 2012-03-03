teamcity = require '../lib/teamcity'

describe 'Teamcity', () ->
   describe '#add_2_queue', () ->
      it 'should return settings with short url', () ->
         expected = teamcity.test.add_2_queue 'id1'
         expected.path.should.include 'add2Queue=id1'
         expected.path.should.not.include 'env.name=BRANCH'
      it 'should return settings with long url if branch is set', () ->
         expected = teamcity.test.add_2_queue 'id1', 'branch1'
         expected.path.should.include 'add2Queue=id1'
         expected.path.should.include 'env.name=BRANCH&env.value=branch1'
