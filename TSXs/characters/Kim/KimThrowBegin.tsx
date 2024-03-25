<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimThrowBegin" class="Animation" tilewidth="112" tileheight="80" tilecount="2" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimThrowBegin.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="duration" type="int" value="4"/>
  </properties>
  <image width="70" height="78" source="../../../source/characters/Kim/images/KimThrow1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="10" y="-6" width="40" height="84"/>
   <object id="7" name="Throwbox" type="Hitbox" x="54" y="0" width="20" height="78">
    <properties>
     <property name="characterState" type="int" propertytype="CharacterStates" value="16777216"/>
     <property name="type" type="int" propertytype="CollisionType" value="3"/>
    </properties>
   </object>
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
   <object id="4" name="Center" type="Center" x="30" y="78">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="duration" type="int" value="10"/>
  </properties>
  <image width="112" height="80" source="../../../source/characters/Kim/images/KimHurt1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="34" y="-4" width="40" height="84"/>
   <object id="5" name="Hurtbox (Low)" type="Hurtbox" x="24" y="66" width="58" height="14">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="4"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox (Mid)" type="Hurtbox" x="24" y="26" width="58" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="4"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (High)" type="Hurtbox" x="40" y="8" width="42" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="3" name="Center" type="Center" x="54" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
