<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimKickJumpForward" class="Animation" tilewidth="96" tileheight="128" tilecount="5" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimKickJumpForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="96" height="128" source="../source/images/Kim/KimKickJumpForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hitbox" class="Hitbox" x="60" y="78" width="26" height="44">
    <properties>
     <property name="velocityX" type="int" value="2"/>
     <property name="velocityY" type="int" value="2"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="28" y="44" width="38" height="34"/>
   <object id="4" name="Hurtbox" class="Hurtbox" x="28" y="78" width="32" height="36"/>
   <object id="3" name="Pushbox" class="Pushbox" x="12" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
  </properties>
  <image width="96" height="128" source="../source/images/Kim/KimKickJumpForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hitbox" class="Hitbox" x="56" y="92" width="44" height="36">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="16" y="44" width="40" height="72"/>
   <object id="3" name="Pushbox" class="Pushbox" x="-2" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="96" height="128" source="../source/images/Kim/KimKickJumpForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="28" y="44" width="38" height="70"/>
   <object id="1" name="Pushbox" class="Pushbox" x="12" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="96" height="128" source="../source/images/Kim/KimKickJumpForward4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="28" y="44" width="40" height="74"/>
   <object id="2" name="Pushbox" class="Pushbox" x="12" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
  </properties>
  <image width="96" height="128" source="../source/images/Kim/KimKickJumpForward5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="28" y="22" width="40" height="90"/>
   <object id="2" name="Pushbox" class="Pushbox" x="12" y="44" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>
