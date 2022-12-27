<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimKickCrouch" class="Animation" tilewidth="64" tileheight="40" tilecount="4" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimKickCrouch.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="64" height="40" source="../source/images/Kim/KimKickCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="11" y="3" width="19" height="37"/>
   <object id="1" name="Pushbox" class="Pushbox" x="2" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="64" height="40" source="../source/images/Kim/KimKickCrouch2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hitbox" class="Hitbox" x="29" y="29" width="12" height="11">
    <properties>
     <property name="velocityX" type="int" value="2"/>
     <property name="velocityY" type="int" value="2"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="10" y="2" width="19" height="38"/>
   <object id="1" name="Pushbox" class="Pushbox" x="2" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="64" height="40" source="../source/images/Kim/KimKickCrouch3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hitbox" class="Hitbox" x="38" y="26" width="28" height="14">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="16" y="7" width="19" height="33"/>
   <object id="1" name="Pushbox" class="Pushbox" x="2" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="64" height="40" source="../source/images/Kim/KimKickCrouch4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="10" y="2" width="19" height="38"/>
   <object id="1" name="Pushbox" class="Pushbox" x="2" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>
