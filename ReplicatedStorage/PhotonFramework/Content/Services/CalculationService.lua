-- Madonox
-- 2022

-- Used https://devforum.roblox.com/t/modeling-a-projectiles-motion/176677 for reference here.

local Service = {}

local WorldGravity = Vector3.new(0,-workspace.Gravity,0)
function Service:GetProjectileMotionAtTime(timeValue:number,projectileInitialPosition:Vector3,projectileInitialVelocity:Vector3)
	return .5 * WorldGravity * timeValue * timeValue + projectileInitialVelocity * timeValue + projectileInitialPosition
end

return Service