<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimJumpNeutral" class="Animation" tilewidth="64" tileheight="128" tilecount="2" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/tsj/characters/Kim/KimAirborne.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="frameDuration" type="int" value="2"/>
   <property name="loops" type="bool" value="false"/>
  </properties>
  <image width="64" height="128" source="../images/KimAirborne1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="14" y="22" width="40" height="76"/>
   <object id="3" name="Hurtbox (Body)" type="Hurtbox" x="2" y="44" width="62" height="54"/>
   <object id="1" name="Hurtbox (Head)" type="Hurtbox" x="14" y="22" width="40" height="38"/>
   <object id="4" name="Center" type="Center" x="34" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="frameDuration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
  </properties>
  <image width="64" height="128" source="../images/KimAirborne2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="8" name="Pushbox" type="Pushbox" x="14" y="44" width="40" height="84"/>
   <object id="9" name="Hurtbox (Body)" type="Hurtbox" x="8" y="56" width="50" height="56"/>
   <object id="10" name="Hurtbox (Head)" type="Hurtbox" x="14" y="22" width="40" height="38"/>
   <object id="11" name="Center" type="Center" x="34" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
