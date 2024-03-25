<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimJumpNeutral" class="Animation" tilewidth="64" tileheight="128" tilecount="2" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimAirborne.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="duration" type="int" value="2"/>
  </properties>
  <image width="62" height="76" source="../../../source/characters/Kim/images/KimAirborne1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="12" y="0" width="40" height="76"/>
   <object id="3" name="Hurtbox (Mid)" type="Hurtbox" x="4" y="22" width="56" height="52">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox (High)" type="Hurtbox" x="12" y="0" width="40" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="32" y="106">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="99"/>
   <property name="duration" type="int" value="1"/>
   <property name="loops" type="bool" value="true"/>
  </properties>
  <image width="50" height="120" source="../../../source/characters/Kim/images/KimAirborne2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="8" name="Pushbox" type="Pushbox" x="6" y="14" width="40" height="106"/>
   <object id="9" name="Hurtbox (Mid)" type="Hurtbox" x="2" y="48" width="48" height="56">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="10" name="Hurtbox (High)" type="Hurtbox" x="6" y="14" width="40" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="11" name="Center" type="Center" x="26" y="120">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
