<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimHurtAirborne" class="Animation" tilewidth="128" tileheight="96" tilecount="2" columns="0">
 <editorsettings>
  <export target="../../../source/characters/Kim/animations/KimHurtAirborne.lua" format="lua"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" type="Frame">
  <properties>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="128" height="96" source="../../../source/characters/Kim/images/KimHurtAirborne1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="44" y="20" width="40" height="76"/>
   <object id="3" name="Center" type="Center" x="64" y="96">
    <point/>
   </object>
   <object id="6" name="Hurtbox (Mid)" type="Hurtbox" x="32" y="22" width="54" height="56">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="7" name="Hurtbox (High)" type="Hurtbox" x="20" y="6" width="36" height="32">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="duration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
  </properties>
  <image width="128" height="96" source="../../../source/characters/Kim/images/KimHurtAirborne2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="44" y="20" width="40" height="76"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="44" y="12" width="42" height="52">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (High)" type="Hurtbox" x="12" y="30" width="40" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="2" name="Center" type="Center" x="64" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
