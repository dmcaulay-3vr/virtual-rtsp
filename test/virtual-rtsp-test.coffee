events = require 'events'
net = require 'net'

VirtualRtsp = require '../lib/virtual-rtsp'

should = require 'should'
sinon = require 'sinon'

describe 'VirtualRtsp', ->
  RTSP_REQUEST = 'DESCRIBE rtsp://10.10.2.117/axis-media/media.amp?videocodec=h264&audio=0'

  beforeEach ->
    @stubServer = listen: sinon.spy()
    (sinon.stub net, 'createServer').returns @stubServer

    @stubCamera = {}
    (sinon.stub net, 'connect').returns @stubCamera

    @rtsp = new VirtualRtsp net, 8000, '127.0.0.1', 8001

  afterEach ->
    net.createServer.restore()
    net.connect.restore()

  it 'creates a server', ->
    net.createServer.calledOnce.should.be.true

  it 'listens on the given port', ->
    @stubServer.listen.calledOnce.should.be.true
    @stubServer.listen.calledWith(8000).should.be.true

  it 'adds connections when a new connection arrives', ->
    sinon.spy @rtsp, 'addConnection'
    connection = new events.EventEmitter
    net.createServer.firstCall.args[0](connection)
    @rtsp.addConnection.calledOnce.should.be.true
    @rtsp.addConnection.calledWith(connection).should.be.true

  it 'connects to the camera', ->
    net.connect.calledOnce.should.be.true
    net.connect.calledWith(8001, '127.0.0.1').should.be.true

  it 'adds the first connection as a proxy', ->
    sinon.spy @rtsp, 'addAsProxy'
    client = new events.EventEmitter
    @rtsp.addConnection client
    @rtsp.addAsProxy.calledOnce.should.be.true
    @rtsp.addAsProxy.calledWith(client).should.be.true

  it 'adds other connections as listeners', ->
    sinon.spy @rtsp, 'addAsProxy'
    sinon.spy @rtsp, 'addAsListener'
    c1 = new events.EventEmitter
    @rtsp.addConnection c1
    @rtsp.addAsProxy.calledOnce.should.be.true
    @rtsp.addAsProxy.calledWith(c1).should.be.true
    c2 = new events.EventEmitter
    @rtsp.addConnection c2
    @rtsp.addAsListener.calledWith(c2).should.be.true
    c3 = new events.EventEmitter
    @rtsp.addConnection c3
    @rtsp.addAsListener.calledWith(c3).should.be.true
    @rtsp.addAsListener.calledTwice.should.be.true

