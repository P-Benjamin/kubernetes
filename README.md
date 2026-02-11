# Projet Kubernetes

# 1. Projet

Ce projet consiste à choisir un projet front et back et de réaliser l'architecture nécessaire pour déployer le projet sur le web depuis une URL. Des images docker doivent être créees pour chaque composant (front et back) et des fichiers de configuration doivent être réalisés pour configurer l'hébérgement via kubernetes.

# 2. Architecture

L'architecture du projet se décompose en 6 parties :

__database__ :

Contient les fichiers nécessaire à la création de la base de données.

```
├── data.sql
├── script.sql
```

__deployment__ :

```
config.yml            # contient la configuration de la configmap pour l'accès à l'API
deployment-back.yml   # contient le deploiement du pod back
deployment-front.yml  # contient le deploiement du pod front
deployment-mysql.yml  # contient le deploiement du pod pour la base de données
route-back.yml        # contient la configuration de la route d'accès pour requêter le back
route-front.yml       # contient la configuration de la route d'accès pour accèder au front
secret.yml            # contient la configuration des credentials de la abse de données
service-back.yml      # contient la configuration du service du back
service-front.yml     # contient la configuration du service du front
service-mysql.yml     # contient la configuration du service de la base de données
```

__images__ :

Contient les images du site déployé.

__Vérifications__ :

Contient une capture d'écran de la commande ```oc get all``` affichant l'ensemble des objets déployés dans le groupe.

__dockerfiles__ :

Contient les fichiers dockerfile.

```
Dockerfile-back
Dockerfile-front
```

__deployment-diagram__ :

Qui est le diagramme de conception de l'architecture de déploiement.

# 3. Procédure utilisée
## 3.1 Création des dockerfiles

Le but des dockerfiles est de générer des fichiers de configuration qui seront utilisés pour build chacun des composants de l'application (1 pour le front et 1 pour le back).

Globalement, ces fichiers vont créer des espaces de travail éphémère où l'on va : 

- copier les fichiers nécessaire au fonctionnement de l'application contenant les dépendances
- renseigner les commandes nécessaires pour installer ces dépendances et exécuter le contenu

## 3.2 Création des images

Pour chacun des composants front et back, il fallait d'abord générer les images que nous utiliseront via kubernetes. Ces images sont stockées dans un répertoire distant sur Harbor. Plusieurs étapes sont nécessaires pour contruire les images :

- Après avoir créer les dockerfile, il faut générer un build des composants. Pour cela => ```docker build -t harbor.kakor.ovh/ipi/<nom_image>:latest <path_vers_dockerfile>```.
- Une fois le build généré, il nous fallait créer un tag pour renommer l'image avant de la push. ```docker tag <nom_image_build> <nouveau_nom_image_build>```.
- Avant de push l'image tagée, il faut se connecter à Harbor avec cette commande ```docker login harbor.kakor.ovh```et renseigner les login et mot de passe correspondant.
- Pour finir on peut ```docker push <nouveau_nom_image_build>``` et l'image est bien poussée sur le répertoire distant.

# 4. Installation
Pour pouvoir utiliser le site, il faut d'abord y installer tous les éléments nécessaire à son bon fonctionnement. Pour ce faire, la première étape est de :

- Télécharger le projet en cliquant sur ```Download ZIP``` dans la section _Code_ en vert.
- Ou importer le projet via git bash par example via la commande ```git clone https://github.com/P-Benjamin/kubernetes.git```

## 4.1 Déploiement du site

Pour déployer le site, il est nécessaire d'exécuter l'ensemble des fichiers de configuration disponible dans le dossier ```deployment```.

Pour ce faire, ouvrez le dossier du projet cloné dans vscode et rendez-vous dans le dossier ```deployment```. Ensuite, vous pouvez exécuter la commande ```kubectl apply -f .``` qui va exécuter l'ensemble des fichiers de configuration nécessaire pour héberger le site.

Ensuite, 2 commandes supplémentaires doivent être exécutées pour configurer la abse de données :

- En vous mettant à la racine du projet
- ```cmd /c "oc exec -i deployment/mysql -- mysql -uroot -proot < ./database/script.sql"``` pour construire l'architecture de la base de données.
- ```cmd /c "oc exec -i deployment/mysql -- mysql -uroot -proot < ./database/data.sql"``` pour insérer les données dans la base.

# 5. URL d'accès

Le site est actuellement déployé sur openshift. Pour y accéder, vous pouvez vour rendre ici => _https://tissea-grp2.apps.openshift.kakor.ovh/_
