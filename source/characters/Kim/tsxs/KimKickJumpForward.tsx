<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimKickJumpForward" class="Animation" tilewidth="96" tileheight="128" tilecount="3" columns="0">
 <editorsettings>
  <export target="../tsjs/KimKickJumpForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="96" height="128" source="../images/KimKickJumpForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="28" y="44" width="40" height="84"/>
   <object id="2" name="Hurtbox (Body)" type="Hurtbox" x="36" y="78" width="46" height="36"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="28" y="44" width="38" height="38"/>
   <object id="4" name="Center" type="Center" x="48" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="8"/>
  </properties>
  <image width="96" height="128" source="../images/KimKickJumpForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="14" y="44" width="40" height="84"/>
   <object id="2" name="Hurtbox (Body)" type="Hurtbox" x="4" y="68" width="52" height="48"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="16" y="44" width="40" height="38"/>
   <object id="1" name="Hitbox" type="Hitbox" x="56" y="92" width="44" height="36">
    <properties>
     <property name="damage" type="int" value="100"/>
     <property name="dizzy" type="int" value="100"/>
     <property name="hits" propertytype="Attack" value="HIGH"/>
     <property name="hitstun" type="int" value="5"/>
     <property name="pushback" type="int" value="5"/>
     <property name="super" type="int" value="100"/>
     <property name="velocityX" type="int" value="16"/>
     <property name="velocityY" type="int" value="10"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="34" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="nextState" type="int" propertytype="CharacterStates" value="1"/>
  </properties>
  <image width="96" height="128" source="../images/KimKickJumpForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="28" y="44" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="36" y="78" width="46" height="36"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="28" y="44" width="38" height="38"/>
   <object id="6" name="Center" type="Center" x="48" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
