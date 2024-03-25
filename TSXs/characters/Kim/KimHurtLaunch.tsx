<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimHurtAirborne" class="Animation" tilewidth="88" tileheight="90" tilecount="3" columns="0">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimHurtAirborne.lua" format="lua"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="1" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="74" height="88" source="../../../source/characters/Kim/images/KimLaunch1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="6" y="12" width="40" height="76"/>
   <object id="4" name="Hurtbox (Low)" type="Hurtbox" x="34" y="42" width="34" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (Mid)" type="Hurtbox" x="10" y="18" width="38" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="4"/>
    </properties>
   </object>
   <object id="6" name="Hurtbox (High)" type="Hurtbox" x="0" y="0" width="34" height="32">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="3" name="Center" type="Center" x="26" y="88">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="60" height="88" source="../../../source/characters/Kim/images/KimLaunch2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="6" y="12" width="40" height="76"/>
   <object id="6" name="Hurtbox (Low)" type="Hurtbox" x="26" y="54" width="30" height="30">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (Mid)" type="Hurtbox" x="0" y="32" width="48" height="28">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="4"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="0" y="0" width="40" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="2" name="Center" type="Center" x="26" y="88">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="88" height="90" source="../../../source/characters/Kim/images/KimLaunch3.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="5.63636" y="13.5455" width="40" height="76"/>
   <object id="5" name="Hurtbox (Low)" type="Hurtbox" x="38" y="40" width="42" height="44">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="16" y="16" width="40" height="42">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="4"/>
    </properties>
   </object>
   <object id="3" name="Hurtbox (High)" type="Hurtbox" x="0" y="0" width="36" height="32">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="2" name="Center" type="Center" x="25.6364" y="89.5455">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
