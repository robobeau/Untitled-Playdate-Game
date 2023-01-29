<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimKickBack" class="Animation" tilewidth="128" tileheight="128" tilecount="7" columns="0">
 <editorsettings>
  <export target="../source/tsj/KimKickBack.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="128" height="128" source="../source/images/Kim/KimKickBack1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="50" y="50" width="42" height="78"/>
   <object id="2" name="Pushbox" class="Pushbox" x="28" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="128" source="../source/images/Kim/KimKickBack2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="54" y="38" width="40" height="90"/>
   <object id="1" name="Pushbox" class="Pushbox" x="28" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="10"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="128" height="128" source="../source/images/Kim/KimKickBack3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="38" y="6" width="44" height="50">
    <properties>
     <property name="velocityX" type="int" value="0"/>
     <property name="velocityY" type="int" value="6"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox" class="Hurtbox" x="38" y="56" width="40" height="72"/>
   <object id="1" name="Pushbox" class="Pushbox" x="0" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="128" height="128" source="../source/images/Kim/KimKickBack4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="68" y="12" width="52" height="52">
    <properties>
     <property name="velocityX" type="int" value="4"/>
     <property name="velocityY" type="int" value="6"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox" class="Hurtbox" x="32" y="34" width="36" height="94"/>
   <object id="1" name="Pushbox" class="Pushbox" x="0" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="128" height="128" source="../source/images/Kim/KimKickBack5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="66" y="62" width="66" height="38">
    <properties>
     <property name="velocityX" type="int" value="4"/>
     <property name="velocityY" type="int" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox" class="Hurtbox" x="30" y="40" width="36" height="88"/>
   <object id="1" name="Pushbox" class="Pushbox" x="0" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="5" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="128" source="../source/images/Kim/KimKickBack2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="54" y="38" width="40" height="90"/>
   <object id="1" name="Pushbox" class="Pushbox" x="28" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="6" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="128" source="../source/images/Kim/KimKickBack1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="50" y="50" width="42" height="78"/>
   <object id="2" name="Pushbox" class="Pushbox" x="28" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>
