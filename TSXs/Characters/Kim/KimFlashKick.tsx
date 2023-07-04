<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimFlashKick" class="Animation" tilewidth="112" tileheight="128" tilecount="6" columns="0">
 <editorsettings>
  <export target="../../../source/tsj/characters/Kim/KimFlashKick.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="velocityX" type="int" value="2"/>
   <property name="velocityY" type="int" value="-12"/>
  </properties>
  <image width="112" height="128" source="../../../source/images/characters/Kim/KimFlashKick1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="36" y="44" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="30" y="64" width="54" height="64"/>
   <object id="2" name="Hurtbox (Head)" type="Hurtbox" x="30" y="46" width="38" height="28"/>
   <object id="3" name="Center" type="Center" x="56" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="112" height="128" source="../../../source/images/characters/Kim/KimFlashKick1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="36" y="44" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="30" y="64" width="54" height="64"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="30" y="46" width="38" height="28"/>
   <object id="6" name="Center" type="Center" x="56" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="112" height="128" source="../../../source/images/characters/Kim/KimFlashKick2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" type="Hitbox" x="82" y="74" width="30" height="38">
    <properties>
     <property name="velocityX" type="int" value="12"/>
     <property name="velocityY" type="int" value="-6"/>
    </properties>
   </object>
   <object id="4" name="Pushbox" type="Pushbox" x="36" y="44" width="40" height="42"/>
   <object id="5" name="Hurtbox (Body)" type="Hurtbox" x="36" y="56" width="60" height="40"/>
   <object id="6" name="Hurtbox (Head)" type="Hurtbox" x="4" y="64" width="32" height="40"/>
   <object id="7" name="Center" type="Center" x="56" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="5" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="6"/>
  </properties>
  <image width="112" height="128" source="../../../source/images/characters/Kim/KimFlashKick3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="36" y="44" width="40" height="42"/>
   <object id="5" name="Hurtbox (Body)" type="Hurtbox" x="26" y="42" width="56" height="54"/>
   <object id="3" name="Hurtbox (Head)" type="Hurtbox" x="26" y="70" width="36" height="38"/>
   <object id="2" name="Hitbox" type="Hitbox" x="6" y="6" width="100" height="94">
    <properties>
     <property name="velocityX" type="int" value="16"/>
     <property name="velocityY" type="int" value="-16"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="56" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="6" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="112" height="128" source="../../../source/images/characters/Kim/KimFlashKick4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="10" name="Pushbox" type="Pushbox" x="36" y="44" width="40" height="42"/>
   <object id="11" name="Hurtbox (Body)" type="Hurtbox" x="26" y="42" width="56" height="54"/>
   <object id="12" name="Hurtbox (Head)" type="Hurtbox" x="26" y="70" width="36" height="38"/>
   <object id="13" name="Hitbox" type="Hitbox" x="6" y="6" width="100" height="94">
    <properties>
     <property name="velocityX" type="int" value="16"/>
     <property name="velocityY" type="int" value="-16"/>
    </properties>
   </object>
   <object id="14" name="Center" type="Center" x="56" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="7" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="1"/>
  </properties>
  <image width="112" height="128" source="../../../source/images/characters/Kim/KimFlashKick5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="34" y="62" width="40" height="42"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="16" y="46" width="64" height="62"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="56" y="66" width="38" height="36"/>
   <object id="6" name="Center" type="Center" x="54" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
