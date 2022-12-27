<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimHurtJump" class="Animation" tilewidth="64" tileheight="48" tilecount="3" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimHurtJump.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="velocityX" type="int" value="-2"/>
  </properties>
  <image width="64" height="48" source="../source/images/Kim/KimHurtJump1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="10" y="3" width="28" height="31"/>
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="5"/>
  </properties>
  <image width="64" height="48" source="../source/images/Kim/KimHurtJump1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="10" y="3" width="28" height="31"/>
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
  </properties>
  <image width="64" height="48" source="../source/images/Kim/KimHurtJump2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="6" y="6" width="35" height="28"/>
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>
