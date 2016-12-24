gpio.mode(2, gpio.INPUT, gpio.PULLUP)
network_message = require "network_message" 
last_state = nil
states = {}
states[0]="detect.light"
states[1]="detect.dark"

srv=net.createConnection(net.UDP, 0)
srv:connect(SERVER_PORT, wifi.sta.getbroadcast())

svr = net.createServer(net.UDP) 
svr:on("receive", function(socket, message)
    message = network_message.decodeMessage(message)
    if message ~= nil and message.event ~= nil then
        if message.event == "state" then     
            data = network_message.prepareMessage()
            data.response = states[last_state]   
            network_message.sendMessage(socket, data)                            
        end
    end    
end)

svr:listen(5053)      

function sendEvent(event)  
    data = network_message.prepareMessage()
    data.event = event   
    network_message.sendMessage(srv, data)    
end

tmr.alarm(2, 500, 1, function()  
    current_state = gpio.read(2)
    if last_state ~= current_state then        
        last_state = current_state
        sendEvent(states[current_state])   
    end
end)
