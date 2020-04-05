## SET previous and current release versions
oldver=8.5.17 && newver=8.5.18 && echo making $newver from previous $oldver &&
 
## SET JAVA env for labs and output current java 1.8.0* version 
export PATH=$JAVA_HOME/bin:$PATH && java -version && sleep 5 &&


mkdir ~/git && cd ~/git && 
git clone https://github.com/ggprivate/sbt_tools.git ./  && 
git checkout -b $newver && 
git pull origin $oldver && 
git push origin $newver && 
# git checkout --track origin/$newver
find  ../git/  -type f -name pom.xml -exec sed -i -r 's/2.5.17/2.5.18/g' {} \; && 
find  ../git/  -type f -name pom.xml -exec sed -i -r 's/$oldver/$newver/g' {} \; && 
git commit -a -m 'change version 2.5.X and 8.5.X version in all pom.xml' &&
git push origin $newver &&
# mvn versions:set -DnewVersion=$newver
mvn clean install &&
mkdir ~/sbt-tools-$newver &&
for i in $(ls ~/git/*/target/*dependencies.jar); do cp -p $i ~/sbt-tools-$newver/;done  &&
rm -rf ~/git/*/target/ &&
rm -rf ~/git/ 


## Перенести созданные файлы ~/sbt-tools-$newver/*.jar в подготовленную директорию на FTP https://ggftp.gridgain.com/s/xUWCLcg1X99oUZS