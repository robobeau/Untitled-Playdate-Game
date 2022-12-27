<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimHurtCrouch" class="Animation" tilewidth="56" tileheight="32" tilecount="2" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimHurtCrouch.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="velocityX" type="int" value="-2"/>
  </properties>
  <image width="56" height="32" source="../source/images/Kim/KimHurtCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hurtbox" class="Hurtbox" x="3" y="3" width="29" height="29"/>
   <object id="2" name="Pushbox" class="Pushbox" x="20" y="-10" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="5"/>
  </properties>
  <image width="56" height="32" source="../source/images/Kim/KimHurtCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hurtbox" class="Hurtbox" x="3" y="3" width="29" height="29"/>
   <object id="2" name="Pushbox" class="Pushbox" x="20" y="-10" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>
