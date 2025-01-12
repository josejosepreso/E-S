module Config
  ( batPath
  , batCapacityKey
  , batStatusKey
  , oneGB
  , memPath
  , memTotalKey
  , memAvailableKey
  ) where

batPath = "/sys/class/power_supply/BAT0/uevent"
batCapacityKey = "POWER_SUPPLY_CAPACITY"
batStatusKey = "POWER_SUPPLY_STATUS"
oneGB :: Float
oneGB = 9.5367431640625e-7
memPath = "/proc/meminfo"
memTotalKey = "MemTotal:"
memAvailableKey = "MemAvailable:"
