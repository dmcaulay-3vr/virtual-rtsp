should = require 'should'
net = require 'net'
VirtualRtsp = require '../lib/virtual-rtsp'

describe 'VirtualRtsp', ->
  beforeEach (done) ->
    @rtsp = new VirtualRtsp 8000, '10.10.2.118', 554, done

  afterEach ->
    @rtsp.close()

  it 'accepts connections', (done) ->
    client = net.connect 8000, done

  it 'connects to the camera', ->
    @rtsp.camera.remoteAddress.should.equal '10.10.2.118'
    @rtsp.camera.remotePort.should.equal 554
