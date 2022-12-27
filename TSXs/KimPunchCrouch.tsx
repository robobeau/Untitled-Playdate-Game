<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimPunchCrouch" class="Animation" tilewidth="148" tileheight="80" tilecount="5" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimPunchCrouch.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="148" height="80" source="../source/images/Kim/KimPunchCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="44" y="10" width="38" height="70"/>
   <object id="1" name="Pushbox" class="Pushbox" x="28" y="-4" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="148" height="80" source="../source/images/Kim/KimPunchCrouch2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hitbox" class="Hitbox" x="82" y="38" width="22" height="28">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="42" y="10" width="42" height="70"/>
   <object id="1" name="Pushbox" class="Pushbox" x="28" y="-4" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="9"/>
  </properties>
  <image width="148" height="80" source="../source/images/Kim/KimPunchCrouch3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Hitbox" class="Hitbox" x="100" y="52" width="48" height="28">
    <properties>
     <property name="velocityX" type="int" value="6"/>
     <property name="velocityY" type="int" value="4"/>
    </properties>
   </object>
   <object id="2" name="Hurtbox" class="Hurtbox" x="54" y="14" width="40" height="66"/>
   <object id="1" name="Pushbox" class="Pushbox" x="28" y="-4" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="148" height="80" source="../source/images/Kim/KimPunchCrouch4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="42" y="10" width="42" height="70"/>
   <object id="1" name="Pushbox" class="Pushbox" x="28" y="-4" width="72" height="84"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="148" height="80" source="../source/images/Kim/KimPunchCrouch5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hurtbox" class="Hurtbox" x="44" y="10" width="38" height="70"/>
   <object id="1" name="Pushbox" class="Pushbox" x="28" y="-4" width="72" height="84"/>
  </objectgroup>
 </tile>
</tileset>
