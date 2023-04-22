<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimBlockAirborne" class="Animation" tilewidth="64" tileheight="80" tilecount="1" columns="0">
 <editorsettings>
  <export target="../../../source/tsj/characters/Kim/KimBlockAirborne.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" class="Frame">
  <properties>
   <property name="airborne" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="3"/>
   <property name="moveCancellable" type="bool" value="false"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="1"/>
  </properties>
  <image width="64" height="80" source="../../../source/images/characters/Kim/KimBlockAirborne1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" class="Pushbox" x="-6" y="-4" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>
