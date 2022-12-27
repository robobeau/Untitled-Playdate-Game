<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimPunchCrouch" class="Animation" tilewidth="72" tileheight="40" tilecount="5" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimPunchCrouch.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="72" height="40" source="../source/images/Kim/KimPunchCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="22" y="5" width="19" height="35"/>
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="72" height="40" source="../source/images/Kim/KimPunchCrouch2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hitbox" class="Hitbox" x="41" y="19" width="11" height="14">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="21" y="5" width="21" height="35"/>
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="9"/>
  </properties>
  <image width="72" height="40" source="../source/images/Kim/KimPunchCrouch3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hitbox" class="Hitbox" x="50" y="26" width="24" height="14">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="27" y="7" width="20" height="33"/>
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="72" height="40" source="../source/images/Kim/KimPunchCrouch4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="21" y="5" width="21" height="35"/>
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="72" height="40" source="../source/images/Kim/KimPunchCrouch5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="22" y="5" width="19" height="35"/>
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>
