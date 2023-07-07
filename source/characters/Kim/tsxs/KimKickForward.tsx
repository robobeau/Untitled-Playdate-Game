<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimKickForward" class="Animation" tilewidth="128" tileheight="96" tilecount="5" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../tsjs/KimKickForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="96" source="../images/KimKickForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="44" y="12" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="28" y="44" width="58" height="52"/>
   <object id="1" name="Hurtbox (Head)" type="Hurtbox" x="52" y="18" width="34" height="36"/>
   <object id="5" name="Center" type="Center" x="64" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="96" source="../images/KimKickForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Pushbox" type="Pushbox" x="30" y="12" width="40" height="84"/>
   <object id="1" name="Hurtbox (Body)" type="Hurtbox" x="38" y="30" width="50" height="66"/>
   <object id="6" name="Hurtbox (Head)" type="Hurtbox" x="36" y="14" width="36" height="26"/>
   <object id="7" name="Center" type="Center" x="50" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="96"/>
   <property name="frameDuration" type="int" value="8"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="128" height="96" source="../images/KimKickForward3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="24" y="12" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="24" y="32" width="46" height="64"/>
   <object id="1" name="Hurtbox (Head)" type="Hurtbox" x="22" y="18" width="36" height="26"/>
   <object id="2" name="Hitbox" type="Hitbox" x="58" y="30" width="74" height="34">
    <properties>
     <property name="damage" type="int" value="200"/>
     <property name="dizzy" type="int" value="100"/>
     <property name="hits" propertytype="Attack" value="MID"/>
     <property name="hitstun" type="int" value="10"/>
     <property name="pushback" type="int" value="30"/>
     <property name="velocityX" type="int" value="16"/>
     <property name="velocityY" type="int" value="-8"/>
    </properties>
   </object>
   <object id="5" name="Center" type="Center" x="44" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="96" source="../images/KimKickForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="30" y="12" width="40" height="84"/>
   <object id="7" name="Hurtbox (Body)" type="Hurtbox" x="38" y="30" width="50" height="66"/>
   <object id="8" name="Hurtbox (Head)" type="Hurtbox" x="36" y="14" width="36" height="26"/>
   <object id="9" name="Center" type="Center" x="50" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="5" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="96" source="../images/KimKickForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="7" name="Pushbox" type="Pushbox" x="44" y="12" width="40" height="84"/>
   <object id="8" name="Hurtbox (Body)" type="Hurtbox" x="28" y="44" width="58" height="52"/>
   <object id="9" name="Hurtbox (Head)" type="Hurtbox" x="52" y="18" width="34" height="36"/>
   <object id="10" name="Center" type="Center" x="64" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
