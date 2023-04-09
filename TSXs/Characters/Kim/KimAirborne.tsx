<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimJumpNeutral" class="Animation" tilewidth="64" tileheight="128" tilecount="2" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimJumpNeutral.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="blockCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="2"/>
   <property name="loops" type="bool" value="false"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="64" height="128" source="../../../source/images/characters/Kim/KimAirborne1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="14" y="22" width="40" height="76"/>
   <object id="2" name="Pushbox" class="Pushbox" x="-4" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="blockCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="64" height="128" source="../../../source/images/characters/Kim/KimAirborne2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="14" y="22" width="40" height="90"/>
   <object id="2" name="Pushbox" class="Pushbox" x="-4" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>
