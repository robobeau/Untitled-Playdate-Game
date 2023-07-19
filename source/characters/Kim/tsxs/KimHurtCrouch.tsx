<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimHurtCrouch" class="Animation" tilewidth="112" tileheight="64" tilecount="2" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimHurtCrouch.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="112" height="64" source="../images/KimHurtCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="56" y="-20" width="40" height="84"/>
   <object id="3" name="Center" type="Center" x="76" y="64">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="5"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="32"/>
  </properties>
  <image width="112" height="64" source="../images/KimHurtCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="56" y="-20" width="40" height="84"/>
   <object id="3" name="Center" type="Center" x="76" y="64">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
