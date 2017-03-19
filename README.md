# lua-scripts
  * Pet system

# Pet system
## Features
  * pet channel
    * summon pet on join channel
    * unsumon pet on leave channel
  * scripted pet die / revive / release / catch / heal
  * pet leveling up
    * pet evolves (default **enabled**)
  * custom pet requiements (configurable on each pet)
  * pet have green skull
  * catch pet and get mount! (default **disabled**)
  * teleport pet, when is too far away or you changed floor (default **enabled**)
  * pet have same speed as player (default **enabled**)
  * pet heal on level up (default **enabled**)

## Planned features
  * set pet name [there should be sth like setStringStorageValue, etc.]
  * command !pettransfer, for player exchange
  * hunger system
  * carry items

## Options inside pet_lib.lua
  * PETS.CONFIG
    * sameSpeed = true,
    * healOnLevelUp = true,
    * standardHpAdd = 5,
    * expMultipler = 1,
    * maxLevel = 10,
    * reviveSoulBaseCost = 50,
    * reviveSoulLevelCost = 0.2
  
  * PETS.SYSTEM
    * EVOLUTION = true,
    * MOUNTS = false,
    * TELEPORT = true

## FAQ
_**1. How summon and unsummon pet?**_  
Join / leave pet channel.  
  
_**2. How work teleportation system?**_  
If distance between a pet and player is higher than 7 sqm or pet is on diffrent floor level,  
then script teleport pet to owner position.  
  
_**3. Mount system**_  
_**3a) How it work?**_  
When player catch monster, and monster have in configuration set mount id, then mount is added to player.  
Player can't mount dead pet and can't in same time ride on him and use as summon.  
When player summon pet, then this pet-summon is removed from player mounts list.  
  
_**3b) Does mount system work only on premium players?**_  
Yes.  
  
_**4. How create custom pet?**_  
Create monster xml file.  
Register xml file in monsters.xml.  
Create table in pet_lib.lua  
**Clarify this!**
  

