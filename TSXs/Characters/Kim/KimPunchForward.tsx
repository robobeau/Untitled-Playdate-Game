<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimPunchForward" class="Animation" tilewidth="128" tileheight="80" tilecount="3" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/tsj/characters/Kim/KimPunchForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="128" height="80" source="../../../source/images/characters/Kim/KimPunchForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Pushbox" type="Pushbox" x="16" y="-4" width="40" height="84"/>
   <object id="7" name="Hurtbox (Body)" type="Hurtbox" x="4" y="22" width="64" height="58"/>
   <object id="1" name="Hurtbox (Head)" type="Hurtbox" x="22" y="2" width="42" height="40"/>
   <object id="5" name="Center" type="Center" x="36" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="96"/>
   <property name="frameDuration" type="int" value="9"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="128" height="80" source="../../../source/images/characters/Kim/KimPunchForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="16" y="-4" width="40" height="84"/>
   <object id="5" name="Hurtbox (Body)" type="Hurtbox" x="22" y="26" width="66" height="54"/>
   <object id="1" name="Hurtbox (Head)" type="Hurtbox" x="48" y="6" width="42" height="40"/>
   <object id="2" name="Hitbox" type="Hitbox" x="88" y="26" width="44" height="30">
    <properties>
     <property name="damage" type="int" value="100"/>
     <property name="hits" propertytype="Attack" value="MID"/>
     <property name="hitstun" type="int" value="100"/>
     <property name="meter" type="int" value="100"/>
     <property name="pushback" type="int" value="5"/>
     <property name="velocityX" type="int" value="16"/>
     <property name="velocityY" type="int" value="-8"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="36" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="128" height="80" source="../../../source/images/characters/Kim/KimPunchForward3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="16" y="-4" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="4" y="22" width="64" height="58"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="22" y="2" width="42" height="40"/>
   <object id="6" name="Center" type="Center" x="36" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
