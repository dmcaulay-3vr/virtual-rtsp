should = require 'should'
net = require 'net'
VirtualRtsp = require '../lib/virtual-rtsp'

describe 'VirtualRtsp', ->
  beforeEach (done) ->
    @rtsp = new VirtualRtsp 8000, '127.0.0.1', 8001, done
    @camera = net.createServer()
    @camera.listen 8001

  afterEach ->
    @rtsp.close()
    @camera.close()

  it 'accepts connections', (done) ->
    client = net.connect 8000, done

  it 'connects to the camera', ->
    @rtsp.camera.remoteAddress.should.equal '127.0.0.1'
    @rtsp.camera.remotePort.should.equal 8001 
