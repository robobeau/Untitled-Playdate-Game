<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimKickBack" class="Animation" tilewidth="128" tileheight="128" tilecount="5" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimKickBack.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="128" height="128" source="../images/KimKickBack2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="44" y="44" width="40" height="84"/>
   <object id="2" name="Hurtbox (Body)" type="Hurtbox" x="54" y="70" width="48" height="58"/>
   <object id="3" name="Hurtbox (Head)" type="Hurtbox" x="54" y="38" width="40" height="36"/>
   <object id="4" name="Center" type="Center" x="64" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="10"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="128" height="128" source="../images/KimKickBack3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="16" y="44" width="40" height="84"/>
   <object id="3" name="Hurtbox (Body)" type="Hurtbox" x="38" y="46" width="40" height="82"/>
   <object id="2" name="Hitbox" type="Hitbox" x="38" y="6" width="44" height="50">
    <properties>
     <property name="velocityX" type="int" value="2"/>
     <property name="velocityY" type="int" value="-16"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="36" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="128" height="128" source="../images/KimKickBack4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="16" y="44" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="36" y="52" width="44" height="76"/>
   <object id="3" name="Hurtbox (Head)" type="Hurtbox" x="32" y="34" width="36" height="28"/>
   <object id="2" name="Hitbox" type="Hitbox" x="68" y="12" width="52" height="52">
    <properties>
     <property name="velocityX" type="int" value="12"/>
     <property name="velocityY" type="int" value="-12"/>
    </properties>
   </object>
   <object id="5" name="Center" type="Center" x="36" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="128" height="128" source="../images/KimKickBack5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="16" y="44" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="36" y="58" width="42" height="70"/>
   <object id="3" name="Hurtbox (Head)" type="Hurtbox" x="30" y="40" width="36" height="28"/>
   <object id="2" name="Hitbox" type="Hitbox" x="66" y="62" width="66" height="38">
    <properties>
     <property name="velocityX" type="int" value="12"/>
     <property name="velocityY" type="int" value="6"/>
    </properties>
   </object>
   <object id="5" name="Center" type="Center" x="36" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="5" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="128" height="128" source="../images/KimKickBack2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="44" y="44" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="54" y="70" width="48" height="58"/>
   <object id="5" name="Hurtbox (Head)" type="Hurtbox" x="54" y="38" width="40" height="36"/>
   <object id="6" name="Center" type="Center" x="64" y="128">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
