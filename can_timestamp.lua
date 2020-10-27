
-- Manually add a timestamp to received CAN and write to csv
-- This is not very precise since messages have a transmission delay through the server
-- but it should be fine for some purposes.

inittime = 0;
file = nil

function rics_init()
  file = io.open( "log.csv", 'w' )
  io.output(file)
  io.write("Timestamp, CAN ID, Data")
  return true
end


function rics_start(svr, node) -- Called on server connection (node is your node number)
  inittime = svr:get_time_ms()
  return true
end


function rics_can_callback(svr, id, data) -- Called when a can message is received
  local ts = svr:get_time_ms()
  local str = (ts - inittime) .. ", " .. id
  for i = 1,#data do
    str = str .. ", " .. data[i]
  end
  io.write(str .. "\n")
  return true
end

function rics_update(svr) return true end
