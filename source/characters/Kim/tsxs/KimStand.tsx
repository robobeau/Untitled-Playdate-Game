<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimStand" class="Animation" tilewidth="80" tileheight="96" tilecount="4" columns="0" objectalignment="bottom">
 <editorsettings>
  <export target="../source/tsj/Kim/KimStand.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="123"/>
   <property name="frameDuration" type="int" value="3"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="80" height="96" source="../images/KimStand1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="20" y="12" width="40" height="84"/>
   <object id="3" name="Hurtbox (Body)" type="Hurtbox" x="8" y="42" width="64" height="54"/>
   <object id="1" name="Hurtbox (Head)" type="Hurtbox" x="20" y="12" width="40" height="38"/>
   <object id="4" name="Center" type="Center" x="40" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="123"/>
   <property name="frameDuration" type="int" value="4"/>
  </properties>
  <image width="80" height="96" source="../images/KimStand2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="20" y="12" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="8" y="40" width="64" height="56"/>
   <object id="3" name="Hurtbox (Head)" type="Hurtbox" x="20" y="10" width="40" height="38"/>
   <object id="5" name="Center" type="Center" x="40" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="123"/>
   <property name="frameDuration" type="int" value="5"/>
  </properties>
  <image width="80" height="96" source="../images/KimStand3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="20" y="12" width="40" height="84"/>
   <object id="4" name="Hurtbox (Body)" type="Hurtbox" x="8" y="38" width="64" height="58"/>
   <object id="3" name="Hurtbox (Head)" type="Hurtbox" x="20" y="10" width="40" height="38"/>
   <object id="5" name="Center" type="Center" x="40" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="123"/>
   <property name="frameDuration" type="int" value="3"/>
  </properties>
  <image width="80" height="96" source="../images/KimStand1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="20" y="12" width="40" height="84"/>
   <object id="3" name="Hurtbox (Body)" type="Hurtbox" x="8" y="42" width="64" height="54"/>
   <object id="4" name="Hurtbox (Head)" type="Hurtbox" x="20" y="12" width="40" height="38"/>
   <object id="5" name="Center" type="Center" x="40" y="96">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
