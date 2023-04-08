<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimMoveBack" class="Animation" tilewidth="64" tileheight="96" tilecount="3" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimMoveBack.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="blockCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="3"/>
   <property name="jumpCancellable" type="bool" value="true"/>
   <property name="moveCancellable" type="bool" value="true"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="64" height="96" source="../source/images/Kim/KimMove1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="12" y="12" width="40" height="84"/>
   <object id="2" name="Pushbox" class="Pushbox" x="-6" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="blockCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="5"/>
   <property name="jumpCancellable" type="bool" value="true"/>
   <property name="moveCancellable" type="bool" value="true"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="64" height="96" source="../source/images/Kim/KimMove3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="10" y="12" width="42" height="84"/>
   <object id="2" name="Pushbox" class="Pushbox" x="-6" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="blockCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="4"/>
   <property name="jumpCancellable" type="bool" value="true"/>
   <property name="moveCancellable" type="bool" value="true"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="64" height="96" source="../source/images/Kim/KimMove2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="12" y="10" width="38" height="86"/>
   <object id="2" name="Pushbox" class="Pushbox" x="-6" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>
