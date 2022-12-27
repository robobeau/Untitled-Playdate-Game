<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimStand" class="Animation" tilewidth="40" tileheight="48" tilecount="4" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimStand.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="3"/>
   <property name="jumpCancellable" type="bool" value="true"/>
   <property name="moveCancellable" type="bool" value="true"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="40" height="48" source="../source/images/Kim/KimStand1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="10" y="6" width="20" height="42"/>
   <object id="2" name="Pushbox" class="Pushbox" x="2" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="4"/>
   <property name="jumpCancellable" type="bool" value="true"/>
   <property name="moveCancellable" type="bool" value="true"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="40" height="48" source="../source/images/Kim/KimStand2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="10" y="5" width="19" height="43"/>
   <object id="2" name="Pushbox" class="Pushbox" x="2" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="5"/>
   <property name="jumpCancellable" type="bool" value="true"/>
   <property name="moveCancellable" type="bool" value="true"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="40" height="48" source="../source/images/Kim/KimStand3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="10" y="5" width="20" height="43"/>
   <object id="2" name="Pushbox" class="Pushbox" x="2" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="3"/>
   <property name="jumpCancellable" type="bool" value="true"/>
   <property name="moveCancellable" type="bool" value="true"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="40" height="48" source="../source/images/Kim/KimStand1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="10" y="6" width="20" height="42"/>
   <object id="2" name="Pushbox" class="Pushbox" x="2" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>
