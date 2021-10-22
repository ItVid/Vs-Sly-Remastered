function stepHit(step)
    if step == 1 then 
        for i = 0, 3 do 
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 1000, getActorAngle(i) - 360, 0.05, i)
            tweenFadeIn(i, 0, 0.05)
        end
        for i = 4, 7 do 
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 275, getActorAngle(i) - 360, 0.05, i)
        end
    end
end
