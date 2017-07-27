-- Connect to the wifi network using wifi module
wifi.setmode(wifi.STATION)  
wifi.sta.config(wifi_ssid, wifi_password)  
wifi.sta.connect()

-- Establish MQTT client
m = mqtt.Client(node.chipid(), 120, mqtt_username, mqtt_password)

-- Read out DHT22 sensor using dht module
function func_read_dht()  
  status, temp, humi, temp_dec, humi_dec = dht.read(4)
  mqinfo = adc.read(0)
  if( status == dht.OK ) then
-- Integer firmware using this example
    --print("DHT Temperature: "..math.floor(temp).."."..temp_dec.." C")
    mqtt_temp = math.floor(temp).."."..temp_dec
    --print("DHT Humidity: "..math.floor(humi).."."..humi_dec.." %")
    mqtt_humi = math.floor(humi).."."..humi_dec
-- Float firmware using this example
--    print("DHT Temperature: "..temp.." C")
--    print("DHT Humidity: "..humi.." %")
  elseif( dht_status == dht.ERROR_CHECKSUM ) then          
    print( "DHT Checksum error" )
  elseif( dht_status == dht.ERROR_TIMEOUT ) then
    print( "DHT Time out" )
  end
end

-- Publish temperature readings and activate deep sleep
function func_mqtt_pub()
  m:close();  
  m:connect(mqtt_broker_ip, mqtt_broker_port, 0, function(client) print("Connected to MQTT broker")
    m:publish("/climate/master_bedroom/temperature","[{".."'action'"..": ".."'GET'"..", ".."'value'"..": "..mqtt_temp.."}]",0,0, function(client) print("Master bedroom temp message published")  
    m:publish("/climate/master_bedroom/humidity","[{".."'action'"..": ".."'GET'"..", ".."'value'"..": "..mqtt_humi.."}]",0,0, function(client) print("Master bedroom humi message published")  
    m:publish("/climate/master_bedroom/CO2","[{".."'action'"..": ".."'GET'"..", ".."'value'"..": "..mqtt_co2.."}]",0,0, function(client) print("Master bedroom CO2 message published")  
    m:publish("/climate/master_bedroom/pressure","[{".."'action'"..": ".."'GET'"..", ".."'value'"..": "..mqtt_pres.."}]",0,0, function(client) print("Master bedroom pressure message published")  
    end)
    end)
    end)
    end)
  end)
  m:close();
end

function func_get_co2()
    mqtt_co2 = carbon
end

-- Capture and publish sensor reading and enter deep sleep
function func_exec_loop()  
  if wifi.sta.status() == 5 then  --STA_GOTIP
    print("Connected to "..wifi.sta.getip())
    dofile('co2.lua')
    func_read_dht() --Retrieve from temp\humi sensor data
    func_get_co2() --Retrieve from CO2 sensor data
    func_mqtt_pub() --Publish MQTT messages
    mqtt_pres = get_pres()
    str1=" IP: "..wifi.sta.getip()..""
    str2=" Temp is: "..mqtt_temp.." C"
    str3=" Humi is: "..mqtt_humi.." %" 
    str4=" CO2  is: "..mqtt_co2.." ppm" 
    str5=" Pres is: "..mqtt_pres.." mmHg"
    init_OLED(sda,scl)
    print_OLED() 
  else
    print("Still connecting...")
  end
end

tmr.alarm(1,30000,tmr.ALARM_AUTO,function() func_exec_loop() end)  
