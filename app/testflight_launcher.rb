# This file is automatically generated. Do not edit.

if Object.const_defined?('TestFlight') and !UIDevice.currentDevice.model.include?('Simulator')
  NSNotificationCenter.defaultCenter.addObserverForName(UIApplicationDidBecomeActiveNotification, object:nil, queue:nil, usingBlock:lambda do |notification|
  TestFlight.takeOff('963a0ea9ca6d6a52ff400a4030a9574e_MTUwOTE0MjAxMi0xMS0wMyAwMDo0Nzo0Ni4zMDc1OTM')
  end)
end