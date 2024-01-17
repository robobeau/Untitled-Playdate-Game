<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimHurtThrow" class="Animation" tilewidth="76" tileheight="60" tilecount="1" columns="0">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimHurtThrow.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="76" height="60" source="../../../source/characters/Kim/images/KimHurtThrow1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="18" y="10" width="40" height="40"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="9.81818" y="0" width="44" height="60">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="3" name="Center" type="Center" x="38" y="60">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
