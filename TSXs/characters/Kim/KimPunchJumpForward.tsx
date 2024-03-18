<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimPunchJumpForward" class="Animation" tilewidth="64" tileheight="96" tilecount="1" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../tsjs/KimPunchJumpForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="1"/>
   <property name="soundFX" type="file" value="../../../source/sounds/whooshes/punch_short_whoosh_10.wav"/>
  </properties>
  <image width="64" height="96" source="../../../source/characters/Kim/images/KimPunchJumpForward1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Pushbox" type="Pushbox" x="12" y="12" width="40" height="84"/>
   <object id="6" name="Hurtbox (Mid)" type="Hurtbox" x="4" y="20" width="58" height="62"/>
   <object id="1" name="Hurtbox (High)" type="Hurtbox" x="12" y="8" width="40" height="40"/>
   <object id="5" name="Hitbox" type="Hitbox" x="34" y="68" width="34" height="32">
    <properties>
     <property name="damage" type="int" value="5"/>
     <property name="hitstun" type="int" value="5"/>
     <property name="pushback" type="int" value="5"/>
     <property name="soundFX" type="class" propertytype="SoundFX">
      <properties>
       <property name="onBlock" type="file" value="../../../source/sounds/blocks/block_small_10.wav"/>
       <property name="onHit" type="file" value="../../../source/sounds/hits/face_hit_small_01.wav"/>
      </properties>
     </property>
     <property name="stun" type="int" value="5"/>
     <property name="super" type="int" value="5"/>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="7" name="Center" type="Center" x="32" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
