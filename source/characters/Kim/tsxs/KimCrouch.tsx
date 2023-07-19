<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimCrouch" class="Animation" tilewidth="72" tileheight="72" tilecount="1" columns="0">
 <editorsettings>
  <export target="../tsjs/KimCrouch.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="115"/>
   <property name="frameDuration" type="int" value="1"/>
  </properties>
  <image width="72" height="72" source="../images/KimCrouch1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="16" y="-12" width="40" height="84"/>
   <object id="3" name="Hurtbox (Body)" type="Hurtbox" x="0" y="24" width="62" height="48"/>
   <object id="1" name="Hurtbox (Head)" type="Hurtbox" x="20" y="4" width="42" height="40"/>
   <object id="4" name="Center" type="Center" x="36" y="72">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
