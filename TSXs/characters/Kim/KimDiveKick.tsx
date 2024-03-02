<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimDiveKick" class="Animation" tilewidth="80" tileheight="112" tilecount="2" columns="0">
 <editorsettings>
  <export target="../tsjs/KimDiveKick.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="velocityX" type="int" value="4"/>
   <property name="velocityY" type="int" value="8"/>
  </properties>
  <image width="80" height="112" source="../../../source/characters/Kim/images/KimDiveKick1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="20" y="28" width="40" height="84"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="2" y="24" width="78" height="62">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox (High)" type="Hurtbox" x="20" y="10" width="40" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="6" name="Hitbox" type="Hitbox" x="20" y="86" width="60" height="26">
    <properties>
     <property name="damage" type="int" value="5"/>
     <property name="hitstun" type="int" value="2"/>
     <property name="stun" type="int" value="5"/>
     <property name="super" type="int" value="5"/>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="5" name="Center" type="Center" x="40" y="112">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="80" height="112" source="../../../source/characters/Kim/images/KimDiveKick2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="20" y="28" width="40" height="84"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="2" y="24" width="78" height="62">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (High)" type="Hurtbox" x="20" y="10" width="40" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="3" name="Hitbox" type="Hitbox" x="20" y="86" width="60" height="26">
    <properties>
     <property name="damage" type="int" value="5"/>
     <property name="hitstun" type="int" value="5"/>
     <property name="stun" type="int" value="5"/>
     <property name="super" type="int" value="5"/>
     <property name="type" type="int" propertytype="CollisionType" value="0"/>
    </properties>
   </object>
   <object id="7" name="Center" type="Center" x="40" y="112">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
