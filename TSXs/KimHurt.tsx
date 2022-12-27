<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimHurt" class="Animation" tilewidth="56" tileheight="40" tilecount="4" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimHurt.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="56" height="40" source="../source/images/Kim/KimHurt1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="20" y="4" width="22" height="36"/>
   <object id="2" name="Pushbox" class="Pushbox" x="9" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="velocityX" type="int" value="-2"/>
  </properties>
  <image width="56" height="40" source="../source/images/Kim/KimHurt2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="3" y="7" width="33" height="33"/>
   <object id="2" name="Pushbox" class="Pushbox" x="20" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="5"/>
  </properties>
  <image width="56" height="40" source="../source/images/Kim/KimHurt2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="3" y="7" width="33" height="33"/>
   <object id="2" name="Pushbox" class="Pushbox" x="20" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="56" height="40" source="../source/images/Kim/KimHurt1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="20" y="4" width="22" height="36"/>
   <object id="2" name="Pushbox" class="Pushbox" x="9" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>
