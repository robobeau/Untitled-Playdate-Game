<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimKickForward" class="Animation" tilewidth="128" tileheight="96" tilecount="6" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimKickForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="96" source="../source/images/Kim/KimKickForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="52" y="18" width="34" height="78"/>
   <object id="3" name="Pushbox" class="Pushbox" x="28" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="96" source="../source/images/Kim/KimKickForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="72" y="42" width="20" height="24">
    <properties>
     <property name="velocityX" type="int" value="2"/>
     <property name="velocityY" type="int" value="2"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox" class="Hurtbox" x="36" y="14" width="36" height="82"/>
   <object id="4" name="Pushbox" class="Pushbox" x="14" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="128" height="96" source="../source/images/Kim/KimKickForward3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="70" y="30" width="62" height="34">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="2"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox" class="Hurtbox" x="22" y="18" width="36" height="78"/>
   <object id="3" name="Pushbox" class="Pushbox" x="8" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="7"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="128" height="96" source="../source/images/Kim/KimKickForward3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="70" y="30" width="62" height="34">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="2"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox" class="Hurtbox" x="22" y="18" width="36" height="78"/>
   <object id="3" name="Pushbox" class="Pushbox" x="8" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="96" source="../source/images/Kim/KimKickForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="36" y="14" width="36" height="82"/>
   <object id="2" name="Pushbox" class="Pushbox" x="14" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="5" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="96" source="../source/images/Kim/KimKickForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="52" y="18" width="34" height="78"/>
   <object id="3" name="Pushbox" class="Pushbox" x="28" y="12" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>
