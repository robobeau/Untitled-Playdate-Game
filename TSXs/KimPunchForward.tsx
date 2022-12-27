<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimPunchForward" class="Animation" tilewidth="64" tileheight="40" tilecount="3" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimPunchForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="64" height="40" source="../source/images/Kim/KimPunchForward1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="14" y="1" width="21" height="39"/>
   <object id="4" name="Pushbox" class="Pushbox" x="0" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="9"/>
   <property name="specialCancellable" type="bool" value="true"/>
   <property name="superCancellable" type="bool" value="true"/>
  </properties>
  <image width="64" height="40" source="../source/images/Kim/KimPunchForward2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Hitbox" class="Hitbox" x="44" y="13" width="22" height="15">
    <properties>
     <property name="velocityX" type="int" value="6"/>
    </properties>
   </object>
   <object id="1" name="Hurtbox" class="Hurtbox" x="24" y="3" width="21" height="37"/>
   <object id="3" name="Pushbox" class="Pushbox" x="0" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="64" height="40" source="../source/images/Kim/KimPunchForward3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Hurtbox" class="Hurtbox" x="14" y="1" width="21" height="39"/>
   <object id="2" name="Pushbox" class="Pushbox" x="0" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>
