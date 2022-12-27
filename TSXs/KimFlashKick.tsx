<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimFlashKick" class="Animation" tilewidth="112" tileheight="128" tilecount="9" columns="0">
 <editorsettings>
  <export target="../source/tsj/KimFlashKick.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimFlashKick2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="40" y="50" width="42" height="78"/>
   <object id="1" name="Pushbox" class="Pushbox" x="20" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="velocityX" type="int" value="2"/>
   <property name="velocityY" type="int" value="-12"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimFlashKick3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="30" y="46" width="38" height="82"/>
   <object id="1" name="Pushbox" class="Pushbox" x="20" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimFlashKick3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="30" y="46" width="38" height="82"/>
   <object id="1" name="Pushbox" class="Pushbox" x="20" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimFlashKick4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="82" y="74" width="30" height="38">
    <properties>
     <property name="velocityX" type="int" value="2"/>
     <property name="velocityY" type="int" value="6"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox" class="Hurtbox" x="4" y="64" width="92" height="40"/>
   <object id="1" name="Pushbox" class="Pushbox" x="20" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="5" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="6"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimFlashKick5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Hitbox" class="Hitbox" x="62" y="64" width="44" height="44">
    <properties>
     <property name="velocityX" type="int" value="4"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="2" name="Hitbox" class="Hitbox" x="6" y="6" width="100" height="58">
    <properties>
     <property name="velocityX" type="int" value="2"/>
     <property name="velocityY" type="int" value="6"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox" class="Hurtbox" x="26" y="60" width="36" height="48"/>
   <object id="1" name="Pushbox" class="Pushbox" x="20" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="6" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimFlashKick6.png"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Hitbox" class="Hitbox" x="62" y="64" width="44" height="44">
    <properties>
     <property name="velocityX" type="int" value="4"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="5" name="Hitbox" class="Hitbox" x="6" y="6" width="100" height="58">
    <properties>
     <property name="velocityX" type="int" value="2"/>
     <property name="velocityY" type="int" value="6"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox" class="Hurtbox" x="26" y="52" width="46" height="56"/>
   <object id="1" name="Pushbox" class="Pushbox" x="20" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="7" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimFlashKick7.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="20" y="66" width="74" height="36"/>
   <object id="1" name="Pushbox" class="Pushbox" x="20" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="8" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimFlashKick8.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="36" y="32" width="40" height="74"/>
   <object id="1" name="Pushbox" class="Pushbox" x="20" y="32" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="9" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
  </properties>
  <image width="112" height="128" source="../source/images/Kim/KimFlashKick9.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="36" y="22" width="40" height="90"/>
   <object id="1" name="Pushbox" class="Pushbox" x="20" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>
