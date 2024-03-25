<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimHurtHigh" class="Animation" tilewidth="98" tileheight="74" tilecount="1" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimHurtHigh.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="duration" type="int" value="1"/>
   <property name="hitstunnable" type="bool" value="true"/>
  </properties>
  <image width="98" height="74" source="../../../source/characters/Kim/images/KimHurtHigh1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Pushbox" type="Pushbox" x="50" y="-10" width="40" height="84"/>
   <object id="5" name="Hurtbox (Low)" type="Hurtbox" x="44" y="54" width="54" height="20">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="6" name="Hurtbox (Mid)" type="Hurtbox" x="34" y="4" width="52" height="50">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="7" name="Hurtbox (High)" type="Hurtbox" x="2" y="8" width="36" height="42">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="8" name="Center" type="Center" x="70" y="74">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
