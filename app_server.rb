 require 'socket'

 webserver = TCPServer.new('127.0.0.1', 7000)
 while (session = webserver.accept)
    session.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"
    request = session.gets
    trimmedrequest = request.gsub(/GET\ \//, '').gsub(/\ HTTP.*/, '')
    filename = trimmedrequest.chomp 
    require './root.rb'
    @paths.each do |path|
    if filename == path
       filename = "views/#{path}.html" 
       puts "serving #{filename} at port 7000" rescue puts "error"
    elsif filename == ''
       filename = "views/index.html"
    end
   
    end

    begin
       displayfile = File.open(filename, 'r')
       content = displayfile.read()
       session.print content
    rescue Errno::ENOENT
       session.print "File not found"
    end
    session.close
 end

