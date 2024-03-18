<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimCrescentMoonSlash" class="Animation" tilewidth="124" tileheight="124" tilecount="12" columns="0">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimCrescentMoonSlash.lua" format="lua"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="124" height="124" source="../../../source/characters/Kim/images/KimCrescentMoonSlash1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="58" y="40" width="40" height="84"/>
   <object id="2" name="Hurtbox (Mid)" type="Hurtbox" x="42" y="72" width="58" height="52">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (High)" type="Hurtbox" x="66" y="46" width="34" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="3" name="Center" type="Center" x="78" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="soundFX" type="file" value="../../../source/sounds/whooshes/somersault_05.wav"/>
   <property name="velocityX" type="int" value="6"/>
  </properties>
  <image width="124" height="124" source="../../../source/characters/Kim/images/KimCrescentMoonSlash2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="58" y="40" width="40" height="84"/>
   <object id="5" name="Hurtbox (Mid)" type="Hurtbox" x="18" y="38" width="74" height="72">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (High)" type="Hurtbox" x="64" y="48" width="38" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="2" name="Center" type="Center" x="78" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="124" height="124" source="../../../source/characters/Kim/images/KimCrescentMoonSlash3.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="58" y="26" width="40" height="42"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="38" y="12" width="52" height="56">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="66" y="60" width="34" height="30">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="2" name="Center" type="Center" x="78" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="124" height="124" source="../../../source/characters/Kim/images/KimCrescentMoonSlash4.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="42" y="28" width="40" height="42"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="32" y="12" width="62" height="56">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="42" y="60" width="34" height="32">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="2" name="Center" type="Center" x="62" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="124" height="124" source="../../../source/characters/Kim/images/KimCrescentMoonSlash5.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="42" y="28" width="40" height="42"/>
   <object id="5" name="Hurtbox (Mid)" type="Hurtbox" x="28" y="12" width="62" height="56">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (High)" type="Hurtbox" x="46" y="60" width="34" height="32">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="3" name="Center" type="Center" x="62" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="5" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="124" height="124" source="../../../source/characters/Kim/images/KimCrescentMoonSlash6.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="26" y="32" width="40" height="42"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="32" y="14" width="74" height="72">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (High)" type="Hurtbox" x="22" y="40" width="38" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="3" name="Center" type="Center" x="46" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="6" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="124" height="124" source="../../../source/characters/Kim/images/KimCrescentMoonSlash7.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="42" y="40" width="40" height="84"/>
   <object id="5" name="Hurtbox (Mid)" type="Hurtbox" x="36" y="46" width="50" height="60">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (High)" type="Hurtbox" x="40" y="22" width="36" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="3" name="Center" type="Center" x="62" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="7" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="124" height="124" source="../../../source/characters/Kim/images/KimCrescentMoonSlash8.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="42" y="40" width="40" height="84"/>
   <object id="6" name="Hurtbox (Mid)" type="Hurtbox" x="40" y="48" width="44" height="76">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="7" name="Hurtbox (High)" type="Hurtbox" x="36" y="30" width="36" height="28">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="62" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="8" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="124" height="124" source="../../../source/characters/Kim/images/KimCrescentMoonSlash9.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="44" y="40" width="40" height="84"/>
   <object id="6" name="Hurtbox (Mid)" type="Hurtbox" x="18" y="94" width="72" height="26"/>
   <object id="5" name="Hurtbox (High)" type="Hurtbox" x="48" y="56" width="42" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="2" name="Hitbox" type="Hitbox" x="90" y="36" width="38" height="84">
    <properties>
     <property name="damage" type="int" value="15"/>
     <property name="hitstun" type="int" value="5"/>
     <property name="pushback" type="int" value="5"/>
     <property name="soundFX" type="class" propertytype="SoundFX">
      <properties>
       <property name="onBlock" type="file" value="../../../source/sounds/blocks/block_small_10.wav"/>
       <property name="onHit" type="file" value="../../../source/sounds/hits/body_hit_large_65.wav"/>
      </properties>
     </property>
     <property name="stun" type="int" value="10"/>
     <property name="super" type="int" value="10"/>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="64" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="9" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="124" height="124" source="../../../source/characters/Kim/images/KimCrescentMoonSlash10.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="44" y="40" width="40" height="84"/>
   <object id="5" name="Hurtbox (Mid)" type="Hurtbox" x="18" y="94" width="72" height="26"/>
   <object id="4" name="Hurtbox (High)" type="Hurtbox" x="48" y="56" width="42" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="3" name="Center" type="Center" x="64" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="10" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="124" height="124" source="../../../source/characters/Kim/images/KimCrescentMoonSlash11.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="44" y="40" width="40" height="84"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="28" y="76" width="62" height="48">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (High)" type="Hurtbox" x="48" y="56" width="42" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="6" name="Center" type="Center" x="64" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="11" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="4194304"/>
  </properties>
  <image width="124" height="124" source="../../../source/characters/Kim/images/KimCrescentMoonSlash12.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="42" y="40" width="40" height="84"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="30" y="66" width="64" height="58"/>
   <object id="5" name="Hurtbox (High)" type="Hurtbox" x="48" y="46" width="42" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="6" name="Center" type="Center" x="62" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
