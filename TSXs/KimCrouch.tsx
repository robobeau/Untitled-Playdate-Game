<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimCrouch" class="Animation" tilewidth="36" tileheight="36" tilecount="1" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimCrouch.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" class="Frame">
  <properties>
   <property name="attackCancellable" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="1"/>
   <property name="moveCancellable" type="bool" value="true"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="36" height="36" source="../source/images/Kim/KimCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="10" y="2" width="21" height="34"/>
   <object id="2" name="Pushbox" class="Pushbox" x="0" y="-6" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>
