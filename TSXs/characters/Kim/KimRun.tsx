<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.10" tiledversion="1.10.1" name="KimRun" class="Animation" tilewidth="96" tileheight="80" tilecount="6" columns="0">
 <editorsettings>
  <export target="../source/tsj/Kim/KimRun.tsj" format="json"/>
 </editorsettings>
 <grid orientation="orthogonal" width="1" height="1"/>
 <properties>
  <property name="loops" type="bool" value="true"/>
 </properties>
 <tile id="0" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="121"/>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="96" height="80" source="../../../source/characters/Kim/images/KimRun1.png"/>
  <objectgroup draworder="index" id="2">
   <object id="1" name="Pushbox" type="Pushbox" x="34" y="-4" width="40" height="84"/>
   <object id="4" name="Hurtbox (Mid)" type="Hurtbox" x="12" y="18" width="66" height="62"/>
   <object id="2" name="Hurtbox (High)" type="Hurtbox" x="30" y="0" width="48" height="40"/>
   <object id="3" name="Center" type="Center" x="54" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="1" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="121"/>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="96" height="80" source="../../../source/characters/Kim/images/KimRun2.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="34" y="-4" width="40" height="84"/>
   <object id="4" name="Center" type="Center" x="54" y="80">
    <point/>
   </object>
   <object id="5" name="Hurtbox (Mid)" type="Hurtbox" x="24" y="18" width="54" height="62"/>
   <object id="6" name="Hurtbox (High)" type="Hurtbox" x="32" y="0" width="46" height="40"/>
  </objectgroup>
 </tile>
 <tile id="2" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="121"/>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="96" height="80" source="../../../source/characters/Kim/images/KimRun3.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="34" y="-4" width="40" height="84"/>
   <object id="5" name="Hurtbox (Mid)" type="Hurtbox" x="28" y="18" width="50" height="62"/>
   <object id="6" name="Hurtbox (High)" type="Hurtbox" x="34" y="0" width="44" height="40"/>
   <object id="4" name="Center" type="Center" x="54" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="121"/>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="96" height="80" source="../../../source/characters/Kim/images/KimRun4.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="34" y="-4" width="40" height="84"/>
   <object id="7" name="Hurtbox (Mid)" type="Hurtbox" x="12" y="18" width="66" height="62"/>
   <object id="8" name="Hurtbox (High)" type="Hurtbox" x="30" y="0" width="48" height="40"/>
   <object id="4" name="Center" type="Center" x="54" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="121"/>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="96" height="80" source="../../../source/characters/Kim/images/KimRun5.png"/>
  <objectgroup draworder="index" id="2">
   <object id="3" name="Pushbox" type="Pushbox" x="34" y="-4" width="40" height="84"/>
   <object id="5" name="Hurtbox (Mid)" type="Hurtbox" x="24" y="18" width="54" height="62"/>
   <object id="6" name="Hurtbox (High)" type="Hurtbox" x="34" y="0" width="44" height="40"/>
   <object id="4" name="Center" type="Center" x="54" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
 <tile id="5" type="Frame">
  <properties>
   <property name="cancellable" type="int" propertytype="Cancellable" value="121"/>
   <property name="frameDuration" type="int" value="2"/>
  </properties>
  <image width="96" height="80" source="../../../source/characters/Kim/images/KimRun6.png"/>
  <objectgroup draworder="index" id="2">
   <object id="5" name="Pushbox" type="Pushbox" x="34" y="-4" width="40" height="84"/>
   <object id="6" name="Hurtbox (Mid)" type="Hurtbox" x="28" y="18" width="50" height="62"/>
   <object id="7" name="Hurtbox (High)" type="Hurtbox" x="34" y="0" width="44" height="40"/>
   <object id="8" name="Center" type="Center" x="54" y="80">
    <point/>
   </object>
  </objectgroup>
 </tile>
</tileset>
