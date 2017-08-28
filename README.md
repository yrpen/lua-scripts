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
  * take a look at http://www.xtibia.com/forum/topic/241890-addon-system-fly-ride-surf-look-e-evolution/
  * potions used by monsters [hyperlink censored due otland blacklist]
  * additional attacks

## Options inside pet\_lib.lua
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
    * PLAYER\_SHARE\_EXPERIENCE = false,
    * DUELS\_ONLY = false

## FAQ
_**1. How summon and unsummon pet?**_  
Join / leave pet channel.  
  
_**2. How turn on/off some features?**_  
Check values inside PETS.SYSTEM table.  
  
_**3. How create custom pet?**_  
_**3a) Create monster xml file**_  
Put file inside /monsters/pets directory  
Remember about set convinceable flag to 1  
```
<flag convinceable="1"/>
```
  
_**3b) Register xml file in monsters.xml**_  
Register monster name with prefix from script (default _"PET\_"_)  
Example:  
```
<monster name="PET_Cat" file="pets/cat.xml"/>
```
  
_**3c) Create table in pet\_lib.lua**_  
Add pet in table with new unique number in lib file  
Example:  
```
  [19] = {
    name = "Test",
    health = 1000,
    hpAdd = 10,
    mountId = 3,
    evolve = {
      to = 1,
      at = 5
    },
    check = function(player) return player:getPremiumDays() > 0 and player:getLevel() >= 25 and player:isSorcerer() end,
    info = "Test pet additional description."
  }
```
Options:  
  * name - monster type name, set in monster.xml in monsters/pets directory
  * health - base health value
  * hpAdd - additional maximal health points on level up (default 5)
  * mountId - id mount added, when player tame pet
  * evolve.at - at this level pet will evolve
  * evolve.to - identification id of transformed pet type after evolution
  * check - check if player can tame pet (function or boolean value)
  * info - additional onLook description
  
_**4. How work teleport system?**_  
If distance between a pet and player is higher than 7 sqm or pet is on diffrent floor level,  
then script teleport pet to owner position.  
  
_**5. Mount system**_  
_**5a) How it work?**_  
When player catch monster with mount id in configuration, then mount is added to him.  
Player can't mount dead pet and can't in same time ride on him and use as summon.  
When player summon pet, then this pet-summon is removed from player mounts list.  
  
_**5b) Does mount system work only on premium players?**_  
Yes.  
  
_**6. Player share experience**_  
If it's set to true, then pet get exp everytime, when player gets exp.  
  
_**7. Duels only**_  
If it's set to true, then pet can't attack any player.
  
## Installation
add on bottom _**data/lib/lib.lua**_  
```
dofile('data/lib/pets_lib.lua')
```
  
put file _**pets\_lib.lua**_ into directory _**data/lib/**_  
  
add in _**data/chatchannels/chatchannels.xml**_  
```
<channel id="10" name="Pet" script="pet.lua" />
```

add in _**data/creaturescripts/creaturescripts.xml**_  
```
<event type="preparedeath" name="PetDeath" script="pet_creaturescript.lua" />
<event type="kill" name="PetKill" script="pet_creaturescript.lua" />
<event type="think" name="PetTeleport" script="pet_creaturescript.lua" />
 
 
<event type="login" name="PetOwnerLogin" script="pet_owner_creaturescripts.lua" />
<event type="logout" name="PetOwnerLogout" script="pet_owner_creaturescripts.lua" />
<event type="preparedeath" name="PetOwnerDeath" script="pet_owner_creaturescripts.lua" />
```

add in _**data/talkactions/talkactions.xml**_  
```
<talkaction words="!petadd" separator=" " script="pet_add.lua" />
<talkaction words="!petcatch" script="pet_catch.lua" />
<talkaction words="!petcommands" script="pet_commands.lua" />
<talkaction words="!petheal" script="pet_heal.lua" />
<talkaction words="!petrelease" script="pet_release.lua" />
<talkaction words="!petrevive" script="pet_revive.lua" />
<talkaction words="!petinfo" script="pet_status.lua" />
```

add in _**data/monster/monsters.xml**_  
```
    <monster name="PET_Cat" file="pets/cat.xml"/>
    <monster name="PET_Dog" file="pets/dog.xml"/>
    <monster name="PET_Husky" file="pets/husky.xml"/>
    <monster name="PET_Wolf" file="pets/wolf.xml"/>
    <monster name="PET_War Wolf" file="pets/war wolf.xml"/>
    <monster name="PET_Bear" file="pets/bear.xml"/>
    <monster name="PET_Seagull" file="pets/seagull.xml"/> <!-- -->
    <monster name="PET_Parrot" file="pets/parrot.xml"/>
    <monster name="PET_Chicken" file="pets/chicken.xml"/>
    <monster name="PET_Sheep" file="pets/sheep.xml"/>
    <monster name="PET_Elephant" file="pets/elephant.xml"/>
 
    <monster name="PET_Lion" file="pets/lion.xml"/>
    <monster name="PET_Tiger" file="pets/tiger.xml"/>
    <monster name="PET_Penguin" file="pets/penguin.xml"/> <!-- -->
    <monster name="PET_Mechanic Golem" file="pets/mechanic golem.xml"/>
    <monster name="PET_Undead Slave" file="pets/undead slave.xml"/>
    <monster name="PET_Stronger Husky" file="pets/stronger husky.xml"/>
    <monster name="PET_Black Sheep" file="pets/black sheep.xml"/>
 
    <monster name="PET_Mammoth" file="pets/mammoth.xml"/>
    <monster name="PET_Snake" file="pets/snake.xml"/>
    <monster name="PET_Cobra" file="pets/cobra.xml"/>
```

Change name of _**pets\_channels.lua**_ to _**pet.lua**_ and put in _**data/chatchannels/scripts/**_  
Put _**pet/_owner/_creaturescripts.lua**_ and _**pet\_creaturescript.lua**_ in _**data/creaturescripts/scripts/**_  
Copy scripts from _**talkactions_** directory to _**data/talkactions/scripts/**_ 
Copy directory _**pets**_ from monsters directory to _**data/monsters/**_  


Change in _**data/events/events.xml**_

```
<event class="Creature" method="onTargetCombat" enabled="1" />
<event class="Player" method="onGainExperience" enabled="1" />
```

add content of _**player\_on\_gain\_experience.lua**_ and _**pet\_look.lua**_ into _**data/events/scripts/player.lua**_  
add content of _**creature\_on\_target\_combat.lua**_ into _**data/events/scripts/creature.lua**_

