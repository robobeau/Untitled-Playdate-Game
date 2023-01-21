<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimJumpBack" class="Animation" tilewidth="112" tileheight="128" tilecount="6" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimJumpBack.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="2"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimJumpBack2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="40" y="28" width="44" height="86"/>
   <object id="2" name="Pushbox" class="Pushbox" x="20" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="2"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimJumpBack3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="36" y="22" width="40" height="90"/>
   <object id="2" name="Pushbox" class="Pushbox" x="20" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="4"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimJumpBack4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="4" y="64" width="92" height="40"/>
   <object id="2" name="Pushbox" class="Pushbox" x="20" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="4"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimJumpBack5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="44" y="12" width="40" height="92"/>
   <object id="2" name="Pushbox" class="Pushbox" x="20" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="5" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="4"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimJumpBack6.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hurtbox" class="Hurtbox" x="14" y="48" width="92" height="40"/>
   <object id="2" name="Pushbox" class="Pushbox" x="20" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="6" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimJumpBack7.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="36" y="22" width="40" height="90"/>
   <object id="2" name="Pushbox" class="Pushbox" x="20" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>
