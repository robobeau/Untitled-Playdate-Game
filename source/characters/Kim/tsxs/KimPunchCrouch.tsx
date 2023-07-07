<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimPunchCrouch" class="Animation" tilewidth="148" tileheight="80" tilecount="5" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimPunchCrouch.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="144" height="80" source="../images/KimPunchCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="44" y="-4" width="40" height="84"/>
   <object id="2" name="Hurtbox (Body)" type="Hurtbox" x="34" y="40" width="60" height="40"/>
   <object id="4" name="Hurtbox (Head)" type="Hurtbox" x="44" y="10" width="38" height="38"/>
   <object id="3" name="Center" type="Center" x="64" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="144" height="80" source="../images/KimPunchCrouch2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="44" y="-4" width="40" height="84"/>
   <object id="2" name="Hurtbox (Body)" type="Hurtbox" x="30" y="36" width="70" height="44"/>
   <object id="4" name="Hurtbox (Head)" type="Hurtbox" x="42" y="10" width="42" height="40"/>
   <object id="3" name="Center" type="Center" x="64" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="9"/>
  </properties>
  <image width="144" height="80" source="../images/KimPunchCrouch3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="44" y="-4" width="40" height="84"/>
   <object id="2" name="Hurtbox (Body)" type="Hurtbox" x="30" y="42" width="72" height="38"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="54" y="14" width="40" height="34"/>
   <object id="3" name="Hitbox" type="Hitbox" x="100" y="52" width="48" height="28">
    <properties>
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
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="144" height="80" source="../images/KimPunchCrouch4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Pushbox" type="Pushbox" x="44" y="-4" width="40" height="84"/>
   <object id="5" name="Hurtbox (Body)" type="Hurtbox" x="30" y="36" width="70" height="44"/>
   <object id="6" name="Hurtbox (Head)" type="Hurtbox" x="42" y="10" width="42" height="40"/>
   <object id="7" name="Center" type="Center" x="64" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="144" height="80" source="../images/KimPunchCrouch5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="44" y="-4" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="34" y="40" width="60" height="40"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="44" y="10" width="38" height="38"/>
   <object id="6" name="Center" type="Center" x="64" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
