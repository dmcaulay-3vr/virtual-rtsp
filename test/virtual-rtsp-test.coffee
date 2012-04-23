should = require 'should'
net = require 'net'
VirtualRtsp = require '../lib/virtual-rtsp'

describe 'VirtualRtsp', ->
  it 'accepts a connection on the given port', (done) ->
    rtsp = new VirtualRtsp 8000
    client = net.connect 8000, done
