<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimCrouch" class="Animation" tilewidth="72" tileheight="72" tilecount="1" columns="0">
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
  <image width="72" height="72" source="../source/images/Kim/KimCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="20" y="4" width="42" height="68"/>
   <object id="2" name="Pushbox" class="Pushbox" x="0" y="-12" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>
