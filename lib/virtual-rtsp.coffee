net = require 'net'

module.exports = class VirtualRtsp
  constructor: (port, cameraAddress, cameraPort) ->
    @server = net.createServer (c) =>
      c.on 'data', (data) =>
        @camera.write data
    @server.listen port

    @camera = net.connect cameraPort, cameraAddress

  close: ->
    @server.close()
    @camera.end()
