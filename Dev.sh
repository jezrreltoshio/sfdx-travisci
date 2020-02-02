# cd /mnt/c/Users/eduardo.sascar/force-dev-tool/
clear

#Usuário
export senha='Harpia2019!CSNVfedQFBesUie8Lhjdux0Ei'
force-dev-tool remote add gbaggdev6 harpia.cloud@gerdau.com.br.dev6 $senha
force-dev-tool remote add gbaggdev5 jezrrel.imai@harpiacloud.com.br.dev5 Harpia2019*LoDf3LE3tSqt3lUiuaLjqsgk  https://test.salesforce.com/

#Login 
force-dev-tool login --quiet gbaggdev5
force-dev-tool login --quiet gbaggdev6

#Fetch
#force-dev-tool fetch --use-forceignore gbaggdev5
force-dev-tool fetch --use-forceignore gbaggdev5
force-dev-tool fetch --use-forceignore gbaggdev6

# Criação de branches
cd /mnt/c/Users/jezrrel.imai/Documents/ant/git/force-dev-tool
git checkout dev6
#git pull origin master
read -p 'Branch name: ' branch
git branch $branch
#git checkout $branch 
cd ..

# Criação de package Dev6
force-dev-tool package -a gbaggdev6

#Retrieve Dev6
force-dev-tool retrieve --progress gbaggdev6

#Commitar em dev6
cp -r src/* force-dev-tool/ -f
cd /mnt/c/Users/jezrrel.imai/Documents/ant/git/force-dev-tool
git add .
git commit -m 'Atualiza Dev6'

#Criação package Dev5
cd /mnt/c/Users/jezrrel.imai/Documents/ant/git
rm -r src
force-dev-tool package -a gbaggdev5

#Retrieve Dev5
force-dev-tool retrieve --progress gbaggdev5

#Commitar em dev5
cd /mnt/c/Users/jezrrel.imai/Documents/ant/git/force-dev-tool
git checkout $branch
cd /mnt/c/Users/jezrrel.imai/Documents/ant/git
cp -r src/* force-dev-tool/ -f
cd /mnt/c/Users/jezrrel.imai/Documents/ant/git/force-dev-tool
git add .
git commit -m 'Atualiza Dev5'

git diff dev6 $branch | force-dev-tool changeset create $branch -f
#cd ..
#cd config
#cd deployments
#mv aura $branch
#mv classes $branch
force-dev-tool retrieve -d ../config/deployments/$branch gbaggdev5
force-dev-tool deploy -d ../config/deployments/$branch gbaggdev6

# force-dev-tool deploy -c