#!/bin/bash

# Set file name
opengrok_dist=opengrok-1.11.0


tomcat="/c/Apache-Software-Foundation/Tomcat-10.1"
opengrok=/opengrok

# Set the routes
dist=/opengrok/dist
logging_config=/opengrok/etc/logging.properties
opengrok_jar=/opengrok/dist/lib/opengrok.jar
ctags_exe=/c/Users/1193033579/Desktop/ctags/ctags.exe
src_dir=/opengrok/src
data_dir=/opengrok/data
configuration_xml=/opengrok/etc/configuration.xml
url=http://localhost:8080/source

# Compile opengrok 
# ./mvnw package -DskipTests

# Move the opengrok distribution to the dist file
rm -rf $dist/*
tar -xzf distribution/target/$opengrok_dist.tar.gz -C $dist
mv $dist/$opengrok_dist/*/ $dist
rm -rf $dist/$opengrok_dist
# Restart the tomcat server with the new war file

$tomcat/bin/shutdown.bat
rm -rf $tomcat/webapps/source*
cp $opengrok/etc/logging.properties $tomcat/conf/
cp $dist/lib/source.war $tomcat/webapps
$tomcat/bin/startup.bat
sleep 5

old_value=/opengrok/etc/configuration.xml
new_value=/opengrok/etc/configuration.xml

sed -i "s-$old_value-$new_value-g" /c/Apache-Software-Foundation/Tomcat-10.1/webapps/source/WEB-INF/web.xml


# Configure the jar file
sleep 5
java -Djava.util.logging.config.file=$logging_config -jar "$opengrok_jar" -c "$ctags_exe" -s "$src_dir" -d "$data_dir" -H -P -S -G -W "$configuration_xml" -U "$url" 

# java -Djava.util.logging.config.file=~/OneDrive/Documentos/TECH_CAMP/Refactoring/opengrok/etc/logging.properties -jar ~/OneDrive/Documentos/TECH_CAMP/Refactoring/opengrok/dist/lib/opengrok.jar -c ~/OneDrive/Documentos/TECH_CAMP/Refactoring/opengrok/ctags/ctags.exe -s ~/OneDrive/Documentos/TECH_CAMP/Refactoring/opengrok/src -d ~/OneDrive/Documentos/TECH_CAMP/Refactoring/opengrok/data -H -P -S -G -W ~/OneDrive/Documentos/TECH_CAMP/Refactoring/opengrok/etc/configuration.xml -U http://localhost:8080/source