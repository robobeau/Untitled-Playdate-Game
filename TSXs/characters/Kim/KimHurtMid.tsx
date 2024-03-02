<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimHurtMid" class="Animation" tilewidth="76" tileheight="60" tilecount="1" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimHurtMid.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="hitstunnable" type="bool" value="true"/>
  </properties>
  <image width="76" height="60" source="../../../source/characters/Kim/images/KimHurtMid1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Pushbox" type="Pushbox" x="18" y="-24" width="40" height="84"/>
   <object id="5" name="Hurtbox (Low)" type="Hurtbox" x="10" y="42" width="56" height="18">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="6" name="Hurtbox (Mid)" type="Hurtbox" x="0" y="2" width="54" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="7" name="Hurtbox (High)" type="Hurtbox" x="18" y="0" width="38" height="30">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="8" name="Center" type="Center" x="38" y="60">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
