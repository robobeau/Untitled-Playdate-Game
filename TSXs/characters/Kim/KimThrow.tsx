<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimThrow" class="Animation" tilewidth="94" tileheight="86" tilecount="3" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/characters/Kim/animations/KimThrow.lua" format="lua"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="false"/>
 </properties>
 <tile id="0" type="Frame">
  <properties>
   <property name="duration" type="int" value="4"/>
  </properties>
  <image width="70" height="78" source="../../../source/characters/Kim/images/KimThrow1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="10" y="-2" width="40" height="80"/>
   <object id="6" name="Hurtbox (Low)" type="Hurtbox" x="0" y="66" width="58" height="12">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (Mid)" type="Hurtbox" x="12" y="26" width="42" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox (High)" type="Hurtbox" x="24" y="0" width="32" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="8" name="OpponentCenter" type="OpponentCenter" x="74" y="40">
    <point/>
   </object>
   <object id="4" name="Center" type="Center" x="30" y="78">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="duration" type="int" value="6"/>
  </properties>
  <image width="70" height="86" source="../../../source/characters/Kim/images/KimThrow2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="16" y="46" width="40" height="40"/>
   <object id="7" name="Hurtbox (Low)" type="Hurtbox" x="6" y="74" width="62" height="12">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="14" y="32" width="46" height="42">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="18" y="2" width="36" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="8" name="OpponentCenter" type="OpponentCenter" x="36" y="0">
    <point/>
   </object>
   <object id="5" name="Center" type="Center" x="36" y="86">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="duration" type="int" value="8"/>
  </properties>
  <image width="94" height="74" source="../../../source/characters/Kim/images/KimThrow3.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="44" y="34" width="40" height="40"/>
   <object id="6" name="Hurtbox (Low)" type="Hurtbox" x="34" y="62" width="60" height="12">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="42" y="8" width="46" height="54">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="32" y="0" width="32" height="32">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="8" name="Throwbox" type="Hitbox" x="-10" y="-12" width="20" height="20">
    <properties>
     <property name="damage" type="int" value="15"/>
     <property name="launch" type="int" value="4"/>
     <property name="opponentState" type="int" propertytype="CharacterStates" value="4097"/>
     <property name="pushback" type="int" value="-4"/>
     <property name="stun" type="int" value="15"/>
     <property name="super" type="int" value="5"/>
     <property name="type" type="int" propertytype="CollisionType" value="3"/>
    </properties>
   </object>
   <object id="7" name="OpponentCenter" type="OpponentCenter" x="0" y="0">
    <point/>
   </object>
   <object id="5" name="Center" type="Center" x="64" y="74">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
