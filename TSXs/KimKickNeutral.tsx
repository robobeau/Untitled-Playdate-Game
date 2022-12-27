<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimKickNeutral" class="Animation" tilewidth="48" tileheight="48" tilecount="4" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimKickNeutral.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="48" height="48" source="../source/images/Kim/KimKickNeutral1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="25" y="9" width="17" height="39"/>
   <object id="3" name="Pushbox" class="Pushbox" x="12" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="48" height="48" source="../source/images/Kim/KimKickNeutral2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="13" y="3" width="20" height="45"/>
   <object id="4" name="Pushbox" class="Pushbox" x="12" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="9"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="48" height="48" source="../source/images/Kim/KimKickNeutral3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="27" y="4" width="24" height="24">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="6"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox" class="Hurtbox" x="5" y="4" width="20" height="44"/>
   <object id="3" name="Pushbox" class="Pushbox" x="12" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="48" height="48" source="../source/images/Kim/KimKickNeutral4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Hurtbox" class="Hurtbox" x="25" y="9" width="17" height="39"/>
   <object id="5" name="Pushbox" class="Pushbox" x="12" y="6" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>
