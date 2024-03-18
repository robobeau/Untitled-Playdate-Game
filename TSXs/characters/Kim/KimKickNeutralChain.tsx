<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimKickNeutral" class="Animation" tilewidth="128" tileheight="96" tilecount="3" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/tsj/characters/Kim/KimKickNeutralChain.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="128" height="96" source="../../../source/characters/Kim/images/KimKickNeutralChain1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="46" y="12" width="40" height="84"/>
   <object id="1" name="Hurtbox (Mid)" type="Hurtbox" x="26" y="38" width="68" height="58"/>
   <object id="5" name="Hurtbox (High)" type="Hurtbox" x="34" y="8" width="40" height="38"/>
   <object id="4" name="Center" type="Center" x="66" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="0"/>
   <property name="frameDuration" type="int" value="8"/>
   <property name="soundFX" type="file" value="../../../source/sounds/whooshes/kick_short_whoosh_01.wav"/>
  </properties>
  <image width="128" height="96" source="../../../source/characters/Kim/images/KimKickNeutralChain2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Pushbox" type="Pushbox" x="36" y="12" width="40" height="84"/>
   <object id="8" name="Hurtbox (Mid)" type="Hurtbox" x="24" y="40" width="58" height="56"/>
   <object id="7" name="Hurtbox (High)" type="Hurtbox" x="24" y="12" width="40" height="38"/>
   <object id="5" name="Hitbox" type="Hitbox" x="64" y="20" width="68" height="32">
    <properties>
     <property name="damage" type="int" value="5"/>
     <property name="hitstun" type="int" value="5"/>
     <property name="pushback" type="int" value="5"/>
     <property name="soundFX" type="class" propertytype="SoundFX">
      <properties>
       <property name="onBlock" type="file" value="../../../source/sounds/blocks/block_small_10.wav"/>
       <property name="onHit" type="file" value="../../../source/sounds/hits/face_hit_large_14.wav"/>
      </properties>
     </property>
     <property name="stun" type="int" value="5"/>
     <property name="super" type="int" value="5"/>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="6" name="Center" type="Center" x="56" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="0"/>
   <property name="frameDuration" type="int" value="6"/>
  </properties>
  <image width="128" height="96" source="../../../source/characters/Kim/images/KimKickNeutralChain1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="46" y="12" width="40" height="84"/>
   <object id="7" name="Hurtbox (Mid)" type="Hurtbox" x="26" y="38" width="68" height="58"/>
   <object id="8" name="Hurtbox (High)" type="Hurtbox" x="34" y="8" width="40" height="38"/>
   <object id="9" name="Center" type="Center" x="66" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
