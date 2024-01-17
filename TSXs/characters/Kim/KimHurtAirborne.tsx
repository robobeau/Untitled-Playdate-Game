<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimHurtAirborne" class="Animation" tilewidth="128" tileheight="96" tilecount="2" columns="0">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimHurtAirborne.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="6"/>
  </properties>
  <image width="128" height="96" source="../../../source/characters/Kim/images/KimHurtAirborne1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="44" y="20" width="40" height="76"/>
   <object id="3" name="Center" type="Center" x="64" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
  </properties>
  <image width="128" height="96" source="../../../source/characters/Kim/images/KimHurtAirborne2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="44" y="20" width="40" height="76"/>
   <object id="2" name="Center" type="Center" x="64" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
