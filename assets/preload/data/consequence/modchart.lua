local softBump = false 
local strongBump = false 

function beatHit (beat)
    if softBump then 
        setCamZoom(0.95)
    end
    if strongBump then 
        setCamZoom(1)
    end
end

function stepHit (step)
    if step == 256 then 
        setCamZoom(0.95)
        softBump = true 
    end
    if step == 512
    or step == 1056 then 
        setCamZoom(1)
        strongBump = true 
        softBump = false 
    end
    if step == 768
    or step == 1280 then 
        setCamZoom(0.95)
        softBump = true 
        strongBump = false 
    end
    if step == 1792 then 
        softBump = false 
        strongBump = false 
    end
end
