<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimBlock" class="Animation" tilewidth="80" tileheight="96" tilecount="1" columns="0">
 <editorsettings>
  <export target="../../../source/tsj/characters/Kim/KimBlock.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="false"/>
   <property name="frameDuration" type="int" value="3"/>
   <property name="jumpCancellable" type="bool" value="false"/>
   <property name="moveCancellable" type="bool" value="false"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="1048576"/>
   <property name="specialCancellable" type="bool" value="false"/>
   <property name="superCancellable" type="bool" value="false"/>
  </properties>
  <image width="80" height="96" source="../../../source/images/characters/Kim/KimBlock1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" class="Pushbox" x="-6" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>
