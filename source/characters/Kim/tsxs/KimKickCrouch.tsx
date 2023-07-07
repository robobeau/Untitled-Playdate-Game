<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimKickCrouch" class="Animation" tilewidth="128" tileheight="80" tilecount="4" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimKickCrouch.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="80" source="../images/KimKickCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="20" y="-4" width="40" height="84"/>
   <object id="2" name="Hurtbox (Body)" type="Hurtbox" x="14" y="24" width="48" height="56"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="22" y="6" width="38" height="30"/>
   <object id="3" name="Center" type="Center" x="40" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="128" height="80" source="../images/KimKickCrouch2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="20" y="-4" width="40" height="84"/>
   <object id="2" name="Hurtbox (Body)" type="Hurtbox" x="12" y="30" width="66" height="50"/>
   <object id="4" name="Hurtbox (Head)" type="Hurtbox" x="20" y="4" width="38" height="36"/>
   <object id="3" name="Center" type="Center" x="40" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="0"/>
   <property name="frameDuration" type="int" value="8"/>
  </properties>
  <image width="128" height="80" source="../images/KimKickCrouch3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="20" y="-4" width="40" height="84"/>
   <object id="2" name="Hurtbox (Body)" type="Hurtbox" x="14" y="38" width="56" height="42"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="32" y="14" width="38" height="36"/>
   <object id="3" name="Hitbox" type="Hitbox" x="70" y="52" width="62" height="28">
    <properties>
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
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="128" height="80" source="../images/KimKickCrouch4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="20" y="-4" width="40" height="84"/>
   <object id="2" name="Hurtbox (Body)" type="Hurtbox" x="18" y="38" width="46" height="42"/>
   <object id="4" name="Hurtbox (Head)" type="Hurtbox" x="20" y="10" width="38" height="38"/>
   <object id="3" name="Center" type="Center" x="40" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
