
function get_pres()
    bme280 = require("bme280");
    bme280.init(SDA_pre, SCL_pre);
    bme280.read(OSS);
    print("try to get baro");
    p = bme280.baro();
    while p == nil do
        print('Baro is nil');
        p = bme280.baro();
        if p ~= nil then print(p); break; end;
    end
    return (p * 75 / 100000).."."..((p * 75 % 10000) / 1000)
end
-- temperature in degrees Celsius  and Farenheit
--print("Temperature: "..(t/100).."."..(t%10).." deg C")
--print("Humididy: "..(humi).." %")

-- pressure in differents units
--print("Pressure: "..(p / 10).." Pa")
--print("Pressure: "..(p / 1000).."."..(p % 100).." hPa")
--print("Pressure: "..(p / 1000).."."..(p % 100).." mbar")
--print("Pressure: "..(p * 75 / 100000).."."..((p * 75 % 10000) / 1000).." mmHg")

-- release module
--bme280 = nil
--package.loaded["bme280"]=nil

