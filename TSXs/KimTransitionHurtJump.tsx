<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.9" tiledversion="1.9.1" name="KimTransitionHurtJump" class="Animation" tilewidth="64" tileheight="40" tilecount="5" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimTransitionHurtJump.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="64" height="40" source="../source/images/Kim/KimTransitionHurtJump1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="-4" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="1" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="64" height="40" source="../source/images/Kim/KimTransitionHurtJump2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="-4" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="2" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="1"/>
   <property name="velocityX" type="int" value="-1"/>
  </properties>
  <image width="64" height="40" source="../source/images/Kim/KimTransitionHurtJump3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="3" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="5"/>
  </properties>
  <image width="64" height="40" source="../source/images/Kim/KimTransitionHurtJump3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="-2" width="36" height="42"/>
  </objectgroup>
 </tile>
 <tile id="4" class="Frame">
  <properties>
   <property name="frameDuration" type="int" value="2"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="64" height="40" source="../source/images/Kim/KimTransitionHurtJump2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" class="Pushbox" x="14" y="-4" width="36" height="42"/>
  </objectgroup>
 </tile>
</tileset>
