<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimKickBack" class="Animation" tilewidth="64" tileheight="64" tilecount="7" columns="0">
 <editorsettings>
  <export target="../source/tsj/KimKickBack.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="64" height="64" source="../source/images/Kim/KimKickBack1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="25" y="25" width="21" height="39"/>
   <object id="2" name="Pushbox" class="Pushbox" x="14" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="64" height="64" source="../source/images/Kim/KimKickBack2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="27" y="19" width="20" height="38"/>
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="10"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="64" height="64" source="../source/images/Kim/KimKickBack3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="21" y="3" width="20" height="25">
    <properties>
     <property name="velocityX" type="int" value="0"/>
     <property name="velocityY" type="int" value="6"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox" class="Hurtbox" x="19" y="16" width="18" height="32"/>
   <object id="1" name="Pushbox" class="Pushbox" x="0" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="64" height="64" source="../source/images/Kim/KimKickBack4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="40" y="6" width="20" height="20">
    <properties>
     <property name="velocityX" type="int" value="4"/>
     <property name="velocityY" type="int" value="6"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox" class="Hurtbox" x="16" y="17" width="18" height="32"/>
   <object id="1" name="Pushbox" class="Pushbox" x="0" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="64" height="64" source="../source/images/Kim/KimKickBack5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="43" y="33" width="23" height="17">
    <properties>
     <property name="velocityX" type="int" value="4"/>
     <property name="velocityY" type="int" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox" class="Hurtbox" x="15" y="20" width="18" height="33"/>
   <object id="1" name="Pushbox" class="Pushbox" x="0" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="5" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="64" height="64" source="../source/images/Kim/KimKickBack2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="27" y="19" width="20" height="38"/>
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="6" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="64" height="64" source="../source/images/Kim/KimKickBack1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="25" y="25" width="21" height="39"/>
   <object id="2" name="Pushbox" class="Pushbox" x="14" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>
