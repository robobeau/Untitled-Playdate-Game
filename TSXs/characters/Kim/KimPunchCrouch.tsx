<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimPunchCrouch" class="Animation" tilewidth="128" tileheight="80" tilecount="4" columns="0">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimPunchCrouch.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="80" source="../../../source/characters/Kim/images/KimPunchCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="22" y="-10" width="40" height="84"/>
   <object id="2" name="Hurtbox (Low)" type="Hurtbox" x="14" y="24" width="48" height="50">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (High)" type="Hurtbox" x="22" y="6" width="38" height="30">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="3" name="Center" type="Center" x="42" y="74">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="80" source="../../../source/characters/Kim/images/KimPunchCrouch2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="20" y="-12" width="40" height="84"/>
   <object id="2" name="Hurtbox (Low)" type="Hurtbox" x="12" y="30" width="50" height="42">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (High)" type="Hurtbox" x="20" y="4" width="38" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="3" name="Center" type="Center" x="40" y="72">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="0"/>
   <property name="frameDuration" type="int" value="10"/>
  </properties>
  <image width="128" height="80" source="../../../source/characters/Kim/images/KimPunchCrouch3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="20" y="-4" width="40" height="84"/>
   <object id="2" name="Hurtbox (Low)" type="Hurtbox" x="14" y="38" width="50" height="42">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (High)" type="Hurtbox" x="32" y="14" width="38" height="36">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="3" name="Hitbox" type="Hitbox" x="64" y="52" width="68" height="28">
    <properties>
     <property name="damage" type="int" value="50"/>
     <property name="dizzy" type="int" value="50"/>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
     <property name="velocityX" type="int" value="12"/>
     <property name="velocityY" type="int" value="-6"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="40" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="128" height="80" source="../../../source/characters/Kim/images/KimPunchCrouch4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="20" y="-4" width="40" height="84"/>
   <object id="2" name="Hurtbox (Low)" type="Hurtbox" x="18" y="38" width="46" height="42">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (High)" type="Hurtbox" x="20" y="10" width="38" height="38"/>
   <object id="3" name="Center" type="Center" x="40" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
