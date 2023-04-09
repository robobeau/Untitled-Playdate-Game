<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimKnockdown" class="Animation" tilewidth="112" tileheight="48" tilecount="1" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimKnockdown.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="10"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="262144"/>
  </properties>
  <image width="112" height="48" source="../../../source/images/characters/Kim/KimKnockdown1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="20" y="-40" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>
