<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimJumpForward" class="Animation" tilewidth="40" tileheight="64" tilecount="7" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimJumpForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="2"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="40" height="64" source="../source/images/Kim/KimJumpForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="12" y="14" width="22" height="43"/>
   <object id="2" name="Pushbox" class="Pushbox" x="2" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="2"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="40" height="64" source="../source/images/Kim/KimJumpForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="10" y="11" width="20" height="45"/>
   <object id="2" name="Pushbox" class="Pushbox" x="2" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="2"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="40" height="64" source="../source/images/Kim/KimJumpForward3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="10" y="22" width="20" height="37"/>
   <object id="2" name="Pushbox" class="Pushbox" x="2" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="4"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="40" height="64" source="../source/images/Kim/KimJumpForward4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="3" y="35" width="37" height="18"/>
   <object id="2" name="Pushbox" class="Pushbox" x="2" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="5" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="4"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="40" height="64" source="../source/images/Kim/KimJumpForward5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="9" y="22" width="20" height="38"/>
   <object id="2" name="Pushbox" class="Pushbox" x="2" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="6" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="4"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="40" height="64" source="../source/images/Kim/KimJumpForward6.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hurtbox" class="Hurtbox" x="0" y="28" width="37" height="18"/>
   <object id="2" name="Pushbox" class="Pushbox" x="2" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="7" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="40" height="64" source="../source/images/Kim/KimJumpForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="10" y="11" width="20" height="45"/>
   <object id="2" name="Pushbox" class="Pushbox" x="2" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>
