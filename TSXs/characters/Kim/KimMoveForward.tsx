<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimMoveForward" class="Animation" tilewidth="64" tileheight="96" tilecount="3" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimMoveForward.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="123"/>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="64" height="96" source="../../../source/characters/Kim/images/KimMove1.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="12" y="12" width="40" height="84"/>
   <object id="7" name="Hurtbox (Mid)" type="Hurtbox" x="2" y="44" width="52" height="52"/>
   <object id="8" name="Hurtbox (High)" type="Hurtbox" x="12" y="12" width="40" height="38"/>
   <object id="9" name="Center" type="Center" x="32" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="123"/>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="64" height="96" source="../../../source/characters/Kim/images/KimMove2.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="12" y="12" width="40" height="84"/>
   <object id="7" name="Hurtbox (Mid)" type="Hurtbox" x="4" y="42" width="42" height="54"/>
   <object id="8" name="Hurtbox (High)" type="Hurtbox" x="12" y="10" width="38" height="38"/>
   <object id="9" name="Center" type="Center" x="32" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="123"/>
   <property name="frameDuration" type="int" value="5"/>
  </properties>
  <image width="64" height="96" source="../../../source/characters/Kim/images/KimMove3.gif"/>
  <objectgroup draworder="index" id="2">
   <object id="6" name="Pushbox" type="Pushbox" x="12" y="12" width="40" height="84"/>
   <object id="7" name="Hurtbox (Mid)" type="Hurtbox" x="10" y="44" width="52" height="52"/>
   <object id="8" name="Hurtbox (High)" type="Hurtbox" x="10" y="12" width="42" height="38"/>
   <object id="9" name="Center" type="Center" x="32" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
