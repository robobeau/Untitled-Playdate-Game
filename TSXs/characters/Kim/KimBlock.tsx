<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimBlock" class="Animation" tilewidth="80" tileheight="96" tilecount="1" columns="0">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimBlock.lua" format="lua"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="4194304"/>
  </properties>
  <image width="80" height="96" source="../../../source/characters/Kim/images/KimBlock1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="10" y="16" width="40" height="80"/>
   <object id="3" name="Center" type="Center" x="30" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
