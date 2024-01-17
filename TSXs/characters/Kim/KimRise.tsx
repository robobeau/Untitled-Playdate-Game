<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimRise" class="Animation" tilewidth="112" tileheight="96" tilecount="4" columns="0">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimRise.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="112" height="96" source="../../../source/characters/Kim/images/KimRise1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="40" y="6" width="40" height="84"/>
   <object id="2" name="Center" type="Center" x="60" y="90">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="112" height="96" source="../../../source/characters/Kim/images/KimRise2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="36" y="12" width="40" height="84"/>
   <object id="2" name="Center" type="Center" x="56" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="112" height="96" source="../../../source/characters/Kim/images/KimRise3.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="36" y="12" width="40" height="84"/>
   <object id="2" name="Center" type="Center" x="56" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="4194304"/>
  </properties>
  <image width="112" height="96" source="../../../source/characters/Kim/images/KimRise4.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="36" y="12" width="40" height="84"/>
   <object id="2" name="Center" type="Center" x="56" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
