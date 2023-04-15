#!/bin/bash

# Set file name
opengrok_dist=opengrok-1.11.4

# Set the routes
dist=~/OneDrive/Documentos/TECH_CAMP/Refactoring/openbrok/dist
tomcat=/e/ProgramFiles/apache-tomcat-10.1.7
logging_config=~/OneDrive/Documentos/TECH_CAMP/Refactoring/openbrok/etc/logging.properties
opengrok_jar=~/OneDrive/Documentos/TECH_CAMP/Refactoring/openbrok/dist/lib/opengrok.jar
ctags_exe=~/OneDrive/Documentos/TECH_CAMP/Refactoring/openbrok/ctags/ctags.exe
src_dir=~/OneDrive/Documentos/TECH_CAMP/Refactoring/openbrok/src
data_dir=~/OneDrive/Documentos/TECH_CAMP/Refactoring/openbrok/data
configuration_xml=~/OneDrive/Documentos/TECH_CAMP/Refactoring/openbrok/etc/configuration.xml
url=http://localhost:8080/source

# Compile opengrok 
./mvnw package -DskipTests

# Move the opengrok distribution to the dist file
rm -rf $dist/*
tar -xzf distribution/target/*.tar.gz -C $dist
mv $dist/$opengrok_dist/*/ $dist
rm -rf $dist/$opengrok_dist

# Restart the tomcat server with the new war file
$tomcat/bin/shutdown.sh
rm -rf $tomcat/webapps/source*
cp $dist/lib/source.war $tomcat/webapps
$tomcat/bin/startup.sh

# Configure the jar file
java -Djava.util.logging.config.file=~/OneDrive/Documentos/TECH_CAMP/Refactoring/openbrok/etc/logging.properties -jar "$opengrok_jar" -c "$ctags_exe" -s "$src_dir" -d "$data_dir" -H -P -S -G -W "$configuration_xml" -U "$url"
