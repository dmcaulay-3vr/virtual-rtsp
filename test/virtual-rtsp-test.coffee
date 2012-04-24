should = require 'should'
net = require 'net'
VirtualRtsp = require '../lib/virtual-rtsp'

describe 'VirtualRtsp', ->
  RTSP_REQUEST = 'DESCRIBE rtsp://10.10.2.117/axis-media/media.amp?videocodec=h264&audio=0'

  beforeEach (done) ->
    @camera = net.createServer (conn) =>
      @conn = conn
      done()
    @camera.listen 8001, =>
      @rtsp = new VirtualRtsp 8000, '127.0.0.1', 8001

  afterEach ->
    @rtsp.close()
    @camera.close()

  it 'accepts connections', (done) ->
    client = net.connect 8000, done

  it 'connects to the camera', ->
    @rtsp.camera.remoteAddress.should.equal '127.0.0.1'
    @rtsp.camera.remotePort.should.equal 8001 

  it 'acts as a proxy', (done) ->
    @conn.on 'data', (data) -> 
      data.toString().should.equal RTSP_REQUEST
      done()
    client = net.connect 8000, ->
      client.write RTSP_REQUEST
