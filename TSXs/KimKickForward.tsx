<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimKickForward" class="Animation" tilewidth="64" tileheight="48" tilecount="6" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimKickForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="64" height="48" source="../source/images/Kim/KimKickForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="26" y="9" width="17" height="39"/>
   <object id="3" name="Pushbox" class="Pushbox" x="14" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="64" height="48" source="../source/images/Kim/KimKickForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="36" y="21" width="10" height="12">
    <properties>
     <property name="velocityX" type="int" value="2"/>
     <property name="velocityY" type="int" value="2"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox" class="Hurtbox" x="18" y="7" width="18" height="41"/>
   <object id="4" name="Pushbox" class="Pushbox" x="7" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="64" height="48" source="../source/images/Kim/KimKickForward3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="35" y="15" width="31" height="17">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="2"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox" class="Hurtbox" x="11" y="9" width="18" height="39"/>
   <object id="3" name="Pushbox" class="Pushbox" x="4" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="7"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="64" height="48" source="../source/images/Kim/KimKickForward3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="35" y="15" width="31" height="17">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="2"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox" class="Hurtbox" x="11" y="9" width="18" height="39"/>
   <object id="3" name="Pushbox" class="Pushbox" x="4" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="64" height="48" source="../source/images/Kim/KimKickForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="18" y="7" width="18" height="41"/>
   <object id="2" name="Pushbox" class="Pushbox" x="7" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="5" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="64" height="48" source="../source/images/Kim/KimKickForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="26" y="9" width="17" height="39"/>
   <object id="3" name="Pushbox" class="Pushbox" x="14" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>
