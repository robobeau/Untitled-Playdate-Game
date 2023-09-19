<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimKickNeutral" class="Animation" tilewidth="96" tileheight="96" tilecount="4" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../../../source/characters/Kim/TSJs/KimKickNeutral.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="96" height="96" source="../../../source/characters/Kim/images/KimKickNeutral1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Pushbox" type="Pushbox" x="42" y="12" width="40" height="84"/>
   <object id="5" name="Hurtbox (Mid)" type="Hurtbox" x="26" y="44" width="58" height="52"/>
   <object id="6" name="Hurtbox (High)" type="Hurtbox" x="50" y="18" width="34" height="36"/>
   <object id="7" name="Center" type="Center" x="62" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="96" height="96" source="../../../source/characters/Kim/images/KimKickNeutral2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="4" name="Pushbox" type="Pushbox" x="40" y="12" width="40" height="84"/>
   <object id="6" name="Hurtbox (Mid)" type="Hurtbox" x="18" y="36" width="48" height="60"/>
   <object id="1" name="Hurtbox (High)" type="Hurtbox" x="26" y="6" width="40" height="30"/>
   <object id="5" name="Center" type="Center" x="60" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="100"/>
   <property name="frameDuration" type="int" value="8"/>
   <property name="soundFX" type="class" propertytype="SoundFX">
    <properties>
     <property name="onHit" type="file" value="../../../source/sounds/face_hit_small_43.wav"/>
     <property name="onWhiff" type="file" value="../../../source/sounds/kick_short_whoosh_01.wav"/>
    </properties>
   </property>
  </properties>
  <image width="96" height="96" source="../../../source/characters/Kim/images/KimKickNeutral3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="40" y="12" width="40" height="84"/>
   <object id="6" name="Hurtbox (Mid)" type="Hurtbox" x="8" y="38" width="46" height="58"/>
   <object id="1" name="Hurtbox (High)" type="Hurtbox" x="10" y="8" width="40" height="36"/>
   <object id="2" name="Hitbox" type="Hitbox" x="50" y="8" width="52" height="48">
    <properties>
     <property name="damage" type="int" value="50"/>
     <property name="dizzy" type="int" value="50"/>
     <property name="hits" value="HIGH"/>
     <property name="hitstun" type="int" value="5"/>
     <property name="pushback" type="int" value="2"/>
     <property name="super" type="int" value="50"/>
     <property name="velocityX" type="int" value="16"/>
     <property name="velocityY" type="int" value="-16"/>
    </properties>
   </object>
   <object id="4" name="Center" type="Center" x="60" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="frameDuration" type="int" value="6"/>
  </properties>
  <image width="96" height="96" source="../../../source/characters/Kim/images/KimKickNeutral4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="42" y="12" width="40" height="84"/>
   <object id="7" name="Hurtbox (Mid)" type="Hurtbox" x="26" y="44" width="58" height="52"/>
   <object id="8" name="Hurtbox (High)" type="Hurtbox" x="50" y="18" width="34" height="36"/>
   <object id="9" name="Center" type="Center" x="62" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
