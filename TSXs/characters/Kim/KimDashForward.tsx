<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimDashForward" class="Animation" tilewidth="64" tileheight="112" tilecount="1" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimDashForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="320"/>
  </properties>
  <image width="64" height="112" source="../../../source/characters/Kim/images/KimDashForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="16" y="28" width="40" height="84"/>
   <object id="3" name="Hurtbox (Mid)" type="Hurtbox" x="0" y="42" width="62" height="70"/>
   <object id="1" name="Hurtbox (High)" type="Hurtbox" x="16" y="12" width="44" height="40"/>
   <object id="4" name="Center" type="Center" x="36" y="112">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
