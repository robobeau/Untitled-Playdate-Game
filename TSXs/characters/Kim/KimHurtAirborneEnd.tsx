<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimHurtAirborneEnd" class="Animation" tilewidth="128" tileheight="80" tilecount="4" columns="0">
 <editorsettings>
  <export target="../../../source/tsj/characters/Kim/KimHurtAirborneEnd.lua" format="lua"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="128" height="80" source="../../../source/characters/Kim/images/KimHurtAirborneEnd1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="44" y="18" width="40" height="42"/>
   <object id="2" name="Center" type="Center" x="64" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="duration" type="int" value="1"/>
  </properties>
  <image width="128" height="80" source="../../../source/characters/Kim/images/KimHurtAirborneEnd2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="44" y="18" width="40" height="42"/>
   <object id="2" name="Center" type="Center" x="64" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="duration" type="int" value="1"/>
   <property name="velocityX" type="int" value="-1"/>
  </properties>
  <image width="128" height="80" source="../../../source/characters/Kim/images/KimHurtAirborneEnd3.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="5" name="Pushbox" type="Pushbox" x="44" y="18" width="40" height="42"/>
   <object id="4" name="Center" type="Center" x="64" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="duration" type="int" value="5"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="32768"/>
  </properties>
  <image width="128" height="80" source="../../../source/characters/Kim/images/KimHurtAirborneEnd3.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="44" y="18" width="40" height="42"/>
   <object id="3" name="Center" type="Center" x="64" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
