<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimHurt" class="Animation" tilewidth="112" tileheight="80" tilecount="4" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimHurt.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="112" height="80" source="../../../source/images/characters/Kim/KimHurt1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="34" y="-4" width="40" height="84"/>
   <object id="3" name="Center" type="Center" x="54" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="velocityX" type="int" value="-2"/>
  </properties>
  <image width="112" height="80" source="../../../source/images/characters/Kim/KimHurt2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="56" y="-4" width="40" height="84"/>
   <object id="3" name="Center" type="Center" x="76" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="5"/>
  </properties>
  <image width="112" height="80" source="../../../source/images/characters/Kim/KimHurt2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="56" y="-4" width="40" height="84"/>
   <object id="3" name="Center" type="Center" x="76" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="2097152"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="112" height="80" source="../../../source/images/characters/Kim/KimHurt1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="34" y="-4" width="40" height="84"/>
   <object id="4" name="Center" type="Center" x="54" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
