# Fournil - Un outil pratique pour de la boulangerie compliquée (au levain et au feu de bois)

https://thoven.shinyapps.io/PRATIQUE3/

Fournil, c'est pratique : à partir d'une commande (une quantité de pain à fabriquer), l'outil aide à composer des fournées cohérentes, à calibrer les recettes et à planifier la journée de boulot.

## 1 - Saisie de la commande

C’est la base de tout : renseigner la commande permettra de calibrer les recettes et le nombre de fours nécessaires. Pour l’instant, les commandes peuvent se composer de 9 catégories de pains (ces catégories peuvent évoluer si besoin, en revenant au code de l’appli) :

    Pains semi-complets de 500 et 750 g ;
    Pains spéciaux de 300 et 500 g ;
    Pains aux graines de 300 et 500 g ;
    Pains complets de 500 et 750 g ;
    Pain de petit-épeautre de 500 g .

L’onglet « commande » regroupe les champs permettant de saisir le nombre de pains voulu pour chaque type.


## 2 - Calcul de la quantité de pâte pour les différents types de pains

Une fois la commande renseignée, on peut la convertir en quantité de pâte à produire, en distinguant les types de pains voulus. Le calcul de la quantité de pâte à produire s'effectue en tenant compte du « coefficient de marge de manœuvre » (estimant l’évaporation, et permettant de « grossir » légèrement la commande) qui peut être ajusté dans l’onglet « Paramètres » .

Par exemple, la quantité de pâte nécessaire pour réaliser la commande de pain complet est calculée de la manière suivante :

    Quantité brute = [Nb de pains de 500g commandés * 500] + [Nb de pains de 750g commandés * 750]
    Marge à ajouter = Quantité brute * Coef de marge
    Quatité finale = Quantité brute + Marge à ajouter

La quantité de pâte à produire pour chaque type de pain s’affiche dans l’encadré « Résumé de la commande » de l’onglet « commande » .


## 3 - Paramétrage des recettes

Toujours dans l’onglet « commande » , une série de curseurs permet d’ajuster les critères de construction des recettes. Pour les pains semi-complets, complets et de petit-épeautre , il est possible d’ajuster :

    Le taux d’hydratation (exprimé en gramme d’eau à ajouter pour chaque gramme de farine dans la pâte)
    Le taux de levain (exprimé en gramme de levain à ajouter pour chaque gramme de mélange eau + farine de la pâte)
    Le taux de sel (exprimé en gramme de sel à ajouter pour chaque gramme de mélange eau + farine de la pâte).

Les recettes des pains spéciaux et des pains aux graines reprennent les mêmes paramètres que la recette de pain semi-complet, mais il reste possible d’ajuster la quantité d’ ingrédients spéciaux ou de graines (exprimés en gramme pour chaque gramme de pâte).

De base, ces paramètres sont calés sur des valeurs par défaut qui peuvent être modifiées en revenant au code de l’appli.

Il est possible d’ exporter au format Excel les paramètres de construction des recettes en utilisant le bouton « Sauvegarde des proportions » de l’onglet « commande ».


## 4 - Répartition de la commande en fournées cohérentes

La commande peut ensuite être répartie en fournées cohérentes. L’onglet « Pratique 2 » affiche la distribution des pains commandés en fournées de manière à maximiser le remplissage du four et à minimiser les types de recettes pour chaque fournée : on cherche à remplir les fours avec des pains qui se ressemblent le plus possible en termes de recette.

Pour cela, on estime l’occupation du four pour chaque pain qui compose la fournée.

Ces estimations sont construites à partir des champs de la section « Estimation de l’occupation du four » de l’onglet « Paramètres ». Ces champs permettent de renseigner combien il faudrait de pains de 750 g, de 500 g, de 300 g ou de moules pour remplir à le four à 100 %. Ils permettent d’estimer la place occupée par chaque pain commandé dans le four. Les valeurs par défaut ont un peu été attribuées au « doigt levé », elles pourront être modifiées si besoin en revenant au code de l’appli.

On attribue à chaque pain commandé son pourcentage d’occupation de four et on peut alors déterminer la place nécessaire à accorder à chaque recette. Si un type de recette peut à lui seul remplir totalement un four, alors il aura sa fournée réservée. Le plus souvent, il faut plutôt composer des fours qui contiennent plusieurs recettes. Pour cela, on classe les pains commandés par types de recettes et on découpe des « paquets » correspondant à la quantité de pain nécessaire pour remplir le four à 90 %.

Le curseur « Ajustement de la cohérence des fours » sous le tableau permet d’ajuster la marge, et donc de remplir plus ou moins les fours de manière à trouver la meilleure cohérence possible entre les fours.


## 5 - Calcul des recettes pour chaque fournée

Lorsque les fournées cohérentes sont calibrées, le bouton « Calculer les recettes de la (des) fournée(s) » permet de générer les recettes nécessaires à la réalisation des pains contenus dans chacun des fours.

Le calcul des recettes s'effectue en convertissant les quantités de pains de la fournée en quantité de pâte de chaque type, puis en décomposant ce volume de pâte en quantité de farine, d’eau, de levain et de sel (et potentiellement de graines et d’ingrédients spéciaux, si besoin).

Pour calculer les quantités de chaque ingrédient, on part de la formule :

    Pâte (Q_p) = Farine (Q_f) + eau (Q_e) + levain (Q_l) + sel (Q_s) + potentiel ingrédient spécial (Q_sp)

Les quantités d’eau, de levain et de sel s’expriment toutes en fonction de la quantité de farine (cf. partie sur le paramètrage des recettes) :

    Q_e = Taux d’hydratation * Q_f
    Q_l = Taux de levain * [Q_f + (Taux d’hydratation * Q_f)]
    Q_s = Taux de sel * Q_f
    Q_g = Taux de graine * [Q_f + (Taux d’hydratation * Q_f) + (Taux de levain * [Q_f + (Taux d’hydratation * Q_f)]) + (Taux de sel * [Q_f + (Taux d’hydratation * Q_f)])]
    Q_sp = Taux d’ing spé * [Q_f + (Taux d’hydratation * Q_f) + (Taux de levain * [Q_f + (Taux d’hydratation * Q_f)]) + (Taux de sel * [Q_f + (Taux d’hydratation * Q_f)])]

La quantité de pâte est donc fonction de la quantité de farine et, à l’inverse, on peut exprimer la quantité de farine en fonction de la quantité de pâte :

    Q_f = Q_p / [ (1 + tx_sp) * ( 1 + tx_hyd + (1 + tx_hyd) * tx_lev + tx_sel ) ]

Une fois les recettes éditées, elles peuvent être sauvegardées et exportées au format Excel grâce au bouton « Exporter les recettes par fournées ».


## 6 - Alternative : retour sous PRATIQUE 1

Imaginons un cas extrême dans lequel Pratique 2 ne fonctionne pas. Il y aurait une commande bizarre pour laquelle il n’est pas possible de trouver une configuration valable en termes de cohérence des fours.

Dans un tel cas de figure, il peut être valable de revenir à Pratique 1 , dans lequel chaque recette est séparée dans des fours distincts dont on connaît le taux de remplissage. On peut ainsi cumuler des fours de manière à composer soi-même des fournées plus propres que celles proposées par Pratique 2. C’est une sorte de Joker.
