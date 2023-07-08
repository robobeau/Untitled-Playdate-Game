<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimCrescentMoonSlash" class="Animation" tilewidth="124" tileheight="124" tilecount="12" columns="0">
 <editorsettings>
  <export target="../../../source/tsj/characters/Kim/KimCrescentMoonSlash.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="124" height="124" source="../images/KimCrescentMoonSlash1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="58" y="40" width="40" height="84"/>
   <object id="2" name="Hurtbox (Body)" type="Hurtbox" x="42" y="72" width="58" height="52"/>
   <object id="4" name="Hurtbox (Head)" type="Hurtbox" x="66" y="46" width="34" height="36"/>
   <object id="3" name="Center" type="Center" x="78" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="velocityX" type="int" value="6"/>
  </properties>
  <image width="124" height="124" source="../images/KimCrescentMoonSlash2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="58" y="40" width="40" height="84"/>
   <object id="2" name="Center" type="Center" x="78" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="124" height="124" source="../images/KimCrescentMoonSlash3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="58" y="26" width="40" height="42"/>
   <object id="2" name="Center" type="Center" x="78" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="124" height="124" source="../images/KimCrescentMoonSlash4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="42" y="28" width="40" height="42"/>
   <object id="2" name="Center" type="Center" x="62" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="124" height="124" source="../images/KimCrescentMoonSlash5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="42" y="28" width="40" height="42"/>
   <object id="3" name="Center" type="Center" x="62" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="5" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="124" height="124" source="../images/KimCrescentMoonSlash6.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="26" y="32" width="40" height="42"/>
   <object id="3" name="Center" type="Center" x="46" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="6" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="124" height="124" source="../images/KimCrescentMoonSlash7.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="42" y="40" width="40" height="84"/>
   <object id="2" name="Hitbox" type="Hitbox" x="60" y="-4" width="36" height="44">
    <properties>
     <property name="damage" type="int" value="50"/>
     <property name="dizzy" type="int" value="50"/>
     <property name="hits" propertytype="Attack" value="HIGH"/>
     <property name="hitstun" type="int" value="5"/>
     <property name="pushback" type="int" value="2"/>
     <property name="super" type="int" value="50"/>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="-12"/>
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
  <image width="124" height="124" source="../images/KimCrescentMoonSlash8.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="42" y="40" width="40" height="84"/>
   <object id="3" name="Hitbox" type="Hitbox" x="72" y="8" width="52" height="52">
    <properties>
     <property name="damage" type="int" value="50"/>
     <property name="dizzy" type="int" value="50"/>
     <property name="hits" propertytype="Attack" value="HIGH"/>
     <property name="hitstun" type="int" value="5"/>
     <property name="pushback" type="int" value="2"/>
     <property name="super" type="int" value="50"/>
     <property name="velocityX" type="int" value="12"/>
     <property name="velocityY" type="int" value="20"/>
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
  <image width="124" height="124" source="../images/KimCrescentMoonSlash9.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="44" y="40" width="40" height="84"/>
   <object id="2" name="Hitbox" type="Hitbox" x="90" y="36" width="38" height="84">
    <properties>
     <property name="damage" type="int" value="50"/>
     <property name="dizzy" type="int" value="50"/>
     <property name="hits" propertytype="Attack" value="MID"/>
     <property name="hitstun" type="int" value="5"/>
     <property name="pushback" type="int" value="5"/>
     <property name="super" type="int" value="50"/>
     <property name="velocityX" type="int" value="20"/>
     <property name="velocityY" type="int" value="20"/>
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
  <image width="124" height="124" source="../images/KimCrescentMoonSlash10.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="44" y="40" width="40" height="84"/>
   <object id="3" name="Center" type="Center" x="64" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="10" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="124" height="124" source="../images/KimCrescentMoonSlash11.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="44" y="40" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="28" y="76" width="62" height="48"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="48" y="56" width="42" height="40"/>
   <object id="6" name="Center" type="Center" x="64" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="11" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="2097152"/>
  </properties>
  <image width="124" height="124" source="../images/KimCrescentMoonSlash12.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="42" y="40" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="30" y="66" width="64" height="58"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="48" y="46" width="42" height="40"/>
   <object id="6" name="Center" type="Center" x="62" y="124">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
