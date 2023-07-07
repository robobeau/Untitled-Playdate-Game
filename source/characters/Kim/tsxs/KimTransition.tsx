<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimTransition" class="Animation" tilewidth="80" tileheight="80" tilecount="1" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimTransition.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <tile id="0" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="96"/>
   <property name="frameDuration" type="int" value="3"/>
   <property name="velocityX" type="int" value="0"/>
  </properties>
  <image width="80" height="80" source="../images/KimTransition1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="2" name="Pushbox" type="Pushbox" x="20" y="-4" width="40" height="84"/>
   <object id="3" name="Hurtbox (Body)" type="Hurtbox" x="8" y="22" width="64" height="58"/>
   <object id="1" name="Hurtbox (Head)" type="Hurtbox" x="26" y="2" width="42" height="40"/>
   <object id="4" name="Center" type="Center" x="40" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
