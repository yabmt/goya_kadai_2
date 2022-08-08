require 'webrick'

server = WEBrick::HTTPServer.new({
  :DocumentRoot => '/',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'goya_kadai.html.erb')

server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')

server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')

server.mount('/goya_not_self.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya_not_self.rb')

server.mount('/goya_bad.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya_bad.rb')

server.start
