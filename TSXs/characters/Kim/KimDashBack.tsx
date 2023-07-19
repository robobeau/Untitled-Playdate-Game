<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimDashBack" class="Animation" tilewidth="80" tileheight="96" tilecount="1" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimDashBack.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="6"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="320"/>
  </properties>
  <image width="80" height="96" source="../../../source/characters/Kim/images/KimDashBack1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="14" y="12" width="40" height="84"/>
   <object id="3" name="Hurtbox (Body)" type="Hurtbox" x="6" y="40" width="68" height="56"/>
   <object id="1" name="Hurtbox (Head)" type="Hurtbox" x="14" y="8" width="40" height="36"/>
   <object id="4" name="Center" type="Center" x="34" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
