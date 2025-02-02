<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimSuperAirborneBegin" class="Animation" tilewidth="80" tileheight="112" tilecount="1" columns="0">
 <editorsettings>
  <export target="../../../source/characters/Kim/animations/KimSuperAirborneBegin.lua" format="lua"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="1" type="Frame">
  <properties>
   <property name="duration" type="int" value="1"/>
   <property name="loops" type="bool" value="false"/>
   <property name="soundFX" type="file" value="../../../source/sounds/whooshes/kick_short_whoosh_01.wav"/>
   <property name="velocityX" type="int" value="4"/>
   <property name="velocityY" type="int" value="8"/>
  </properties>
  <image width="80" height="112" source="../../../source/characters/Kim/images/KimDiveKick2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="20" y="28" width="40" height="84"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="2" y="24" width="78" height="62">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (High)" type="Hurtbox" x="20" y="10" width="40" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="3" name="Hitbox" type="Hitbox" x="20" y="86" width="60" height="26">
    <properties>
     <property name="characterState" type="int" propertytype="CharacterStates" value="8388609"/>
     <property name="damage" type="int" value="5"/>
     <property name="hitstun" type="int" value="5"/>
     <property name="launch" type="int" value="14"/>
     <property name="opponentState" type="int" propertytype="CharacterStates" value="4097"/>
     <property name="soundFX" type="class" propertytype="SoundFX">
      <properties>
       <property name="onBlock" type="file" value="../../../source/sounds/blocks/block_small_10.wav"/>
       <property name="onHit" type="file" value="../../../source/sounds/hits/face_hit_small_01.wav"/>
      </properties>
     </property>
     <property name="stun" type="int" value="5"/>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="7" name="Center" type="Center" x="40" y="112">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
