<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimKickJumpForward" class="Animation" tilewidth="48" tileheight="64" tilecount="5" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimKickJumpForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="48" height="64" source="../source/images/Kim/KimKickJumpForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hitbox" class="Hitbox" x="30" y="39" width="13" height="22">
    <properties>
     <property name="velocityX" type="int" value="2"/>
     <property name="velocityY" type="int" value="2"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="14" y="22" width="19" height="35"/>
   <object id="3" name="Pushbox" class="Pushbox" x="6" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
  </properties>
  <image width="48" height="64" source="../source/images/Kim/KimKickJumpForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hitbox" class="Hitbox" x="28" y="46" width="22" height="18">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="8" y="22" width="20" height="36"/>
   <object id="3" name="Pushbox" class="Pushbox" x="-1" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="48" height="64" source="../source/images/Kim/KimKickJumpForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="14" y="22" width="19" height="35"/>
   <object id="1" name="Pushbox" class="Pushbox" x="6" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="48" height="64" source="../source/images/Kim/KimKickJumpForward4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="14" y="22" width="20" height="37"/>
   <object id="2" name="Pushbox" class="Pushbox" x="6" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
  </properties>
  <image width="48" height="64" source="../source/images/Kim/KimKickJumpForward5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="14" y="11" width="20" height="45"/>
   <object id="2" name="Pushbox" class="Pushbox" x="6" y="22" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>
