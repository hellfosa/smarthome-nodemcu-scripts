ppm = 0
local h = 0
local l = 0
local tl = 0
local th = 0
local c = 0
    
function pin1cb(level)
    carbon = 0
    local tt = tmr.now() / 1000;
 
    
    if level == 1 then
        h = tt;
        tl = h - l;
        ppm = 5000 * (th - 2) / (th + tl - 4)
    else
        l = tt;
        th = l - h;
        ppm = 5000 * (th - 2) / (th + tl - 4)
    end

    if c > 3 then gpio.mode(3, gpio.INPUT)
        print('co2:', ppm)
        carbon = ppm
        return ppm, carbon
    end
    c = c + 1

    if level == 1 then gpio.trig(3, "down") else gpio.trig(3, "up") end
end

function get_co2(co2_pin)
    gpio.mode(co2_pin, gpio.INT)
    gpio.trig(co2_pin, "up", pin1cb)
    return ppm, carbon
end

get_co2(co2_pin)
