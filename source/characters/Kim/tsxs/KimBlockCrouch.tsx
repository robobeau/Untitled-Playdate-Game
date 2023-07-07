<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimBlockCrouch" class="Animation" tilewidth="64" tileheight="80" tilecount="1" columns="0">
 <editorsettings>
  <export target="../../../source/tsj/characters/Kim/KimBlockCrouch.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="32"/>
  </properties>
  <image width="64" height="80" source="../images/KimBlockCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="6" y="-4" width="40" height="84"/>
   <object id="3" name="Center" type="Center" x="26" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
