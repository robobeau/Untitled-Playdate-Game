<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimKnockdown" class="Animation" tilewidth="112" tileheight="48" tilecount="1" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimKnockdown.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="10"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="2097152"/>
  </properties>
  <image width="112" height="48" source="../images/KimKnockdown1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="36" y="-36" width="40" height="84"/>
   <object id="2" name="Center" type="Center" x="56" y="48">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
