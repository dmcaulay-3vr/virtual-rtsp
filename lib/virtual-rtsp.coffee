net = require 'net'

module.exports = class VirtualRtsp
  constructor: (port, cameraAddress, cameraPort, cameraConnect) ->
    @server = net.createServer()
    @server.listen port

    @camera = net.connect cameraPort, cameraAddress, cameraConnect

  close: ->
    @server.close()
    @camera.end()
