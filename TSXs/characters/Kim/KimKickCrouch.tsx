<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.2" name="KimKickCrouch" class="Animation" tilewidth="144" tileheight="80" tilecount="4" columns="0">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimKickCrouch.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="144" height="80" source="../../../source/characters/Kim/images/KimKickCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="44" y="-4" width="40" height="84"/>
   <object id="2" name="Hurtbox (Low)" type="Hurtbox" x="40" y="40" width="48" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (High)" type="Hurtbox" x="44" y="10" width="38" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="3" name="Center" type="Center" x="64" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="144" height="80" source="../../../source/characters/Kim/images/KimKickCrouch2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="44" y="-4" width="40" height="84"/>
   <object id="2" name="Hurtbox (Low)" type="Hurtbox" x="34" y="36" width="50" height="44">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="4" name="Hurtbox (High)" type="Hurtbox" x="42" y="10" width="42" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="3" name="Center" type="Center" x="64" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="96"/>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="144" height="80" source="../../../source/characters/Kim/images/KimKickCrouch3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="44" y="-4" width="40" height="84"/>
   <object id="2" name="Hurtbox (Low)" type="Hurtbox" x="34" y="42" width="56" height="38">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="5" name="Hurtbox (High)" type="Hurtbox" x="54" y="14" width="40" height="34">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="3" name="Hitbox" type="Hitbox" x="90" y="52" width="58" height="28">
    <properties>
     <property name="damage" type="int" value="50"/>
     <property name="dizzy" type="int" value="50"/>
     <property name="hitstun" type="int" value="5"/>
     <property name="pushback" type="int" value="1"/>
     <property name="super" type="int" value="50"/>
     <property name="type" type="int" propertytype="CollisionType" value="4"/>
     <property name="velocityX" type="int" value="12"/>
     <property name="velocityY" type="int" value="-6"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="64" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="144" height="80" source="../../../source/characters/Kim/images/KimKickCrouch4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Pushbox" type="Pushbox" x="44" y="-4" width="40" height="84"/>
   <object id="8" name="Hurtbox (Low)" type="Hurtbox" x="34" y="36" width="50" height="44">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="2"/>
    </properties>
   </object>
   <object id="6" name="Hurtbox (High)" type="Hurtbox" x="42" y="10" width="42" height="40">
    <properties>
     <property name="type" type="int" propertytype="CollisionType" value="1"/>
    </properties>
   </object>
   <object id="7" name="Center" type="Center" x="64" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
