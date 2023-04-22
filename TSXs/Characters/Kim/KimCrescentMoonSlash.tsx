<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimCrescentMoonSlash" class="Animation" tilewidth="124" tileheight="124" tilecount="12" columns="0">
 <editorsettings>
  <export target="../../../source/tsj/characters/Kim/KimCrescentMoonSlash.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="124" height="124" source="../../../source/images/characters/Kim/KimCrescentMoonSlash1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="42" y="40" width="72" height="84"/>
   <object id="2" name="Hurtbox" class="Hurtbox" x="66" y="46" width="34" height="78"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="airborne" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="2"/>
   <property name="velocityX" type="int" value="6"/>
  </properties>
  <image width="124" height="124" source="../../../source/images/characters/Kim/KimCrescentMoonSlash2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="42" y="40" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="airborne" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="124" height="124" source="../../../source/images/characters/Kim/KimCrescentMoonSlash3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="42" y="40" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="airborne" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="124" height="124" source="../../../source/images/characters/Kim/KimCrescentMoonSlash4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="26" y="40" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="airborne" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="124" height="124" source="../../../source/images/characters/Kim/KimCrescentMoonSlash5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="26" y="40" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="5" class="Frame">
  <properties>
   <property name="airborne" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="124" height="124" source="../../../source/images/characters/Kim/KimCrescentMoonSlash6.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" class="Pushbox" x="10" y="30" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="6" class="Frame">
  <properties>
   <property name="airborne" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="124" height="124" source="../../../source/images/characters/Kim/KimCrescentMoonSlash7.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="26" y="40" width="72" height="84"/>
   <object id="2" name="Hitbox" class="Hitbox" x="60" y="-4" width="36" height="44">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="-12"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="7" class="Frame">
  <properties>
   <property name="airborne" type="bool" value="true"/>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="124" height="124" source="../../../source/images/characters/Kim/KimCrescentMoonSlash8.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="26" y="40" width="72" height="84"/>
   <object id="3" name="Hitbox" class="Hitbox" x="72" y="8" width="52" height="52">
    <properties>
     <property name="velocityX" type="int" value="12"/>
     <property name="velocityY" type="int" value="20"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="8" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="124" height="124" source="../../../source/images/characters/Kim/KimCrescentMoonSlash9.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="28" y="36" width="72" height="84"/>
   <object id="2" name="Hitbox" class="Hitbox" x="90" y="36" width="38" height="84">
    <properties>
     <property name="velocityX" type="int" value="20"/>
     <property name="velocityY" type="int" value="20"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox" class="Hurtbox" x="48" y="52" width="42" height="68"/>
  </objectgroup>
 </tile>
 <tile id="9" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="124" height="124" source="../../../source/images/characters/Kim/KimCrescentMoonSlash10.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="28" y="36" width="72" height="84"/>
   <object id="2" name="Hurtbox" class="Hurtbox" x="48" y="52" width="42" height="68"/>
  </objectgroup>
 </tile>
 <tile id="10" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="124" height="124" source="../../../source/images/characters/Kim/KimCrescentMoonSlash11.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" class="Pushbox" x="28" y="40" width="72" height="84"/>
   <object id="1" name="Hurtbox" class="Hurtbox" x="48" y="56" width="42" height="68"/>
  </objectgroup>
 </tile>
 <tile id="11" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="124" height="124" source="../../../source/images/characters/Kim/KimCrescentMoonSlash12.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" class="Pushbox" x="26" y="40" width="72" height="84"/>
   <object id="1" name="Hurtbox" class="Hurtbox" x="48" y="46" width="42" height="78"/>
  </objectgroup>
 </tile>
</tileset>
