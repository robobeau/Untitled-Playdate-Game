<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimKickCrouch" class="Animation" tilewidth="128" tileheight="80" tilecount="4" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimKickCrouch.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="80" source="../source/images/Kim/KimKickCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="22" y="6" width="38" height="74"/>
   <object id="1" name="Pushbox" class="Pushbox" x="4" y="-4" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="80" source="../source/images/Kim/KimKickCrouch2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hitbox" class="Hitbox" x="58" y="58" width="24" height="22">
    <properties>
     <property name="velocityX" type="int" value="2"/>
     <property name="velocityY" type="int" value="2"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="20" y="4" width="38" height="76"/>
   <object id="1" name="Pushbox" class="Pushbox" x="4" y="-4" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="128" height="80" source="../source/images/Kim/KimKickCrouch3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hitbox" class="Hitbox" x="70" y="52" width="62" height="28">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="32" y="14" width="38" height="66"/>
   <object id="1" name="Pushbox" class="Pushbox" x="4" y="-4" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="128" height="80" source="../source/images/Kim/KimKickCrouch4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="20" y="4" width="38" height="76"/>
   <object id="1" name="Pushbox" class="Pushbox" x="4" y="-4" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>
