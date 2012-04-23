net = require 'net'

module.exports = class VirtualRtsp
  constructor: (port) ->
    @server = net.createServer()
    @server.listen port
