
module.exports = class VirtualRtsp
  constructor: (net, port, cameraAddress, cameraPort) ->
    @server = net.createServer (c) =>
      @addConnection c
    @server.listen port

    @camera = net.connect cameraPort, cameraAddress

  close: ->
    @server.close()
    @camera.end()

  addConnection: (c) ->
    @connections ||= new Array()
    if @connections.length is 0
      @addAsProxy c
    else
      @addAsListener c
    @connections.push c

  addAsProxy: (c) ->
    c.on 'data', (data) =>
      @camera.write data

  addAsListener: (c) -> 

