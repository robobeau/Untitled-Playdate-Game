<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimSuperAirborne" class="Animation" tilewidth="114" tileheight="108" tilecount="16" columns="0">
 <editorsettings>
  <export target="../../../source/characters/Kim/animations/KimSuperAirborne.lua" format="lua"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
   <property name="velocityX" type="int" value="0"/>
   <property name="velocityY" type="int" value="-1"/>
  </properties>
  <image width="114" height="84" source="../../../source/characters/Kim/images/KimSuperAirborne1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="38" y="6" width="40" height="84"/>
   <object id="7" name="Hurtbox (Mid)" type="Hurtbox" x="38" y="16" width="44" height="48.0909">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="8" name="Hurtbox (High)" type="Hurtbox" x="26" y="2" width="34" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="9" name="Hitbox" type="Hitbox" x="26" y="-4" width="92" height="92">
    <properties>
     <property name="damage" type="int" value="5"/>
     <property name="hitstun" type="int" value="8"/>
     <property name="launch" type="int" value="6"/>
     <property name="soundFX" type="class" propertytype="SoundFX">
      <properties>
       <property name="onBlock" type="file" value="../../../source/sounds/blocks/block_small_10.wav"/>
       <property name="onHit" type="file" value="../../../source/sounds/hits/face_hit_small_01.wav"/>
      </properties>
     </property>
     <property name="stun" type="int" value="5"/>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="10" name="Center" type="Center" x="58" y="90">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="78" height="108" source="../../../source/characters/Kim/images/KimSuperAirborne2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="2" y="30" width="40" height="84"/>
   <object id="2" name="Hurtbox (Mid)" type="Hurtbox" x="8" y="42" width="60" height="44">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="12" y="58" width="32" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="5" name="Center" type="Center" x="22" y="114">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
   <property name="velocityY" type="int" value="-1"/>
  </properties>
  <image width="114" height="84" source="../../../source/characters/Kim/images/KimSuperAirborne3.gif"/>
  <objectgroup draworder="index" id="3">
   <object id="11" name="Pushbox" type="Pushbox" x="34" y="28" width="40" height="84"/>
   <object id="12" name="Hurtbox (Mid)" type="Hurtbox" x="32" y="20" width="44" height="48.0909">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="13" name="Hurtbox (High)" type="Hurtbox" x="54" y="44" width="34" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="15" name="Center" type="Center" x="54" y="112">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="78" height="108" source="../../../source/characters/Kim/images/KimSuperAirborne4.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="34" y="28" width="40" height="84"/>
   <object id="2" name="Hurtbox (Mid)" type="Hurtbox" x="10" y="22" width="60" height="44">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="34" y="14" width="32" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="5" name="Center" type="Center" x="54" y="112">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="5" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
   <property name="velocityY" type="int" value="-1"/>
  </properties>
  <image width="114" height="84" source="../../../source/characters/Kim/images/KimSuperAirborne1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="11" name="Pushbox" type="Pushbox" x="38" y="6" width="40" height="84"/>
   <object id="7" name="Hurtbox (Mid)" type="Hurtbox" x="38" y="16" width="44" height="48.0909">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="8" name="Hurtbox (High)" type="Hurtbox" x="26" y="2" width="34" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="9" name="Hitbox" type="Hitbox" x="26" y="-4" width="92" height="92">
    <properties>
     <property name="damage" type="int" value="5"/>
     <property name="hitstun" type="int" value="8"/>
     <property name="launch" type="int" value="6"/>
     <property name="soundFX" type="class" propertytype="SoundFX">
      <properties>
       <property name="onBlock" type="file" value="../../../source/sounds/blocks/block_small_10.wav"/>
       <property name="onHit" type="file" value="../../../source/sounds/hits/face_hit_small_01.wav"/>
      </properties>
     </property>
     <property name="stun" type="int" value="5"/>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="12" name="Center" type="Center" x="58" y="90">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="6" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="78" height="108" source="../../../source/characters/Kim/images/KimSuperAirborne2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="2" y="30" width="40" height="84"/>
   <object id="2" name="Hurtbox (Mid)" type="Hurtbox" x="8" y="42" width="60" height="44">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="12" y="58" width="32" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="7" name="Center" type="Center" x="22" y="114">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="7" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
   <property name="velocityY" type="int" value="-1"/>
  </properties>
  <image width="114" height="84" source="../../../source/characters/Kim/images/KimSuperAirborne3.gif"/>
  <objectgroup draworder="index" id="3">
   <object id="16" name="Pushbox" type="Pushbox" x="34" y="28" width="40" height="84"/>
   <object id="12" name="Hurtbox (Mid)" type="Hurtbox" x="32" y="20" width="44" height="48.0909">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="13" name="Hurtbox (High)" type="Hurtbox" x="54" y="44" width="34" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="17" name="Center" type="Center" x="54" y="112">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="8" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="78" height="108" source="../../../source/characters/Kim/images/KimSuperAirborne4.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="34" y="28" width="40" height="84"/>
   <object id="2" name="Hurtbox (Mid)" type="Hurtbox" x="10" y="22" width="60" height="44">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="34" y="14" width="32" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="7" name="Center" type="Center" x="54" y="112">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="9" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
   <property name="velocityY" type="int" value="-1"/>
  </properties>
  <image width="114" height="84" source="../../../source/characters/Kim/images/KimSuperAirborne1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="11" name="Pushbox" type="Pushbox" x="38" y="6" width="40" height="84"/>
   <object id="7" name="Hurtbox (Mid)" type="Hurtbox" x="38" y="16" width="44" height="48.0909">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="8" name="Hurtbox (High)" type="Hurtbox" x="26" y="2" width="34" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="9" name="Hitbox" type="Hitbox" x="26" y="-4" width="92" height="92">
    <properties>
     <property name="damage" type="int" value="5"/>
     <property name="hitstun" type="int" value="8"/>
     <property name="launch" type="int" value="6"/>
     <property name="soundFX" type="class" propertytype="SoundFX">
      <properties>
       <property name="onBlock" type="file" value="../../../source/sounds/blocks/block_small_10.wav"/>
       <property name="onHit" type="file" value="../../../source/sounds/hits/face_hit_small_01.wav"/>
      </properties>
     </property>
     <property name="stun" type="int" value="5"/>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="12" name="Center" type="Center" x="58" y="90">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="10" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="78" height="108" source="../../../source/characters/Kim/images/KimSuperAirborne2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="2" y="30" width="40" height="84"/>
   <object id="2" name="Hurtbox (Mid)" type="Hurtbox" x="8" y="42" width="60" height="44">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="12" y="58" width="32" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="7" name="Center" type="Center" x="22" y="114">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="11" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
   <property name="velocityY" type="int" value="-1"/>
  </properties>
  <image width="114" height="84" source="../../../source/characters/Kim/images/KimSuperAirborne3.gif"/>
  <objectgroup draworder="index" id="3">
   <object id="16" name="Pushbox" type="Pushbox" x="34" y="28" width="40" height="84"/>
   <object id="12" name="Hurtbox (Mid)" type="Hurtbox" x="32" y="20" width="44" height="48.0909">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="13" name="Hurtbox (High)" type="Hurtbox" x="54" y="44" width="34" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="17" name="Center" type="Center" x="54" y="112">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="12" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="78" height="108" source="../../../source/characters/Kim/images/KimSuperAirborne4.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="34" y="28" width="40" height="84"/>
   <object id="2" name="Hurtbox (Mid)" type="Hurtbox" x="10" y="22" width="60" height="44">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="34" y="14" width="32" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="7" name="Center" type="Center" x="54" y="112">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="13" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
   <property name="velocityY" type="int" value="-1"/>
  </properties>
  <image width="78" height="82" source="../../../source/characters/Kim/images/KimSuperAirborne5.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="6" y="0" width="40" height="84"/>
   <object id="2" name="Hurtbox (Mid)" type="Hurtbox" x="6" y="22" width="44" height="42">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="6" y="0" width="38" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="5" name="Center" type="Center" x="26" y="84">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="14" type="Frame">
  <properties>
   <property name="duration" type="int" value="6"/>
  </properties>
  <image width="110" height="92" source="../../../source/characters/Kim/images/KimSuperAirborne6.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="2" y="0" width="40" height="84"/>
   <object id="2" name="Hurtbox (Mid)" type="Hurtbox" x="0" y="28" width="48" height="44">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="2" y="0" width="40" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="22" y="84">
    <point/>
   </object>
   <object id="5" name="Hitbox" type="Hitbox" x="42" y="-4" width="72" height="58">
    <properties>
     <property name="damage" type="int" value="5"/>
     <property name="hitstun" type="int" value="99"/>
     <property name="launch" type="int" value="6"/>
     <property name="pushback" type="int" value="10"/>
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
  </objectgroup>
 </tile>
 <tile id="15" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="110" height="92" source="../../../source/characters/Kim/images/KimSuperAirborne7.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="2" y="0" width="40" height="84"/>
   <object id="2" name="Hurtbox (Mid)" type="Hurtbox" x="0" y="28" width="48" height="44">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="2" y="0" width="40" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="22" y="84">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="16" type="Frame">
  <properties>
   <property name="duration" type="int" value="1"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="1"/>
  </properties>
  <image width="68" height="88" source="../../../source/characters/Kim/images/KimSuperAirborne8.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="8" y="0" width="40" height="84"/>
   <object id="2" name="Hurtbox (Mid)" type="Hurtbox" x="8" y="24" width="58" height="42">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="8" y="0" width="40" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="28" y="84">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
