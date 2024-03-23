<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimKickBack" class="Animation" tilewidth="128" tileheight="128" tilecount="5" columns="0">
 <editorsettings>
  <export target="../../../source/characters/Kim/animations/KimKickBack.lua" format="lua"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="128" height="128" source="../../../source/characters/Kim/images/KimKickBack2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="44" y="44" width="40" height="84"/>
   <object id="2" name="Hurtbox (Mid)" type="Hurtbox" x="54" y="70" width="48" height="58"/>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="54" y="38" width="40" height="36"/>
   <object id="4" name="Center" type="Center" x="64" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="6"/>
   <property name="soundFX" type="file" value="../../../source/sounds/whooshes/kick_short_whoosh_21.wav"/>
  </properties>
  <image width="128" height="128" source="../../../source/characters/Kim/images/KimKickBack3.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="16" y="44" width="40" height="84"/>
   <object id="3" name="Hurtbox (Mid)" type="Hurtbox" x="38" y="46" width="40" height="82"/>
   <object id="2" name="Hitbox" type="Hitbox" x="38" y="6" width="44" height="50">
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
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="36" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="96"/>
   <property name="frameDuration" type="int" value="6"/>
   <property name="soundFX" type="file" value="../../../source/sounds/whooshes/kick_short_whoosh_01.wav"/>
  </properties>
  <image width="128" height="128" source="../../../source/characters/Kim/images/KimKickBack4.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="16" y="44" width="40" height="84"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="36" y="52" width="44" height="76"/>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="32" y="34" width="36" height="28"/>
   <object id="2" name="Hitbox" type="Hitbox" x="68" y="12" width="52" height="52">
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
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="5" name="Center" type="Center" x="36" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="128" height="128" source="../../../source/characters/Kim/images/KimKickBack5.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="16" y="44" width="40" height="84"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="36" y="58" width="42" height="70"/>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="30" y="40" width="36" height="28"/>
   <object id="2" name="Hitbox" type="Hitbox" x="66" y="62" width="66" height="38">
    <properties>
     <property name="damage" type="int" value="5"/>
     <property name="hitstun" type="int" value="5"/>
     <property name="pushback" type="int" value="5"/>
     <property name="soundFX" type="class" propertytype="SoundFX">
      <properties>
       <property name="onBlock" type="file" value="../../../source/sounds/blocks/block_small_10.wav"/>
       <property name="onHit" type="file" value="../../../source/sounds/hits/face_hit_small_14.wav"/>
      </properties>
     </property>
     <property name="stun" type="int" value="5"/>
     <property name="super" type="int" value="5"/>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="5" name="Center" type="Center" x="36" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="5" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="128" height="128" source="../../../source/characters/Kim/images/KimKickBack2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="44" y="44" width="40" height="84"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="54" y="70" width="48" height="58"/>
   <object id="5" name="Hurtbox (High)" type="Hurtbox" x="54" y="38" width="40" height="36"/>
   <object id="6" name="Center" type="Center" x="64" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
