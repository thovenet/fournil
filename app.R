library(shiny)
library(shinythemes)
library(shinydisconnect)
library(shinyscreenshot)
library(formattable)
library(scales)
library(tidyverse)
options(scipen = 999)
library(gt)
library(purrr)
library(timevis)
library(writexl)
library(openxlsx)
library(shinyalert)

# Define UI ----
ui <- fluidPage(theme = shinytheme("cosmo"),
                disconnectMessage(
                  text = "ZZZzzz...",
                  refresh = "Relancer la page",
                  background = "#FFFFFF",
                  colour = "#444444",
                  refreshColour = "#337AB7",
                  overlayColour = "#566157",
                  overlayOpacity = 0.6,
                  width = "full",
                  top = "center",
                  size = 22,
                  css = ""),
                
   ## TITRE GENERAL ----
  titlePanel(title = "Fournil (=PRATIQUE³)"),
  h6(sample(c("“Que préfères-tu, celui qui veut te priver de pain au nom de la liberté ou celui qui veut t’enlever ta liberté pour assurer ton pain ?” - A. Camus",
              "“J’apprécie plus le pain, le pâté, le saucisson que les limitations de vitesse.” - J. Chirac", 
              "“Une idée c'est comme un pain au chocolat. Il faut la laisser refroidir pour voir si elle est vraiment bonne.” - S. Uzzan", 
              "“Le pain gonfle en prenant la forme de la paume du boulanger. Le porter à sa bouche, c'est comme serrer la main de qui l'a pétri.” - E. De Lucca",
              "“Avec la SNCF, j'ai la sensation de me faire rouler dans la farine.” X. Bertrand",
              "“Ce n'est pas une miette de pain, c'est la moisson du monde entier qu'il faut à la race humaine, sans exploiteur et sans exploité.” - L. Michel",
              "“Du Lembas. Du pain de route Elfique. Une bouchée suffit à nourrir l’estomac d’un adulte.” - Legolas",
              "“No pain, no gain”. - B. Franklin",
              "Quel est l'espèce d'arbre préférée des boulanger.e.s ? Le pin ... Allez, va bosser.",
              "Plus d'un riche sur deux est prêt à payer sa baguette 1€50, 41 % des macronistes sont partants aussi contre seulement 12 % des chômeurs... [-> les pauvres ne soutiennent pas les boulangers, c'est pénible] - IFOP pour le JDD",
              "“Je suis un gros pain au chocolat tout chaud et je veux plus jamais sortir de ce lit ... Hin-hin, j'ai envie de pisser... Pense à autre chose... Pense, pense, pense... aah... Vaut mieux que je me lève.” H.J. Sipmson",
              "“Le croustillant et le moelleux sont les deux caractéristiques les plus recherchées. Le croustillant étant recherché par les + de 35 ans, sans enfant et fréquentant les boulangeries artisanales, le moelleux par les familles.” - IFOP pour Banette",
              "“Ce pain-là, il est cuit trop vite dans un four trop chaud ; la montée n'a pas le temps de se faire et il y a trop d'air dans la mie. Donc c'est de la merde.” - Karadoc"),
            1)),
  
  a(href = "https://github.com/thovenet/fournil.git", "thovenet/fournil.git"),
  img(src="repo1.png"),
    
  navbarPage(icon(sample(c("jar-wheat", "money-bill-wheat", "plate-wheat", "building-wheat", "wheat-awn",
                           "money-bill-1-wave","sack-dollar","shopify", "rocket","gears", "truck", "sliders"),1)),
                           
   ## COMMANDE ----
     tabPanel("Commande",
              fluidRow(

              column(width = 6,
               h1("Commande : "),  
               
               h2("Pains semi-complets"),
               fluidRow(column(width = 6,
                  h4(numericInput("SC500", "Pains semi-complets de 500g", value = 0, min = 0))),
                        column(width = 6,
                 h4(numericInput("SC750", "Pains semi-complets de 750g", value = 0, min = 0)))),
               
                 h6(sliderInput("Tx_hydrat_SC", "Taux d'hydradation (en gramme pour 1g de farine)",       min = 0.65,  max = 1,     value = 0.80,  step = 0.005, width = "100%")),
                 h6(sliderInput("Tx_levain_SC", "Taux de levain (en gramme pour 1g de farine + eau)",     min = 0.01,  max = 0.15,  value = 0.11,  step = 0.01 , width = "100%")),
                 h6(sliderInput("Tx_sel_SC",    "Taux de sel (en gramme pour 1g de farine)",              min = 0.013, max = 0.018, value = 0.014, step = 0.001, width = "100%")),
         br(),
               h2("Pains aux graines (recette du pain semi-complet)"),
                h4(numericInput("G500", "Pains aux graines de 500g", value = 0, min = 0)),
                 
                h6(sliderInput("Tx_grain",    "Taux de graines (en gramme pour 1g de pâte)",             min = 0.05,  max = 0.25,  value = 0.15,  step = 0.01 , width = "100%")),
         br(),
               h2("Pains spéciaux (recette du pain semi-complet)"),
               fluidRow(column(width = 6,
                h4(numericInput("SP300", "Pains spéciaux de 300g", value = 0, min = 0))),
                        column(width = 6,
                h4(numericInput("SP500", "Pains spéciaux de 500g", value = 0, min = 0)))),
         
                 h6(sliderInput("Tx_spe_SP",    "Taux d'ingrédient spécial (en gramme pour 1g de pâte)",  min = 0.05, max = 0.25,   value = 0.15,  step = 0.01 , width = "100%")),
         br(),
               h2("Pains complets"),
               fluidRow(column(width = 6,
                h4(numericInput("C500", "Pains complets de 500g", value = 0, min = 0))),
                        column(width = 6,
                h4(numericInput("C750", "Pains complets de 750g", value = 0, min = 0)))),
                 
                 h6(sliderInput("Tx_hydrat_C", "Taux d'hydradation (en gramme pour 1g de farine)",        min = 0.65,  max = 1,     value = 0.80,  step = 0.005, width = "100%")),
                 h6(sliderInput("Tx_levain_C", "Taux de levain (en gramme pour 1g de farine + eau)",      min = 0.01,  max = 0.15,  value = 0.11,  step = 0.01 , width = "100%")),
                 h6(sliderInput("Tx_sel_C",    "Taux de sel (en gramme pour 1g de farine)",               min = 0.013, max = 0.018, value = 0.014, step = 0.001, width = "100%")),
         br(),
               h2("Pains de petit épeautre"),
                h4(numericInput("PE500", "Pains de petit épautre de 500g", value = 0, min = 0)),
                 h6(sliderInput("Tx_hydrat_PE", "Taux d'hydradation (en gramme pour 1g de farine)",       min = 0.65,  max = 1,     value = 0.80,  step = 0.005, width = "100%")),
                 h6(sliderInput("Tx_levain_PE", "Taux de levain (en gramme pour 1g de farine + eau)",     min = 0.01,  max = 0.15,  value = 0.11,  step = 0.01,  width = "100%")),
                 h6(sliderInput("Tx_sel_PE",    "Taux de sel (en gramme pour 1g de farine)",              min = 0.013, max = 0.018, value = 0.014, step = 0.001, width = "100%"))
               ),
         
         column(width = 6, 
                wellPanel(
              h1("Résumé de la commande :"),
              br(),
               textOutput("misscom1"),
               textOutput("ppSC"),
               textOutput("ppG"),
               textOutput("ppC"),
               textOutput("ppPE")),
              downloadButton("telech", "Sauvegarde des proportions"),
              img(src="LOGO.jpg", align = "middle", width = "75%")
              )
         ),
         fluidRow(column(width = 5),
                  column(width = 2, actionLink("cookies", "Politique de gestion des cookies", icon("cookie-bite"))),
                  column(width = 5))
      ),
   
   ## PRATIQUE 2  ----
   tabPanel("Fours & Recettes",
            
            h1("Répartition de la commande en fours cohérents"),
            gt_output("table") %>% shinycssloaders::withSpinner(),
            br(),      
            sliderInput("Ajust", "Ajustement de la cohérence des fours", min = -0.2, max = 0.5, value = 0.1, step = 0.01, width = "100%"),
            br(),
            
            h1("Détails des opéRations :"),
            br(),
            actionButton("go", 
                         "Calculer les recettes de la (des) fournée(s)", 
                         icon(sample(c("check", "download", "sack-dollar", "plate-wheat", 
                                       "magnifying-glass", "bomb", "poo", "hippo", "pen", 
                                       "atom", "rocket","gears", 'thumbs-up', "truck", 
                                       "paper-plane", "dragon", "otter", "paw", "gamepad", 
                                       "scroll", "dungeon"),1)), 
                         style="color: #fff; background-color: #337ab7; border-color: #070808"),
            
            downloadButton("dl", "Exporter les recettes par fournées"),
            
            fluidRow(
              column(width = 6,
                     br(),
                     gt_output("four1") %>% shinycssloaders::withSpinner(),
                     br(),
                     gt_output("four3"),
                     br(),
                     gt_output("four5")),
              
              column(width = 6,
                     br(),
                     gt_output("four2") ,
                     br(),
                     gt_output("four4"))
            )
   ),
   
   
   ## PRATIQUE 1 ----
     tabPanel("Joker",
              h1("Fournées :"),
              textOutput("misscom2"),
              fluidRow(
                column(width = 6,
              tableOutput("fourSC") %>% shinycssloaders::withSpinner(),
              br(),
              tableOutput("fourSP"),
              br(),
              tableOutput("fourPE")),
              
                column(width = 6,
              tableOutput("fourG"),
              br(),
              tableOutput("fourC"))
              )),
              


   ## PARAMETRES ----
     tabPanel("Paramètres",
              h1("Paramètres généraux :"),
              
              h2("Marge :"),
              sliderInput("Evap", "Coef de marge de manoeuvre (évaporation et quelques pains de plus)", min = 0, max = 1, value = 0.15, step = 0.05),
              br(),
              
              h2("Taille du four :"),
              numericInput("taille_four", "Taille du four (en g de pâte)", value = 25000, step = 100),
              br(),
              
              h2("Estimation de l'occupation du four :"),
              h4("Pour remplir le four à 100 %, il faudrait (à peu prés) : "),
              
              h6(numericInput("occ750", "Nombre de pains de 750g", value = 40,  step = 1)),
              h6("ou"),
              h6(numericInput("occ500", "Nombre de pains de 500g", value = 45,  step = 1)),
              h6("ou"),
              h6(numericInput("occ300", "Nombre de pains de 300g", value = 70,  step = 1)),
              h6("ou"),
              h6(numericInput("occMou", "Nombre de pains moulés de 500g", value = 100, step = 1))
              
              ),
   ## Read-me ----
   tabPanel(icon("readme"), 
            h1("Fournil - Un outil pratique pour de la boulangerie compliquée (au levain et au feu de bois)"),
            h2(strong("Fournil, c'est pratique : à partir d'une commande (une quantité de pain à fabriquer), l'outil aide à composer des fournées cohérentes, à calibrer les recettes et à planifier la journée de boulot.")),
          br(),  
            h1("1 - Saisie de la commande"),
            div("C’est la base de tout : renseigner la ", strong("commande"), "permettra de calibrer les ", 
                strong("recettes"), "et le ", strong("nombre de fours"), "nécessaires. Pour l’instant, les commandes peuvent se composer de ", 
                strong("9 catégories de pains"),  "(ces catégories peuvent évoluer si besoin, en revenant au code de l’appli) :",
                tags$ul(tags$li("Pains",   strong("semi-complets"),  " de ", strong("500")," et ", strong("750 g"), " ;"),
                        tags$li("Pains",   strong("spéciaux"),       " de ", strong("300")," et ", strong("500 g"), " ;"),
                        tags$li("Pains",   strong(" aux graines"),   " de ", strong("300")," et ", strong("500 g"), " ;"),
                        tags$li("Pains",   strong(" complets"),      " de ", strong("500")," et ", strong("750 g"), " ;"),
                        tags$li("Pain de", strong(" petit-épeautre")," de ", strong("500 g"),".")),
                "L’onglet ", strong("« commande »"), "regroupe les champs permettant de saisir le nombre de pains voulu pour chaque type."),
          br(),
            h1("2 - Calcul de la quantité de pâte pour les différents types de pains"),
            div(p("Une fois la commande renseignée, on peut la convertir en", strong("quantité de pâte"), "à produire, en distinguant les types de pains voulus. 
                Le calcul de la quantité de pâte à produire s'effectue en tenant compte du", strong(" « coefficient de marge de manœuvre »"),
                "(estimant l’évaporation, et permettant de « grossir » légèrement la commande) qui peut être ajusté dans l’onglet", strong("« Paramètres »"),"."),
                p("Par exemple, la quantité de pâte nécessaire pour réaliser la commande de pain complet est calculée de la manière suivante :"),
                code(tags$i(p("Quantité brute = [Nb de pains de 500g commandés * 500] + [Nb de pains de 750g commandés * 750]"),
                            p("Marge à ajouter = Quantité brute * Coef de marge"),
                            p("Quatité finale = Quantité brute + Marge à ajouter")),  .noWS = c("outside", "after-begin", "before-end")),
                p("La quantité de pâte à produire pour chaque type de pain s’affiche dans l’encadré", strong("  « Résumé de la commande »"), "de l’onglet", strong("  « commande »"),".")),
          br(),
            h1("3 -	Paramétrage des recettes"),
            div(p("Toujours dans l’onglet", strong(" « commande »"), ", une série de curseurs permet d’ajuster les critères de construction des recettes. Pour les pains ", strong("semi-complets, complets et de petit-épeautre"), ", il est possible d’ajuster :"),
                tags$ul(tags$li("Le ", strong("taux d’hydratation"), " (exprimé en gramme d’eau à ajouter pour chaque gramme de farine dans la pâte)"),
                        tags$li("Le ", strong("taux de levain"), " (exprimé en gramme de levain à ajouter pour chaque gramme de mélange eau + farine de la pâte)"),
                        tags$li("Le ", strong("taux de sel"), " (exprimé en gramme de sel à ajouter pour chaque gramme de mélange eau + farine de la pâte).")),
                p("Les recettes des ", strong("pains spéciaux et des pains aux graines"), "reprennent les mêmes paramètres que la recette de pain semi-complet, mais il reste possible d’ajuster la quantité d’", strong("ingrédients spéciaux ou de graines"), " (exprimés en gramme pour chaque gramme de pâte)."),
                p("De base, ces paramètres sont calés sur des valeurs par défaut qui peuvent être modifiées en revenant au code de l’appli."),
                p("Il est possible d’", strong("exporter au format Excel")," les paramètres de construction des recettes en utilisant le bouton ", strong("« Sauvegarde des proportions »")," de l’onglet ", strong("« commande ». "))),
          br(),
            h1("4 - Répartition de la commande en fournées cohérentes"),
            div(p("La commande peut ensuite être répartie en fournées cohérentes. L’onglet ", 
                strong("« Fours & Recettes »"), "affiche la distribution des pains commandés en fournées de manière à maximiser le remplissage du four et à minimiser les types de recettes pour chaque fournée : on cherche à remplir les fours avec des pains qui se ressemblent le plus possible en termes de recette."),
                p("Pour cela, on estime l’occupation du four pour chaque pain qui compose la fournée."), 
                p("Ces estimations sont construites à partir des champs de la section ", strong("« Estimation de l’occupation du four »"), "de l’onglet" , strong("« Paramètres »."), "Ces champs permettent de renseigner combien il faudrait de pains de 750 g, de 500 g, de 300 g ou de moules pour remplir à le four à 100 %. Ils permettent d’estimer la place occupée par chaque pain commandé dans le four. Les valeurs par défaut ont un peu été attribuées au", tags$i("« doigt levé »,")," elles pourront être modifiées si besoin en revenant au code de l’appli."),
                p("On attribue à chaque pain commandé son pourcentage d’occupation de four et on peut alors déterminer la place nécessaire à accorder à chaque recette. Si un type de recette peut à lui seul remplir totalement un four, alors il aura sa fournée réservée. Le plus souvent, il faut plutôt composer des fours qui contiennent plusieurs recettes. Pour cela, on classe les pains commandés par types de recettes et on découpe des « paquets » correspondant à la quantité de pain nécessaire pour remplir le four à 90 %."), 
                p("Le curseur", strong("« Ajustement de la cohérence des fours »"), "sous le tableau permet d’ajuster la marge, et donc de remplir plus ou moins les fours de manière à trouver la meilleure cohérence possible entre les fours.")),
          br(),
            h1("5 - Calcul des recettes pour chaque fournée"),
            div(p("Lorsque les fournées cohérentes sont calibrées, le bouton ", strong("« Calculer les recettes de la (des) fournée(s) »", "permet de générer les recettes nécessaires à la réalisation des pains contenus dans chacun des fours."),
                p("Le calcul des recettes s'effectue en convertissant les quantités de pains de la fournée en quantité de pâte de chaque type, puis en décomposant ce volume de pâte en quantité de farine, d’eau, de levain et de sel (et potentiellement de graines et d’ingrédients spéciaux, si besoin)."),
                p("Pour calculer les quantités de chaque ingrédient, on part de la formule :"),
                 code(tags$i(p("Pâte (Q_p) = Farine (Q_f) + eau (Q_e) + levain (Q_l) + sel (Q_s) + potentiel ingrédient spécial (Q_sp)"))),
                p("Les quantités d’eau, de levain et de sel s’expriment toutes en fonction de la quantité de farine (cf. partie sur le paramètrage des recettes) :"),
                 code(tags$i(p("Q_e = Taux d’hydratation * Q_f"),
                             p("Q_l = Taux de levain * [Q_f + (Taux d’hydratation * Q_f)]"),
                             p("Q_s = Taux de sel * Q_f"),
                             p("Q_g = Taux de graine * [Q_f + (Taux d’hydratation * Q_f) + (Taux de levain * [Q_f + (Taux d’hydratation * Q_f)]) + (Taux de sel * [Q_f + (Taux d’hydratation * Q_f)])]"), 
                             p("Q_sp = Taux d’ing spé * [Q_f + (Taux d’hydratation * Q_f) + (Taux de levain * [Q_f + (Taux d’hydratation * Q_f)]) + (Taux de sel * [Q_f + (Taux d’hydratation * Q_f)])]"))), 
                p("La quantité de pâte est donc fonction de la quantité de farine et, à l’inverse, on peut exprimer la quantité de farine en fonction de la quantité de pâte :"),
                 code(tags$i(p("Q_f = Q_p / [ (1 + tx_sp) * ( 1 + tx_hyd + (1 + tx_hyd) * tx_lev + tx_sel ) ]"))),
                p("Une fois les recettes éditées, elles peuvent être sauvegardées et exportées au format Excel grâce au bouton « Exporter les recettes par fournées »."))),
          br(),
            h1("6 - Alternative"),
            div(p("Imaginons un cas extrême dans lequel il y aurait une commande bizarre pour laquelle il n’est pas possible de trouver une configuration valable en termes de cohérence des fours."), 
                p("Dans un tel cas de figure, il peut être valable de décomposer différemment la commande. C'est ce que propose l'onglet ", strong("Joker"),", dans lequel chaque recette est séparée dans des fours distincts dont on connaît le taux de remplissage. On peut ainsi cumuler des fours de manière à composer soi-même des fournées plus propres que celles proposées par l'onglet ", strong("Fours & Recettes"),". C’est une sorte de Joker.")),
#          br(),
#            h1("7 - Expérimentation : planification de la panification"),
          br(), br(), br()),

   ## EMPLOI DU TEMPS ----
tabPanel("",
         h1("Planification de la journée :"),

         textInput("heure_deb", "Heure de début de la journée :", value = "08:00"),
         h2("Emploi du temps :"),
         timevisOutput("timeline"),
         br(),
         br(),
         actionButton("screen", 
                      "Sauvegarde en image",
                      icon("camera")),
         fluidRow(
           column(width = 6,
                  h6(numericInput("mel_r1", "Minutes entre le melange et le 1er rabat :", value = 45, step = 5)),
                  h6(numericInput("r2_fac", "Minutes entre le 2nd rabat et le façonnage :", value = 45, step = 5)),
                  h6(numericInput("chau", "Minutes dont le four a besoin pour chauffer la 1ère fois :", value = 60, step = 5)),
                  h6(numericInput("cui", "Minutes de cuisson : ", value = 60, step = 5))),
           
           column(width = 6,
                  h6(numericInput("r1_r2", "Minutes entre le 1er et le 2nd rabat :", value = 45, step = 5)),
                  h6(numericInput("fac_enf", "Minutes entre le façonnage et l'enfournement :", value = 45, step = 5)),
                  h6(numericInput("chau2", "Minutes dont le four a besoin pour rechauffer ensuite :", value = 45, step = 5)),
                  h6(numericInput("ress", "Minutes de ressuage : ", value = 45, step = 5)))
         ))
))


# Define server logic ----
server <- function(input, output) {

  observeEvent(input$cookies, {
    shinyalert("Il faut gérer les cookies !", 
               "Je m'engage à manger des cookies dès que l'occasion se présente.", 
               type = "success",
               showConfirmButton = TRUE,
               confirmButtonText = "OK !")})
  
   ## Commentaire de remplacement ----
output$misscom1 <- renderText({
    validate(need(input$SC750 + input$SC500 +
                  input$G500 +
                  input$SP500 + input$SP300 +
                  input$C750  + input$C500 +
                  input$PE500 > 0 , 
                  "Il faut rentrer une commande ..."))})

output$misscom2 <- renderText({
  validate(need(input$SC750 + input$SC500 +
                  input$G500 +
                  input$SP500 + input$SP300 +
                  input$C750  + input$C500 +
                  input$PE500 > 0 , 
                  "Il faut rentrer une commande ..."))})

   ## Résumé de la commande ----
  poids_pate_SC <- reactive( {
    
    Tx_i_SP <- (1 + input$Tx_hydrat_SC + (1+input$Tx_hydrat_SC)*input$Tx_levain_SC + input$Tx_sel_SC) * input$Tx_spe_SP / ((1 + input$Tx_hydrat_SC + (1+input$Tx_hydrat_SC)*input$Tx_levain_SC + input$Tx_sel_SC) + ((1 + input$Tx_hydrat_SC + (1+input$Tx_hydrat_SC)*input$Tx_levain_SC + input$Tx_sel_SC)*input$Tx_spe_SP))
  
    Poids_pate_SP <- (round(input$SP300 * input$Evap + input$SP300,0)*300 + round(input$SP500 * input$Evap + input$SP500,0)*500) -
                     (round(input$SP300 * input$Evap + input$SP300,0)*300 + round(input$SP500 * input$Evap + input$SP500,0)*500) * Tx_i_SP
    
    Poids_commande_SC <- round(input$SC750 * input$Evap + input$SC750,0)*750 +
                         round(input$SC500 * input$Evap + input$SC500,0)*500 + 
                         Poids_pate_SP
                         
    label_number(big.mark = " ")(Poids_commande_SC)
  }) 

  poids_pate_G <- reactive( {
     Tx_i_G <- (1 + input$Tx_hydrat_SC + (1+input$Tx_hydrat_SC)*input$Tx_levain_SC + input$Tx_sel_SC) * input$Tx_grain / ((1 + input$Tx_hydrat_SC + (1+input$Tx_hydrat_SC)*input$Tx_levain_SC + input$Tx_sel_SC) + ((1 + input$Tx_hydrat_SC + (1+input$Tx_hydrat_SC)*input$Tx_levain_SC + input$Tx_sel_SC)*input$Tx_grain))
     Poids_commande_G <- round(input$G500 * input$Evap + input$G500,0)*500 -
                         round(input$G500 * input$Evap + input$G500,0)*500 * Tx_i_G
     label_number(big.mark = " ")(Poids_commande_G)
  }) 
  
  poids_pate_C <- reactive( {
    Poids_commande_C <- round(input$C750 * input$Evap + input$C750, 0)*750 +
                        round(input$C500 * input$Evap + input$C500, 0)*500
    label_number(big.mark = " ")(Poids_commande_C)
  })
  
  poids_pate_PE <- reactive( {
    Poids_commande_PE <- round(input$PE500 * input$Evap + input$PE500,0)*(500 + (500*0.02))
    label_number(big.mark = " ")(Poids_commande_PE)
  })
  
  output$ppSC <- renderText({
     validate(need(input$SC750 + input$SC500 > 0 , ""))
     paste0("- ", poids_pate_SC(), " g de pâte à pain semi-complet (pains spéciaux compris)")
     })
  output$ppG  <- renderText({
     validate(need(input$G500 > 0 , ""))
     paste0("- ", poids_pate_G() , " g de pâte à pain aux graines")
  })
  output$ppC  <- renderText({
     validate(need(input$C750 + input$C500 > 0 , ""))
     paste0("- ", poids_pate_C() , " g de pâte à pain complet")
     })
  output$ppPE <- renderText({
     validate(need(input$PE500 > 0 , ""))
     paste0("- ", poids_pate_PE(), " g de pâte à pain de petit-épeautre")
     })

  tab_SC <- reactive({tibble(.rows = 1) %>% mutate(
    Hydratation = label_number(suffix = " %",       accuracy = 0.1)(input$Tx_hydrat_SC*100),
    Levain      = label_number(suffix = " %", accuracy = 0.1)(input$Tx_levain_SC*100),
    Sel         = label_number(suffix = " %", accuracy = 0.1)(input$Tx_sel_SC   *100)) %>% 
      pivot_longer(seq_along(.)) %>%
      select("Pains semi-complets" = name, " " = value)})
  tab_C <- reactive({tibble(.rows = 1) %>% mutate(
    Hydratation = label_number(suffix = " %",       accuracy = 0.1)(input$Tx_hydrat_C*100),
    Levain      = label_number(suffix = " %", accuracy = 0.1)(input$Tx_levain_C*100),
    Sel         = label_number(suffix = " %", accuracy = 0.1)(input$Tx_sel_C   *100)) %>% 
      pivot_longer(seq_along(.)) %>%
      select("Pains complets" = name, " " = value) })
  tab_PE <- reactive({tibble(.rows = 1) %>% mutate(
    Hydratation = label_number(suffix = " % ",       accuracy = 0.1)(input$Tx_hydrat_PE*100),
    Levain      = label_number(suffix = " % ", accuracy = 0.1)(input$Tx_levain_PE*100),
    Sel         = label_number(suffix = " % ", accuracy = 0.1)(input$Tx_sel_PE   *100)) %>% 
      pivot_longer(seq_along(.)) %>%
      select("Pains de petit-épeautre" = name, " " = value) })
  tab_SP <- reactive({tibble(.rows = 1) %>% mutate(
    "Ing. spé." = label_number(suffix = " %", accuracy = 0.1)(input$Tx_spe_SP*100)) %>% 
      pivot_longer(seq_along(.)) %>%
      select("Pains spéciaux" = name , " " = value) })
  tab_G <- reactive({tibble(.rows = 1) %>% mutate(
    "Graines" = label_number(suffix = " %", accuracy = 0.1)(input$Tx_grain*100)) %>% 
      pivot_longer(seq_along(.)) %>%
      select("Pains aux graines" = name, " " = value) })

  output$telech <- downloadHandler(filename = function() {paste0("Proportions_",Sys.Date()+1,".xlsx" )}, 
                               content = function(file) {
                                 my_workbook <- createWorkbook()
                                 
                                 addWorksheet(wb = my_workbook, sheetName = "Proportions")
                                 
                                 setColWidths(my_workbook, sheet = 1, cols = 1:2, widths = c(28, 12))
                                 writeData(my_workbook, sheet = 1, "Proportions pour la préparation des recettes", startRow = 1, startCol = 1)
                                 addStyle(my_workbook, sheet = 1, style = createStyle(fontSize = 20, textDecoration = "bold"), rows = 1, cols = 1)
                                 
                                 writeData(my_workbook, sheet = 1, "Date :", startRow = 3, startCol = 1)
                                 addStyle(my_workbook, sheet = 1, style = createStyle(halign = "right",  fontSize = 12, textDecoration = "italic"), rows = 3, cols = 1)
                                 writeData(my_workbook, sheet = 1, as.character(Sys.Date()+1), startRow = 3, startCol = 2)
                                 addStyle(my_workbook, sheet = 1, style = createStyle(halign  = "center",  fontSize = 12, textDecoration = "italic"), rows = 3, cols = 2)
                                 
                                 writeData(my_workbook, sheet = 1, tab_SC(), startRow = 4, startCol = 1)
                                 addStyle(my_workbook, sheet = 1, style = createStyle(fontSize = 14, fgFill = "#1a5bc4", fontColour = "#ffffff"), rows = 4, cols = 1:2, gridExpand = TRUE)

                                 writeData(my_workbook, sheet = 1, tab_G(), startRow = 8, startCol = 1)
                                 addStyle(my_workbook, sheet = 1, style = createStyle(fontSize = 14, fgFill = "#1a5bc4", fontColour = "#ffffff"), rows = 8, cols = 1:2, gridExpand = TRUE)

                                 writeData(my_workbook, sheet = 1, tab_SP(), startRow = 10, startCol = 1)
                                 addStyle(my_workbook, sheet = 1, style = createStyle(fontSize = 14, fgFill = "#1a5bc4", fontColour = "#ffffff"), rows = 10, cols = 1:2, gridExpand = TRUE)

                                 writeData(my_workbook, sheet = 1, tab_C(), startRow = 12, startCol = 1)
                                 addStyle(my_workbook, sheet = 1, style = createStyle(fontSize = 14, fgFill = "#1a5bc4", fontColour = "#ffffff"), rows = 12, cols = 1:2, gridExpand = TRUE)

                                 writeData(my_workbook, sheet = 1, tab_PE(), startRow = 16, startCol = 1)
                                 addStyle(my_workbook, sheet = 1, style = createStyle(fontSize = 14, fgFill = "#1a5bc4", fontColour = "#ffffff"), rows = 16, cols = 1:2, gridExpand = TRUE)

                                 saveWorkbook(my_workbook, file)
                               })
  
   ## PRATIQUE 1 ----
  ## Fournées SC ----
  four_SC <- function() {
    # Poids de commande et poids de pâte
    Poids_pate <- round(input$SC750 * input$Evap + input$SC750,0)*750 +
      round(input$SC500 * input$Evap + input$SC500,0)*500
    
    # recup des % de chaque ingrédients dans la préparation
    Txf <- 1 / (1 + input$Tx_hydrat_SC + (1 + input$Tx_hydrat_SC) * input$Tx_levain_SC + input$Tx_sel_SC)
    Txe <- Txf * input$Tx_hydrat_SC
    Txl <- (Txf + Txe)*input$Tx_levain_SC
    Txs <- Txf * input$Tx_sel_SC

    # repartition des fournées
    temp <- data.frame("grammes" = 1:Poids_pate)
    temp$four                                   <- "Four1"
    temp$four[temp$grammes>input$taille_four]   <- "Four2"
    temp$four[temp$grammes>2*input$taille_four] <- "Four3"
    temp$four[temp$grammes>3*input$taille_four] <- "Four4"
    temp$four[temp$grammes>4*input$taille_four] <- "Four5"
    temp$four[temp$grammes>5*input$taille_four] <- "Four6"
    temp$four[temp$grammes>6*input$taille_four] <- "Four7"
    temp$four[temp$grammes>7*input$taille_four] <- "Four8"
    temp$four[temp$grammes>8*input$taille_four] <- "Four9"
    temp$four[temp$grammes>9*input$taille_four] <- "Four10"
    
    rep_four <- temp %>% group_by(four) %>% count() %>% rename("g_pate" = n) %>%
      mutate(g_pate = if_else(g_pate == 2, 0, g_pate))
    
    m750 <- ((input$SC750*750)+(input$SC750*750)*input$Evap) / Poids_pate
    m500 <- ((input$SC500*500)+(input$SC500*500)*input$Evap) / Poids_pate
    
    rep_four %>% mutate(N_750 = round((g_pate * m750)/750,0),
                        N_500 = round((g_pate * m500)/500,0),
                        g_farine = round(g_pate*Txf,0),
                        g_eau = round(g_pate*Txe,0),
                        g_levain = round(g_pate*Txl,0),
                        g_sel = round(g_pate*Txs,0)) %>%
      mutate(remp = g_pate/input$taille_four*100) %>%
      mutate(g_pate = label_number(big.mark = " ", suffix = "g")(g_pate),
             N_750 = label_number(big.mark = " ")(N_750),
             N_500 = label_number(big.mark = " ")(N_500),
             g_farine = label_number(big.mark = " ", suffix = "g")(g_farine),
             g_eau = label_number(big.mark = " ", suffix = "g")(g_eau),
             g_levain = label_number(big.mark = " ", suffix = "g")(g_levain),
             g_sel = label_number(big.mark = " ", suffix = "g")(g_sel),
             remp = label_number(big.mark = " ", suffix = " %")(remp)) %>%
      rename("Quantité de pâte :" = g_pate,
             "Pains de 750g :" = N_750,
             "Pains de 500g :" = N_500,
             "Farine semi-complète :" = g_farine,
             "Eau :" = g_eau,
             "Levain :" = g_levain,
             "Sel :" = g_sel,
             "% de remplissage :" = remp) %>%
      pivot_longer(2:9) %>%
      pivot_wider(names_from = four, values_from = value) %>%
      rename(" " = "name") %>%
      gt(rowname_col = " ") %>%
      tab_header(title = md("**Pain semi-complet**")) %>% 
      tab_style(style = cell_text(weight = "bold"), locations = cells_stub()) %>% 
      tab_style(style = cell_text(weight = "bold"), locations = cells_column_labels())
    
  }   
  output$fourSC <- render_gt({
    validate(need(input$SC750 + input$SC500 > 0 , ""))
    four_SC()})
  
  ## Fournées G ----
  four_G <- function() {
    # Poids de commande et poids de pâte
    Poids_pate <- round(input$G500 * input$Evap + input$G500,0)*500
    
    # recup des % de chaque ingrédients dans la préparation
    Txf <- 1 / ((1+ input$Tx_grain)*(1 + input$Tx_hydrat_SC + (1 + input$Tx_hydrat_SC) * input$Tx_levain_SC + input$Tx_sel_SC))
    Txe <- Txf * input$Tx_hydrat_SC
    Txl <- (Txf + Txe)*input$Tx_levain_SC
    Txs <- Txf * input$Tx_sel_SC
    Txi <- (Txf + Txe + Txl + Txs) * input$Tx_grain
    
    # repartition des fournées
    temp <- data.frame("grammes" = 1:Poids_pate)
    temp$four                                   <- "Four1"
    temp$four[temp$grammes>input$taille_four]   <- "Four2"
    temp$four[temp$grammes>2*input$taille_four] <- "Four3"
    temp$four[temp$grammes>3*input$taille_four] <- "Four4"
    temp$four[temp$grammes>4*input$taille_four] <- "Four5"
    temp$four[temp$grammes>5*input$taille_four] <- "Four6"
    temp$four[temp$grammes>6*input$taille_four] <- "Four7"
    temp$four[temp$grammes>7*input$taille_four] <- "Four8"
    temp$four[temp$grammes>8*input$taille_four] <- "Four9"
    temp$four[temp$grammes>9*input$taille_four] <- "Four10"
    
    rep_four <- temp %>% group_by(four) %>% count() %>% rename("g_pate" = n) %>%
      mutate(g_pate = if_else(g_pate == 2, 0, g_pate))
    
    m500 <- ((input$G500*500)+(input$G500*500)*input$Evap) / Poids_pate    
    
    rep_four %>% mutate(N_500 = round((g_pate * m500)/500,0),
                        g_farine = round(g_pate*Txf,0),
                        g_eau = round(g_pate*Txe,0),
                        g_levain = round(g_pate*Txl,0),
                        g_sel = round(g_pate*Txs,0),
                        g_grain = round(g_pate*Txi,0)) %>%
      mutate(remp = g_pate/input$taille_four*100) %>%
      mutate(g_pate = label_number(big.mark = " ", suffix = "g")(g_pate),
             N_500 = label_number(big.mark = " ")(N_500),
             g_farine = label_number(big.mark = " ", suffix = "g")(g_farine),
             g_eau = label_number(big.mark = " ", suffix = "g")(g_eau),
             g_levain = label_number(big.mark = " ", suffix = "g")(g_levain),
             g_sel = label_number(big.mark = " ", suffix = "g")(g_sel),
             g_grain = label_number(big.mark = " ", suffix = "g")(g_grain),
             remp = label_number(big.mark = " ", suffix = " %")(remp)) %>%
      rename("Quantité de pâte :" = g_pate,
             "Pains de 500g :" = N_500,
             "Farine semi-complète :" = g_farine,
             "Eau :" = g_eau,
             "Levain :" = g_levain,
             "Sel :" = g_sel,
             "Graines :" = g_grain,
             "% de remplissage :" = remp) %>%
      pivot_longer(2:9) %>%
      pivot_wider(names_from = four, values_from = value) %>%
      rename(" " = "name") %>%
      gt(rowname_col = " ") %>%
      tab_header(title = md("**Pains aux graines**")) %>% 
      tab_style(style = cell_text(weight = "bold"), locations = cells_stub()) %>% 
      tab_style(style = cell_text(weight = "bold"), locations = cells_column_labels())
  }   
  output$fourG <- render_gt({
    validate(need(input$G500 > 0 , ""))
    four_G()})  
  
  ## Fournées SP ----
  four_SP <- function() {
    # Poids de commande et poids de pâte
    Poids_pate <- round(input$SP300 * input$Evap + input$SP300,0)*300 +
      round(input$SP500 * input$Evap + input$SP500,0)*500
    
    # recup des % de chaque ingrédients dans la préparation
    Txf <- 1 / ((1+ input$Tx_spe_SP)*(1 + input$Tx_hydrat_SC + (1 + input$Tx_hydrat_SC) * input$Tx_levain_SC + input$Tx_sel_SC))
    Txe <- Txf * input$Tx_hydrat_SC
    Txl <- (Txf + Txe)*input$Tx_levain_SC
    Txs <- Txf * input$Tx_sel_SC
    Txi <- (Txf + Txe + Txl + Txs) * input$Tx_spe_SP
    
    
    # repartition des fournées
    temp <- data.frame("grammes" = 1:Poids_pate)
    temp$four                                   <- "Four1"
    temp$four[temp$grammes>input$taille_four]   <- "Four2"
    temp$four[temp$grammes>2*input$taille_four] <- "Four3"
    temp$four[temp$grammes>3*input$taille_four] <- "Four4"
    temp$four[temp$grammes>4*input$taille_four] <- "Four5"
    temp$four[temp$grammes>5*input$taille_four] <- "Four6"
    temp$four[temp$grammes>6*input$taille_four] <- "Four7"
    temp$four[temp$grammes>7*input$taille_four] <- "Four8"
    temp$four[temp$grammes>8*input$taille_four] <- "Four9"
    temp$four[temp$grammes>9*input$taille_four] <- "Four10"
    
    rep_four <- temp %>% group_by(four) %>% count() %>% rename("g_pate" = n) %>%
      mutate(g_pate = if_else(g_pate == 2, 0, g_pate))
    
    m300 <- ((input$SP300*300)+(input$SP300*300)*input$Evap) / Poids_pate
    m500 <- ((input$SP500*500)+(input$SP500*500)*input$Evap) / Poids_pate    
    
    rep_four %>% mutate(N_300 = round((g_pate * m300)/300,0),
                        N_500 = round((g_pate * m500)/500,0),
                        g_farine = round(g_pate*Txf,0),
                        g_eau = round(g_pate*Txe,0),
                        g_levain = round(g_pate*Txl,0),
                        g_sel = round(g_pate*Txs,0),
                        g_spe = round(g_pate*Txi,0)) %>%
      mutate(remp = g_pate/input$taille_four*100) %>%
      mutate(g_pate = label_number(big.mark = " ", suffix = "g")(g_pate),
             N_300 = label_number(big.mark = " ")(N_300),
             N_500 = label_number(big.mark = " ")(N_500),
             g_farine = label_number(big.mark = " ", suffix = "g")(g_farine),
             g_eau = label_number(big.mark = " ", suffix = "g")(g_eau),
             g_levain = label_number(big.mark = " ", suffix = "g")(g_levain),
             g_sel = label_number(big.mark = " ", suffix = "g")(g_sel),
             g_spe = label_number(big.mark = " ", suffix = "g")(g_spe),
             remp = label_number(big.mark = " ", suffix = " %")(remp)) %>%
      rename("Quantité de pâte :" = g_pate,
             "Pains de 300g :" = N_300,
             "Pains de 500g :" = N_500,
             "Farine semi-complète :" = g_farine,
             "Eau :" = g_eau,
             "Levain :" = g_levain,
             "Sel :" = g_sel,
             "Ingrédient spécial :" = g_spe,
             "% de remplissage :" = remp) %>%
      pivot_longer(2:10) %>%
      pivot_wider(names_from = four, values_from = value) %>%
      rename(" " = "name") %>%
      gt(rowname_col = " ") %>%
      tab_header(title = md("**Pains spéciaux**")) %>% 
      tab_style(style = cell_text(weight = "bold"), locations = cells_stub()) %>% 
      tab_style(style = cell_text(weight = "bold"), locations = cells_column_labels())
  }   
  output$fourSP <- render_gt({
    validate(need(input$SP500 + input$SP300 > 0 , ""))
    four_SP()})  
  
  ## Fournées C ----
  four_C <- function() {
    # Poids de commande et poids de pâte
    Poids_pate <- round(input$C750 * input$Evap + input$C750,0)*750 +
      round(input$C500 * input$Evap + input$C500,0)*500
    
    # recup des % de chaque ingrédients dans la préparation
    Txf <- 1 / (1 + input$Tx_hydrat_C + (1 + input$Tx_hydrat_C) * input$Tx_levain_C + input$Tx_sel_C)
    Txe <- Txf * input$Tx_hydrat_C
    Txl <- (Txf + Txe)*input$Tx_levain_C
    Txs <- Txf * input$Tx_sel_C
    
    # repartition des fournées
    temp <- data.frame("grammes" = 1:Poids_pate)
    temp$four                                   <- "Four1"
    temp$four[temp$grammes>input$taille_four]   <- "Four2"
    temp$four[temp$grammes>2*input$taille_four] <- "Four3"
    temp$four[temp$grammes>3*input$taille_four] <- "Four4"
    temp$four[temp$grammes>4*input$taille_four] <- "Four5"
    temp$four[temp$grammes>5*input$taille_four] <- "Four6"
    temp$four[temp$grammes>6*input$taille_four] <- "Four7"
    temp$four[temp$grammes>7*input$taille_four] <- "Four8"
    temp$four[temp$grammes>8*input$taille_four] <- "Four9"
    temp$four[temp$grammes>9*input$taille_four] <- "Four10"
    
    rep_four <- temp %>% group_by(four) %>% count() %>% rename("g_pate" = n) %>%
      mutate(g_pate = if_else(g_pate == 2, 0, g_pate))
    
    m750 <- ((input$C750*750)+(input$C750*750)*input$Evap) / Poids_pate
    m500 <- ((input$C500*500)+(input$C500*500)*input$Evap) / Poids_pate
    
    rep_four %>% mutate(N_750 = round((g_pate * m750)/750,0),
                        N_500 = round((g_pate * m500)/500,0),
                        g_farine = round(g_pate*Txf,0),
                        g_eau = round(g_pate*Txe,0),
                        g_levain = round(g_pate*Txl,0),
                        g_sel = round(g_pate*Txs,0)) %>%
      mutate(remp = g_pate/input$taille_four*100) %>%
      mutate(g_pate = label_number(big.mark = " ", suffix = "g")(g_pate),
             N_750 = label_number(big.mark = " ")(N_750),
             N_500 = label_number(big.mark = " ")(N_500),
             g_farine = label_number(big.mark = " ", suffix = "g")(g_farine),
             g_eau = label_number(big.mark = " ", suffix = "g")(g_eau),
             g_levain = label_number(big.mark = " ", suffix = "g")(g_levain),
             g_sel = label_number(big.mark = " ", suffix = "g")(g_sel),
             remp = label_number(big.mark = " ", suffix = " %")(remp)) %>%
      rename("Quantité de pâte :" = g_pate,
             "Pains de 750g :" = N_750,
             "Pains de 500g :" = N_500,
             "Farine complète :" = g_farine,
             "Eau :" = g_eau,
             "Levain :" = g_levain,
             "Sel :" = g_sel,
             "% de remplissage :" = remp) %>%
      pivot_longer(2:9) %>%
      pivot_wider(names_from = four, values_from = value) %>%
      rename(" " = "name") %>%
      gt(rowname_col = " ") %>%
      tab_header(title = md("**Pain complet**")) %>% 
      tab_style(style = cell_text(weight = "bold"), locations = cells_stub()) %>% 
      tab_style(style = cell_text(weight = "bold"), locations = cells_column_labels())
  }   
  output$fourC <- render_gt({
    validate(need(input$C750 + input$C500 > 0 , ""))
    four_C()})  
  
  ## Fournées PE ----
  four_PE <- function() {
    # Poids de commande et poids de pâte
    Poids_pate <- round(input$PE500 * input$Evap + input$PE500,0)*(500 + (500*0.02))
    
    # recup des % de chaque ingrédients dans la préparation
    Txf <- 1 / (1 + input$Tx_hydrat_PE + (1 + input$Tx_hydrat_PE) * input$Tx_levain_PE + input$Tx_sel_PE)
    Txe <- Txf * input$Tx_hydrat_PE
    Txl <- (Txf + Txe)*input$Tx_levain_PE
    Txs <- Txf * input$Tx_sel_PE
    
    # repartition des fournées
    temp <- data.frame("grammes" = 1:Poids_pate)
    temp$four                                   <- "Four1"
    temp$four[temp$grammes>input$taille_four]   <- "Four2"
    temp$four[temp$grammes>2*input$taille_four] <- "Four3"
    temp$four[temp$grammes>3*input$taille_four] <- "Four4"
    temp$four[temp$grammes>4*input$taille_four] <- "Four5"
    temp$four[temp$grammes>5*input$taille_four] <- "Four6"
    temp$four[temp$grammes>6*input$taille_four] <- "Four7"
    temp$four[temp$grammes>7*input$taille_four] <- "Four8"
    temp$four[temp$grammes>8*input$taille_four] <- "Four9"
    temp$four[temp$grammes>9*input$taille_four] <- "Four10"
    
    rep_four <- temp %>% group_by(four) %>% count() %>% rename("g_pate" = n) %>%
      mutate(g_pate = if_else(g_pate == 2, 0, g_pate))
    
    rep_four %>% mutate(N_500 = round(g_pate/500,0),
                        g_farine = round(g_pate*Txf,0),
                        g_eau = round(g_pate*Txe,0),
                        g_levain = round(g_pate*Txl,0),
                        g_sel = round(g_pate*Txs,0)) %>%
      mutate(remp = g_pate/input$taille_four*100) %>%
      mutate(g_pate = label_number(big.mark = " ", suffix = "g")(g_pate),
             N_500 = label_number(big.mark = " ")(N_500),
             g_farine = label_number(big.mark = " ", suffix = "g")(g_farine),
             g_eau = label_number(big.mark = " ", suffix = "g")(g_eau),
             g_levain = label_number(big.mark = " ", suffix = "g")(g_levain),
             g_sel = label_number(big.mark = " ", suffix = "g")(g_sel),
             remp = label_number(big.mark = " ", suffix = " %")(remp)) %>%
      rename("Quantité de pâte :" = g_pate,
             "Pains de 500g :" = N_500,
             "Farine de petit-épeautre:" = g_farine,
             "Eau :" = g_eau,
             "Levain :" = g_levain,
             "Sel :" = g_sel,
             "% de remplissage :" = remp) %>%
      pivot_longer(2:8) %>%
      pivot_wider(names_from = four, values_from = value) %>%
      rename(" " = "name") %>%
      gt(rowname_col = " ") %>%
      tab_header(title = md("**Petit-épeautre**")) %>% 
      tab_style(style = cell_text(weight = "bold"), locations = cells_stub()) %>% 
      tab_style(style = cell_text(weight = "bold"), locations = cells_column_labels())
  } 
  output$fourPE <- render_gt({
    validate(need(input$PE500 > 0 , ""))
    four_PE()})  
  
   ## PRATIQUE 2 ----
  ## Repartir de la commande dans les fours ----

 rep <- reactive ({
   
   validate(need(input$SC750 + input$SC500 + input$G500 + 
                 input$SP300 + input$SP500 + input$C750 + input$C500 + input$PE500 != 0,
                 "Il faut rentrer une commande ..."))
   
    # Conversion des quantités
   SC750 <- round(input$SC750 * input$Evap + input$SC750,0)
   SC500 <- round(input$SC500 * input$Evap + input$SC500,0)
   G500  <- round(input$G500  * input$Evap + input$G500, 0)
   SP300 <- round(input$SP300 * input$Evap + input$SP300,0)
   SP500 <- round(input$SP500 * input$Evap + input$SP500,0)
   C750  <- round(input$C750  * input$Evap + input$C750, 0)
   C500  <- round(input$C500  * input$Evap + input$C500, 0)
   PE500 <- round(input$PE500 * input$Evap + input$PE500,0)
   
   Ajust <- input$Ajust
   
   occ300 <- 1/input$occ300
   occ500 <- 1/input$occ500
   occ750 <- 1/input$occ750
   occMou <- 1/input$occMou
    
    # Premier tour : on remplit des fours avec un seul type de recette si possible  
    df_SC <- bind_rows(dfSP300 <- tibble(.rows = SP300, "type1" = "SP300", "type2" = "SC", "occ" = occ300, "n" = SP300),
                       dfSP500 <- tibble(.rows = SP500, "type1" = "SP500", "type2" = "SC", "occ" = occ500, "n" = SP500),
                       dfSC500 <- tibble(.rows = SC500, "type1" = "SC500", "type2" = "SC", "occ" = occ500, "n" = SC500),
                       dfSC750 <- tibble(.rows = SC750, "type1" = "SC750", "type2" = "SC", "occ" = occ750, "n" = SC750)) %>%
      mutate(occup = cumsum(occ)+Ajust,
             occup_tot = sum(occ)) %>%
      mutate(four = case_when(occup_tot > 1 & occup < 1 ~ paste0("four", type2),
                              occup_tot > 2 & occup < 2 ~ paste0("four", type2, "2"),
                              occup_tot > 3 & occup < 3 ~ paste0("four", type2, "3"),
                              occup_tot > 4 & occup < 4 ~ paste0("four", type2, "4"),
                              occup_tot > 5 & occup < 5 ~ paste0("four", type2, "5")))
          
    four_SC <- df_SC %>% filter(!is.na(four)) %>% select("type1", "type2", "four") %>%
      group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
    
    nofour_SC <- df_SC %>% 
      filter(is.na(four)) %>% 
      mutate(occup_tot = sum(occ),
             occup = cumsum(occ)+Ajust) 
    
    df_G <- bind_rows(dfG500 <- tibble(.rows = G500, "type1" = "G500", "type2" = "G", "occ" = occ500, "n" = G500)) %>%
       mutate(occup = cumsum(occ)+Ajust,
              occup_tot = sum(occ)) %>%
       mutate(four = case_when(occup_tot > 1 & occup < 1 ~ paste0("four", type2),
                               occup_tot > 2 & occup < 2 ~ paste0("four", type2, "2"),
                               occup_tot > 3 & occup < 3 ~ paste0("four", type2, "3"),
                               occup_tot > 4 & occup < 4 ~ paste0("four", type2, "4"),
                               occup_tot > 5 & occup < 5 ~ paste0("four", type2, "5")))
    
    four_G <- df_G %>% filter(!is.na(four)) %>% select("type1", "type2", "four") %>%
       group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
    
    nofour_G <- df_G %>% 
       filter(is.na(four)) %>% 
       mutate(occup_tot = sum(occ),
              occup = cumsum(occ)+Ajust) 
    
    df_C <- bind_rows(dfC500 <- tibble(.rows = C500,  "type1" = "C500" , "type2" = "C",  "occ" = occ500, "n" = C500 ),
                      dfC750 <- tibble(.rows = C750,  "type1" = "C750" , "type2" = "C",  "occ" = occ750, "n" = C750 ))%>%
      mutate(occup = cumsum(occ)+Ajust,
             occup_tot = sum(occ)) %>%
      mutate(four = case_when(occup_tot > 1 & occup < 1 ~ paste0("four", type2),
                              occup_tot > 2 & occup < 2 ~ paste0("four", type2, "2"),
                              occup_tot > 3 & occup < 3 ~ paste0("four", type2, "3"),
                              occup_tot > 4 & occup < 4 ~ paste0("four", type2, "4"),
                              occup_tot > 5 & occup < 5 ~ paste0("four", type2, "5")))
    
    four_C <- df_C %>% filter(!is.na(four)) %>% select("type1", "type2", "four") %>%
      group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
    
    nofour_C <- df_C %>% 
      filter(is.na(four)) %>% 
      mutate(occup_tot = sum(occ),
             occup = cumsum(occ)+Ajust)   
    
    df_PE <- tibble(.rows = PE500, "type1" = "PE500", "type2" = "PE", "occ" = occMou, "n" = PE500)%>%
      mutate(occup = cumsum(occ)+Ajust,
             occup_tot = sum(occ)) %>%
      mutate(four = case_when(occup_tot > 1 & occup < 1 ~ paste0("four", type2),
                              occup_tot > 2 & occup < 2 ~ paste0("four", type2, "2"),
                              occup_tot > 3 & occup < 3 ~ paste0("four", type2, "3"),
                              occup_tot > 4 & occup < 4 ~ paste0("four", type2, "4"),
                              occup_tot > 5 & occup < 5 ~ paste0("four", type2, "5")))
    
    four_PE <- df_PE %>% filter(!is.na(four)) %>% select("type1", "type2", "four") %>%
      group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
    
    nofour_PE <- df_PE %>% 
      filter(is.na(four)) %>% 
      mutate(occup_tot = sum(occ),
             occup = cumsum(occ)+Ajust)   
    
    # On récupère des premières fournées remplies à 100% par une seule recette à chaque fois :
    
    four_t1 <- bind_rows(four_SC, four_G, four_C, four_PE)
    
    # et des pains à répartir :
    
    AR <- bind_rows(nofour_SC, nofour_G, nofour_PE, nofour_C) %>%
      mutate(occup = cumsum(occ)+Ajust) %>%
      mutate(four = case_when(occup < 1 ~ "four_1" ,
                              occup < 2 ~ "four_2" ,
                              occup < 3 ~ "four_3" ,
                              occup < 4 ~ "four_4" ,
                              occup < 5 ~ "four_5" ,
                              occup < 6 ~ "four_6" ,
                              occup < 7 ~ "four_7" ,
                              occup < 8 ~ "four_8" ,
                              .default = "four_9")) %>%
      group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
    
    # On combine les fours :
    
    if (nrow(four_t1) != 0) {
      four <- AR %>% full_join(four_t1)
    } else {
      four <- AR }
 
    four_F <- four %>% 
      ungroup() %>% 
      pivot_longer(3:ncol(four)) %>% 
      select(!type2) %>%
      pivot_wider(names_from = type1, values_from = value) %>%
      mutate(TR = ((if_else(is.na(C500), 0, C500*occ500) + 
                    if_else(is.na(C750), 0, C750*occ750) +   
                    if_else(is.na(SC500),0, SC500*occ500) +
                    if_else(is.na(SP300),0, SP300*occ300) +
                    if_else(is.na(SP500),0, SP500*occ500) +
                    if_else(is.na(SC750),0, SC750*occ750) +
                    if_else(is.na(G500), 0, G500*occ500) +
                    if_else(is.na(PE500),0, PE500*occMou))*100)) %>%
      arrange(name) %>%
      pivot_longer(cols = c(-1), names_to = "Type") %>%
      pivot_wider(names_from = "name")
    
    four_F$Type <- four_F$Type %>%
      fct_recode(
        "Pain complet - 500g" = "C500",
        "Pain complet - 750g" = "C750",
        "Pain Petit épeautre - 500g" = "PE500",
        "Pain semi-complet - 500g" = "SC500",
        "Pain semi-complet - 750g" = "SC750",
        "Pain spécial - 300g" = "SP300",
        "Pain spécial - 500g" = "SP500",
        "Pain aux graines - 500g" = "G500",
        "Taux de remplissage (%)" = "TR")
    names(four_F) <- c("Type", paste0("Four ", 1:nrow(four_F)) )
    
    # jolie sortie
    
    four_F %>% 
      gt() %>% 
      fmt_number(columns = 2:ncol(four_F),
                 decimals = 0) %>%
      sub_missing(missing_text = "-") %>% 
      tab_style(style = cell_text(weight = "bold"), locations = cells_column_labels()) %>%
      tab_style(style = cell_text(weight = "bold"), locations = cells_body(rows = Type == "Taux de remplissage (%)"))
    
}) 

 output$table <- render_gt({rep()}) 
  
  ## Faire des fiches recettes pour chaque fours ----

 RECETTES <- eventReactive(input$go, {
   # Conversion des quantités ----
   SC750 <- round(input$SC750 * input$Evap + input$SC750,0)
   SC500 <- round(input$SC500 * input$Evap + input$SC500,0)
   G500  <- round(input$G500  * input$Evap + input$G500, 0)
   SP300 <- round(input$SP300 * input$Evap + input$SP300,0)
   SP500 <- round(input$SP500 * input$Evap + input$SP500,0)
   C750  <- round(input$C750  * input$Evap + input$C750, 0)
   C500  <- round(input$C500  * input$Evap + input$C500, 0)
   PE500 <- round(input$PE500 * input$Evap + input$PE500,0)
   
   Ajust <- input$Ajust
   
   occ300 <- 1/input$occ300
   occ500 <- 1/input$occ500
   occ750 <- 1/input$occ750
   occMou <- 1/input$occMou

   Tx_f_SC <- 1 / (1 + input$Tx_hydrat_SC + (1 + input$Tx_hydrat_SC) * input$Tx_levain_SC + input$Tx_sel_SC)
   Tx_e_SC <- Tx_f_SC * input$Tx_hydrat_SC
   Tx_l_SC <- (Tx_f_SC + Tx_e_SC)*input$Tx_levain_SC
   Tx_s_SC <- Tx_f_SC * input$Tx_sel_SC

   Tx_f_SP <- 1 / ((1+ input$Tx_spe_SP)*(1 + input$Tx_hydrat_SC + (1 + input$Tx_hydrat_SC) * input$Tx_levain_SC + input$Tx_sel_SC))
   Tx_e_SP <- Tx_f_SP * input$Tx_hydrat_SC
   Tx_l_SP <- (Tx_f_SP + Tx_e_SP)*input$Tx_levain_SC
   Tx_s_SP <- Tx_f_SP * input$Tx_sel_SC
   Tx_i_SP <- (Tx_f_SP + Tx_e_SP + Tx_l_SP + Tx_s_SP) * input$Tx_spe_SP
   
   Tx_f_G <- 1 / ((1+ input$Tx_grain)*(1 + input$Tx_hydrat_SC + (1 + input$Tx_hydrat_SC) * input$Tx_levain_SC + input$Tx_sel_SC))
   Tx_e_G <- Tx_f_G * input$Tx_hydrat_SC
   Tx_l_G <- (Tx_f_G + Tx_e_G)*input$Tx_levain_SC
   Tx_s_G <- Tx_f_G * input$Tx_sel_SC
   Tx_i_G <- (Tx_f_G + Tx_e_G + Tx_l_G + Tx_s_G) * input$Tx_grain
   
   Tx_f_C <- 1 / (1 + input$Tx_hydrat_C + (1 + input$Tx_hydrat_C) * input$Tx_levain_C + input$Tx_sel_C)
   Tx_e_C <- Tx_f_C * input$Tx_hydrat_C
   Tx_l_C <- (Tx_f_C + Tx_e_C)*input$Tx_levain_C
   Tx_s_C <- Tx_f_C * input$Tx_sel_C
   
   Tx_f_PE <- 1 / (1 + input$Tx_hydrat_PE + (1 + input$Tx_hydrat_PE) * input$Tx_levain_PE + input$Tx_sel_PE)
   Tx_e_PE <- Tx_f_PE * input$Tx_hydrat_PE
   Tx_l_PE <- (Tx_f_PE + Tx_e_PE)*input$Tx_levain_PE
   Tx_s_PE <- Tx_f_PE * input$Tx_sel_PE
     
   # Premier tour : on remplit des fours avec un seul type de recette si possible  
   df_SC <- bind_rows(dfSP300 <- tibble(.rows = SP300, "type1" = "SP300", "type2" = "SC", "occ" = occ300, "n" = SP300),
                      dfSP500 <- tibble(.rows = SP500, "type1" = "SP500", "type2" = "SC", "occ" = occ500, "n" = SP500),
                      dfSC500 <- tibble(.rows = SC500, "type1" = "SC500", "type2" = "SC", "occ" = occ500, "n" = SC500),
                      dfSC750 <- tibble(.rows = SC750, "type1" = "SC750", "type2" = "SC", "occ" = occ750, "n" = SC750)) %>%
      mutate(occup = cumsum(occ)+Ajust,
             occup_tot = sum(occ)) %>%
      mutate(four = case_when(occup_tot > 1 & occup < 1 ~ paste0("four", type2),
                              occup_tot > 2 & occup < 2 ~ paste0("four", type2, "2"),
                              occup_tot > 3 & occup < 3 ~ paste0("four", type2, "3"),
                              occup_tot > 4 & occup < 4 ~ paste0("four", type2, "4"),
                              occup_tot > 5 & occup < 5 ~ paste0("four", type2, "5")))
   
   four_SC <- df_SC %>% filter(!is.na(four)) %>% select("type1", "type2", "four") %>%
      group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
   
   nofour_SC <- df_SC %>% 
      filter(is.na(four)) %>% 
      mutate(occup_tot = sum(occ),
             occup = cumsum(occ)+Ajust) 
   
   df_G <- bind_rows(dfG500 <- tibble(.rows = G500, "type1" = "G500", "type2" = "G", "occ" = occ500, "n" = G500)) %>%
      mutate(occup = cumsum(occ)+Ajust,
             occup_tot = sum(occ)) %>%
      mutate(four = case_when(occup_tot > 1 & occup < 1 ~ paste0("four", type2),
                              occup_tot > 2 & occup < 2 ~ paste0("four", type2, "2"),
                              occup_tot > 3 & occup < 3 ~ paste0("four", type2, "3"),
                              occup_tot > 4 & occup < 4 ~ paste0("four", type2, "4"),
                              occup_tot > 5 & occup < 5 ~ paste0("four", type2, "5")))
   
   four_G <- df_G %>% filter(!is.na(four)) %>% select("type1", "type2", "four") %>%
      group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
   
   nofour_G <- df_G %>% 
      filter(is.na(four)) %>% 
      mutate(occup_tot = sum(occ),
             occup = cumsum(occ)+Ajust) 
   
   df_C <- bind_rows(dfC500 <- tibble(.rows = C500,  "type1" = "C500" , "type2" = "C",  "occ" = occ500, "n" = C500 ),
                     dfC750 <- tibble(.rows = C750,  "type1" = "C750" , "type2" = "C",  "occ" = occ750, "n" = C750 ))%>%
      mutate(occup = cumsum(occ)+Ajust,
             occup_tot = sum(occ)) %>%
      mutate(four = case_when(occup_tot > 1 & occup < 1 ~ paste0("four", type2),
                              occup_tot > 2 & occup < 2 ~ paste0("four", type2, "2"),
                              occup_tot > 3 & occup < 3 ~ paste0("four", type2, "3"),
                              occup_tot > 4 & occup < 4 ~ paste0("four", type2, "4"),
                              occup_tot > 5 & occup < 5 ~ paste0("four", type2, "5")))
   
   four_C <- df_C %>% filter(!is.na(four)) %>% select("type1", "type2", "four") %>%
      group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
   
   nofour_C <- df_C %>% 
      filter(is.na(four)) %>% 
      mutate(occup_tot = sum(occ),
             occup = cumsum(occ)+Ajust)   
   
   df_PE <- tibble(.rows = PE500, "type1" = "PE500", "type2" = "PE", "occ" = occMou, "n" = PE500)%>%
      mutate(occup = cumsum(occ)+Ajust,
             occup_tot = sum(occ)) %>%
      mutate(four = case_when(occup_tot > 1 & occup < 1 ~ paste0("four", type2),
                              occup_tot > 2 & occup < 2 ~ paste0("four", type2, "2"),
                              occup_tot > 3 & occup < 3 ~ paste0("four", type2, "3"),
                              occup_tot > 4 & occup < 4 ~ paste0("four", type2, "4"),
                              occup_tot > 5 & occup < 5 ~ paste0("four", type2, "5")))
   
   four_PE <- df_PE %>% filter(!is.na(four)) %>% select("type1", "type2", "four") %>%
      group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
   
   nofour_PE <- df_PE %>% 
      filter(is.na(four)) %>% 
      mutate(occup_tot = sum(occ),
             occup = cumsum(occ)+Ajust)   
   
   # On récupère des premières fournées remplies à 100% par une seule recette à chaque fois :
   
   four_t1 <- bind_rows(four_SC, four_G, four_C, four_PE)
   
   # et des pains à répartir :
   
   AR <- bind_rows(nofour_SC, nofour_G, nofour_PE, nofour_C) %>%
      mutate(occup = cumsum(occ)+Ajust) %>%
      mutate(four = case_when(occup < 1 ~ "four_1" ,
                              occup < 2 ~ "four_2" ,
                              occup < 3 ~ "four_3" ,
                              occup < 4 ~ "four_4" ,
                              occup < 5 ~ "four_5" ,
                              occup < 6 ~ "four_6" ,
                              occup < 7 ~ "four_7" ,
                              occup < 8 ~ "four_8" ,
                              .default = "four_9")) %>%
      group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
   
   # On combine les fours :
   
   if (nrow(four_t1) != 0) {
      four <- AR %>% full_join(four_t1)
   } else {
      four <- AR }
     
   # On attribue à chaque four la quantité de pâte de chaque type et recette ----
   
   fr <- four %>%
     pivot_longer(3:ncol(.), names_to = "four", values_to = "n") %>%
     group_by(four, type1) %>% summarise(n = sum(n)) %>% ungroup() %>%
     pivot_wider(names_from = type1, values_from = n) %>%  
     mutate(C500 = case_when(is.na(C500)~0, .default = C500),
            C750 = case_when(is.na(C750)~0, .default = C750),
            PE500 = case_when(is.na(PE500)~0, .default = PE500),
            SC500 = case_when(is.na(SC500)~0, .default = SC500),
            SC750 = case_when(is.na(SC750)~0, .default = SC750),
            SP300 = case_when(is.na(SP300)~0, .default = SP300),
            SP500 = case_when(is.na(SP500)~0, .default = SP500),
            G500 = case_when(is.na(G500)~0, .default = G500),
            q_pate_SC = SC750*750 + SC500*500,
            q_pate_SP = SP300*300 + SP500*500,
            q_pate_G  = G500*500,
            q_pate_C  = C500*500  + C750*750,
            q_pate_PE = PE500*(500 + (500*0.02))) %>%
     mutate("Pâte pains semi-complets :"     = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_SC + q_pate_SP - (q_pate_SP * Tx_i_SP)),
            "(dont pâte pains speciaux :)"   = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_SP - (q_pate_SP * Tx_i_SP)),
            "Pâte pains aux graines :"       = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_G),
            "Pâte pains complets :"          = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_C),
            "Pâte pains petit-épeautre :"    = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_PE),
            "SC- farine Semi-Complète :"     = label_number(accuracy = 1, big.mark = " ", suffix = " g") ((q_pate_SC + q_pate_SP - (q_pate_SP * Tx_i_SP)) * Tx_f_SC),
            "SC- eau :"                      = label_number(accuracy = 1, big.mark = " ", suffix = " g") ((q_pate_SC + q_pate_SP - (q_pate_SP * Tx_i_SP)) * Tx_e_SC),
            "SC- levain :"                   = label_number(accuracy = 1, big.mark = " ", suffix = " g") ((q_pate_SC + q_pate_SP - (q_pate_SP * Tx_i_SP)) * Tx_l_SC),
            "SC- sel :"                      = label_number(accuracy = 1, big.mark = " ", suffix = " g") ((q_pate_SC + q_pate_SP - (q_pate_SP * Tx_i_SP)) * Tx_s_SC),
            "SP- ingrédient spécial :"       = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_SP * Tx_i_SP),
            "PG- farine Semi-Complète :"     = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_G * Tx_f_G),
            "PG- eau :"                      = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_G * Tx_e_G),
            "PG- levain :"                   = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_G * Tx_l_G),
            "PG- sel :"                      = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_G * Tx_s_G),
            "PG- graines :"                  = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_G * Tx_i_G),
            "PC- farine Complète :"          = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_C * Tx_f_C),
            "PC- eau :"                      = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_C * Tx_e_C),
            "PC- levain :"                   = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_C * Tx_l_C),
            "PC- sel :"                      = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_C * Tx_s_C),
            "PE- farine de petit-épeautre :" = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_PE * Tx_f_PE),
            "PE- eau :"                      = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_PE * Tx_e_PE),
            "PE- levain :"                   = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_PE * Tx_l_PE),
            "PE- sel :"                      = label_number(accuracy = 1, big.mark = " ", suffix = " g") (q_pate_PE * Tx_s_PE)) %>% ungroup()
   

   liste <- c("Pâte pains semi-complets :", 
              "(dont pâte pains speciaux :)", 
              "Pâte pains aux graines :",
              "Pâte pains complets :", 
              "Pâte pains petit-épeautre :", 
              "SC- farine Semi-Complète :", 
              "SC- eau :", 
              "SC- levain :", 
              "SC- sel :", 
              "SP- ingrédient spécial :", 
              "PG- farine Semi-Complète :",
              "PG- eau :", 
              "PG- levain :",
              "PG- sel :",
              "PG- graines :",
              "PC- farine Complète :",  
              "PC- eau :", 
              "PC- levain :",
              "PC- sel :", 
              "PE- farine de petit-épeautre :", 
              "PE- eau :", 
              "PE- levain :", 
              "PE- sel :")
   
   seq <- 1:nrow(fr)
   
   RecetteParFour <- function(i) {  
     fr %>% slice(i) %>% select(all_of(liste)) %>% pivot_longer(1:ncol(.)) %>% filter(value != "0 g") %>%
       gt() %>%
       tab_header(title = paste0("Fournée ", i )) %>%
       cols_label(name = "", value = "") %>%
       tab_row_group(md("**Recette pain de petit-épeautre**"), rows = str_detect(name, pattern = "PE")) %>%
       tab_row_group(md("**Recette pain complet**"), rows = str_detect(name, pattern = "PC")) %>%
       tab_row_group(md("**Recette pain aux graines**"), rows = str_detect(name, pattern = "PG")) %>%
       tab_row_group(md("*Pour les pains spéciaux, on ajoute :*"), rows = str_detect(name, pattern = "SP")) %>%
       tab_row_group(md("**Recette pain semi-complet**"), rows = str_detect(name, pattern = "SC")) %>%
       tab_row_group(md("**Résumé**"), rows = str_detect(name, pattern = "Pâte") | str_detect(name, pattern = "dont"))
   }
   # On décompose la quantité de pâte en recettes ----  
   map(seq, RecetteParFour)
 })
 
 output$four1 <- render_gt({
   validate(need(length(RECETTES()) > 0, ""))
   RECETTES()[[1]]}) 
 
 output$four2 <- render_gt({
    validate(need(length(RECETTES()) > 1, ""))
    RECETTES()[[2]]})
 
 output$four3 <- render_gt({
   validate(need(length(RECETTES()) > 2, ""))
   RECETTES()[[3]]})
 
 output$four4 <- render_gt({
   validate(need(length(RECETTES()) > 3, ""))
   RECETTES()[[4]]})

 output$four5 <- render_gt({
   validate(need(length(RECETTES()) > 4, ""))
   RECETTES()[[5]]})
 
 tib <- function(x) {as.data.frame(RECETTES()[[x]])}
 
 rec <- function() {map(seq(RECETTES()), tib)}
 
 output$dl <- downloadHandler(filename = function() {paste0("Fournees_",Sys.Date()+1,".xlsx" )}, 
                              content = function(file) {
                                my_workbook <- createWorkbook()

                                addWorksheet(wb = my_workbook, sheetName = "Fournée 1")
                                addWorksheet(wb = my_workbook, sheetName = "Fournée 2")
                                addWorksheet(wb = my_workbook, sheetName = "Fournée 3")
                                addWorksheet(wb = my_workbook, sheetName = "Fournée 4")
                                  
                                setColWidths(my_workbook, sheet = 1, cols = 1:2, widths = c(30, 10))
                                writeData(my_workbook, sheet = 1, "Détails et recettes de la première fournée", startRow = 1, startCol = 1)
                                addStyle(my_workbook, sheet = 1, style = createStyle(fontSize = 24, textDecoration = "bold"), rows = 1, cols = 1)
                                writeData(my_workbook, sheet = 1, rec()[[1]] %>% select(type = name, quantité = value), startRow = 4, startCol = 1)
                                addStyle(my_workbook, sheet = 1, style = createStyle(fgFill = "#1a5bc4", halign = "center", fontColour = "#ffffff"), rows = 4, cols = 1:2, gridExpand = TRUE)
                                addStyle(my_workbook, sheet = 1, style = createStyle(numFmt = "comma"), rows = 5:10, cols = 1:2, gridExpand = TRUE)

                                setColWidths(my_workbook, sheet = 2, cols = 1:2, widths = c(30, 10))
                                writeData(my_workbook, sheet = 2, "Détails et recettes de la 2ème fournée", startRow = 1, startCol = 1)
                                addStyle(my_workbook, sheet = 2, style = createStyle(fontSize = 24, textDecoration = "bold"), rows = 1, cols = 1)
                                writeData(my_workbook, sheet = 2, if (length(rec())>1) {rec()[[2]] %>% select(type = name, quantité = value)} else {"---"}, startRow = 4, startCol = 1)
                                addStyle(my_workbook, sheet = 2, style = createStyle(fgFill = "#1a5bc4", halign = "center", fontColour = "#ffffff"), rows = 4, cols = 1:2, gridExpand = TRUE)
                                addStyle(my_workbook, sheet = 2, style = createStyle(numFmt = "comma"), rows = 5:10, cols = 1:2, gridExpand = TRUE)
                                
                                setColWidths(my_workbook, sheet = 3, cols = 1:2, widths = c(30, 10))
                                writeData(my_workbook, sheet = 3, "Détails et recettes de la 3ème fournée", startRow = 1, startCol = 1)
                                addStyle(my_workbook, sheet = 3, style = createStyle(fontSize = 24, textDecoration = "bold"), rows = 1, cols = 1)
                                writeData(my_workbook, sheet = 3, if (length(rec())>2) {rec()[[3]] %>% select(type = name, quantité = value)} else {"---"}, startRow = 4, startCol = 1)
                                addStyle(my_workbook, sheet = 3, style = createStyle(fgFill = "#1a5bc4", halign = "center", fontColour = "#ffffff"), rows = 4, cols = 1:2, gridExpand = TRUE)
                                addStyle(my_workbook, sheet =3, style = createStyle(numFmt = "comma"), rows = 5:10, cols = 1:2, gridExpand = TRUE)
                                
                                setColWidths(my_workbook, sheet = 4, cols = 1:2, widths = c(30, 10))
                                writeData(my_workbook, sheet = 4, "Détails et recettes de la 4ème fournée", startRow = 1, startCol = 1)
                                addStyle(my_workbook, sheet = 4, style = createStyle(fontSize = 24, textDecoration = "bold"), rows = 1, cols = 1)
                                writeData(my_workbook, sheet = 4, if (length(rec())>3) {rec()[[4]] %>% select(type = name, quantité = value)} else {"---"}, startRow = 4, startCol = 1)
                                addStyle(my_workbook, sheet = 4, style = createStyle(fgFill = "#1a5bc4", halign = "center", fontColour = "#ffffff"), rows = 4, cols = 1:2, gridExpand = TRUE)
                                addStyle(my_workbook, sheet = 4, style = createStyle(numFmt = "comma"), rows = 5:10, cols = 1:2, gridExpand = TRUE)
                                
                                saveWorkbook(my_workbook, file)
                              })
 
  ## EMPLOI DU TEMPS ----
 
 observeEvent(input$screen, {screenshot(id = "timeline",
                                         filename = paste0("Emp du temps ",Sys.Date()+1))})
 
 ## construction de la bases des évenements ----
 
 even <- reactive ({
   
   validate(need(input$SC750 + input$SC500 + input$G500 + 
                   input$SP300 + input$SP500 + input$C750 + input$C500 + input$PE500 != 0,
                 "Il faut rentrer une commande ..."))
   
   # Conversion des quantités
   SC750 <- round(input$SC750 * input$Evap + input$SC750,0)
   SC500 <- round(input$SC500 * input$Evap + input$SC500,0)
   G500  <- round(input$G500  * input$Evap + input$G500, 0)
   SP300 <- round(input$SP300 * input$Evap + input$SP300,0)
   SP500 <- round(input$SP500 * input$Evap + input$SP500,0)
   C750  <- round(input$C750  * input$Evap + input$C750, 0)
   C500  <- round(input$C500  * input$Evap + input$C500, 0)
   PE500 <- round(input$PE500 * input$Evap + input$PE500,0)
   
   Ajust <- input$Ajust
   
   occ300 <- 1/input$occ300
   occ500 <- 1/input$occ500
   occ750 <- 1/input$occ750
   occMou <- 1/input$occMou
   
   # Premier tour : on remplit des fours avec un seul type de recette si possible  
   df_SC <- bind_rows(dfSP300 <- tibble(.rows = SP300, "type1" = "SP300", "type2" = "SC", "occ" = occ300, "n" = SP300),
                      dfSP500 <- tibble(.rows = SP500, "type1" = "SP500", "type2" = "SC", "occ" = occ500, "n" = SP500),
                      dfSC500 <- tibble(.rows = SC500, "type1" = "SC500", "type2" = "SC", "occ" = occ500, "n" = SC500),
                      dfSC750 <- tibble(.rows = SC750, "type1" = "SC750", "type2" = "SC", "occ" = occ750, "n" = SC750)) %>%
     mutate(occup = cumsum(occ)+Ajust,
            occup_tot = sum(occ)) %>%
     mutate(four = case_when(occup_tot > 1 & occup < 1 ~ paste0("four", type2),
                             occup_tot > 2 & occup < 2 ~ paste0("four", type2, "2"),
                             occup_tot > 3 & occup < 3 ~ paste0("four", type2, "3"),
                             occup_tot > 4 & occup < 4 ~ paste0("four", type2, "4"),
                             occup_tot > 5 & occup < 5 ~ paste0("four", type2, "5")))
   
   four_SC <- df_SC %>% filter(!is.na(four)) %>% select("type1", "type2", "four") %>%
     group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
   
   nofour_SC <- df_SC %>% 
     filter(is.na(four)) %>% 
     mutate(occup_tot = sum(occ),
            occup = cumsum(occ)+Ajust) 
   
   df_G <- bind_rows(dfG500 <- tibble(.rows = G500, "type1" = "G500", "type2" = "G", "occ" = occ500, "n" = G500)) %>%
     mutate(occup = cumsum(occ)+Ajust,
            occup_tot = sum(occ)) %>%
     mutate(four = case_when(occup_tot > 1 & occup < 1 ~ paste0("four", type2),
                             occup_tot > 2 & occup < 2 ~ paste0("four", type2, "2"),
                             occup_tot > 3 & occup < 3 ~ paste0("four", type2, "3"),
                             occup_tot > 4 & occup < 4 ~ paste0("four", type2, "4"),
                             occup_tot > 5 & occup < 5 ~ paste0("four", type2, "5")))
   
   four_G <- df_G %>% filter(!is.na(four)) %>% select("type1", "type2", "four") %>%
     group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
   
   nofour_G <- df_G %>% 
     filter(is.na(four)) %>% 
     mutate(occup_tot = sum(occ),
            occup = cumsum(occ)+Ajust) 
   
   df_C <- bind_rows(dfC500 <- tibble(.rows = C500,  "type1" = "C500" , "type2" = "C",  "occ" = occ500, "n" = C500 ),
                     dfC750 <- tibble(.rows = C750,  "type1" = "C750" , "type2" = "C",  "occ" = occ750, "n" = C750 ))%>%
     mutate(occup = cumsum(occ)+Ajust,
            occup_tot = sum(occ)) %>%
     mutate(four = case_when(occup_tot > 1 & occup < 1 ~ paste0("four", type2),
                             occup_tot > 2 & occup < 2 ~ paste0("four", type2, "2"),
                             occup_tot > 3 & occup < 3 ~ paste0("four", type2, "3"),
                             occup_tot > 4 & occup < 4 ~ paste0("four", type2, "4"),
                             occup_tot > 5 & occup < 5 ~ paste0("four", type2, "5")))
   
   four_C <- df_C %>% filter(!is.na(four)) %>% select("type1", "type2", "four") %>%
     group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
   
   nofour_C <- df_C %>% 
     filter(is.na(four)) %>% 
     mutate(occup_tot = sum(occ),
            occup = cumsum(occ)+Ajust)   
   
   df_PE <- tibble(.rows = PE500, "type1" = "PE500", "type2" = "PE", "occ" = occMou, "n" = PE500)%>%
     mutate(occup = cumsum(occ)+Ajust,
            occup_tot = sum(occ)) %>%
     mutate(four = case_when(occup_tot > 1 & occup < 1 ~ paste0("four", type2),
                             occup_tot > 2 & occup < 2 ~ paste0("four", type2, "2"),
                             occup_tot > 3 & occup < 3 ~ paste0("four", type2, "3"),
                             occup_tot > 4 & occup < 4 ~ paste0("four", type2, "4"),
                             occup_tot > 5 & occup < 5 ~ paste0("four", type2, "5")))
   
   four_PE <- df_PE %>% filter(!is.na(four)) %>% select("type1", "type2", "four") %>%
     group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
   
   nofour_PE <- df_PE %>% 
     filter(is.na(four)) %>% 
     mutate(occup_tot = sum(occ),
            occup = cumsum(occ)+Ajust)   
   
   # On récupère des premières fournées remplies à 100% par une seule recette à chaque fois :
   
   four_t1 <- bind_rows(four_SC, four_G, four_C, four_PE)
   
   # et des pains à répartir :
   
   AR <- bind_rows(nofour_SC, nofour_G, nofour_PE, nofour_C) %>%
     mutate(occup = cumsum(occ)+Ajust) %>%
     mutate(four = case_when(occup < 1 ~ "four_1" ,
                             occup < 2 ~ "four_2" ,
                             occup < 3 ~ "four_3" ,
                             occup < 4 ~ "four_4" ,
                             occup < 5 ~ "four_5" ,
                             occup < 6 ~ "four_6" ,
                             occup < 7 ~ "four_7" ,
                             occup < 8 ~ "four_8" ,
                             .default = "four_9")) %>%
     group_by(type2, type1, four) %>% count() %>% pivot_wider(names_from = four, values_from = n)
   
   # On combine les fours :
   
   if (nrow(four_t1) != 0) {
     four <- AR %>% full_join(four_t1)
   } else {
     four <- AR }
   
   demain <- Sys.Date()+1
   h_deb_j <- paste0(input$heure_deb,":00")
   
   n_four <- four %>% ungroup %>% select(starts_with("four")) %>% ncol()
   
   ## Construction des chronologies pour les fours
   ### Four 1 ----
   
   f1 <- tibble(.rows = 1) %>% 
     mutate(mel_s = as.POSIXct(paste0(demain," ", h_deb_j))+ 15 * 60,
            R1_s  = as.POSIXct(mel_s + input$mel_r1 * 60),
            R2_s  = as.POSIXct(R1_s  + input$r1_r2 * 60),
            Fac_s = as.POSIXct(R2_s  + input$r2_fac * 60),
            Enf_s = as.POSIXct(Fac_s + input$fac_enf * 60),
            All_s = as.POSIXct(Enf_s - input$chau * 60),
            Def_s = as.POSIXct(Enf_s + input$cui * 60),
            Res_s = as.POSIXct(Def_s + input$ress * 60)) %>%
     pivot_longer(cols = 1:8, names_to = "content", values_to = "heures") %>%
     mutate(startend = if_else(str_detect(content, "_s"), "start", "end"),
            content  = str_remove(content, "_s"),
            content  = str_remove(content, "_e")) %>%
     pivot_wider(names_from = startend, values_from = heures) %>%
     mutate(id = 1:8, four = "Four 1") %>%  relocate(id, four)
   
   f1$content <- fct_recode(f1$content, "Mélange" = "mel", "Rabat 1" = "R1", "Rabat 2" = "R2", 
                            "Façonnage" = "Fac", "Enfournement" = "Enf", "Allumage du four" = "All", 
                            "Défournement" = "Def", "Ressuage" = "Res")
   f1      
   
   ### Four 2 ----
   
   f2 <- tibble(.rows = 1) %>% 
     mutate(mel_s = f1$start[f1$content=="Façonnage"] + 15 * 60,
            R1_s  = as.POSIXct(mel_s + input$mel_r1 * 60),
            R2_s  = as.POSIXct(R1_s  + input$r1_r2 * 60),
            Fac_s = as.POSIXct(R2_s  + input$r2_fac * 60),
            Enf_s = as.POSIXct(Fac_s + input$fac_enf * 60),
            All_s = as.POSIXct(Enf_s - input$chau2 * 60),
            Def_s = as.POSIXct(Enf_s + input$cui * 60),
            Res_s = as.POSIXct(Def_s + input$ress * 60)) %>%
     pivot_longer(cols = 1:8, names_to = "content", values_to = "heures") %>%
     mutate(startend = if_else(str_detect(content, "_s"), "start", "end"),
            content  = str_remove(content, "_s"),
            content  = str_remove(content, "_e")) %>%
     pivot_wider(names_from = startend, values_from = heures) %>%
     mutate(id = 1:8, four = "Four 2") %>%  relocate(id, four)
   
   f2$content <- fct_recode(f2$content, "Mélange" = "mel", "Rabat 1" = "R1", "Rabat 2" = "R2", 
                            "Façonnage" = "Fac", "Enfournement" = "Enf", "Allumage du four" = "All", 
                            "Défournement" = "Def", "Ressuage" = "Res")
   f2
   
   ### Four 3 ----
   
   f3 <- tibble(.rows = 1) %>% 
     mutate(mel_s = f2$start[f2$content=="Façonnage"] + 15 * 60,
            R1_s  = as.POSIXct(mel_s + input$mel_r1 * 60),
            R2_s  = as.POSIXct(R1_s  + input$r1_r2 * 60),
            Fac_s = as.POSIXct(R2_s  + input$r2_fac * 60),
            Enf_s = as.POSIXct(Fac_s + input$fac_enf * 60),
            All_s = as.POSIXct(Enf_s - input$chau2 * 60),
            Def_s = as.POSIXct(Enf_s + input$cui * 60),
            Res_s = as.POSIXct(Def_s + input$ress * 60)) %>%
     pivot_longer(cols = 1:8, names_to = "content", values_to = "heures") %>%
     mutate(startend = if_else(str_detect(content, "_s"), "start", "end"),
            content  = str_remove(content, "_s"),
            content  = str_remove(content, "_e")) %>%
     pivot_wider(names_from = startend, values_from = heures) %>%
     mutate(id = 1:8, four = "Four 3") %>%  relocate(id, four)
   
   f3$content <- fct_recode(f2$content, "Mélange" = "mel", "Rabat 1" = "R1", "Rabat 2" = "R2", 
                            "Façonnage" = "Fac", "Enfournement" = "Enf", "Allumage du four" = "All", 
                            "Défournement" = "Def", "Ressuage" = "Res")
   f3
   
   ### Four 4 ----
   
   f4 <- tibble(.rows = 1) %>% 
     mutate(mel_s = f3$start[f3$content=="Façonnage"] + 15 * 60,
            R1_s  = as.POSIXct(mel_s + input$mel_r1 * 60),
            R2_s  = as.POSIXct(R1_s  + input$r1_r2 * 60),
            Fac_s = as.POSIXct(R2_s  + input$r2_fac * 60),
            Enf_s = as.POSIXct(Fac_s + input$fac_enf * 60),
            All_s = as.POSIXct(Enf_s - input$chau2 * 60),
            Def_s = as.POSIXct(Enf_s + input$cui * 60),
            Res_s = as.POSIXct(Def_s + input$ress * 60)) %>%
     pivot_longer(cols = 1:8, names_to = "content", values_to = "heures") %>%
     mutate(startend = if_else(str_detect(content, "_s"), "start", "end"),
            content  = str_remove(content, "_s"),
            content  = str_remove(content, "_e")) %>%
     pivot_wider(names_from = startend, values_from = heures) %>%
     mutate(id = 1:8, four = "Four 4") %>%  relocate(id, four)
   
   f4$content <- fct_recode(f2$content, "Mélange" = "mel", "Rabat 1" = "R1", "Rabat 2" = "R2", 
                            "Façonnage" = "Fac", "Enfournement" = "Enf", "Allumage du four" = "All", 
                            "Défournement" = "Def", "Ressuage" = "Res")
   f4
   ### Fusion des chronologies qui tient compte du nombre de four ----
   f <-  bind_rows(f1,f2,f3,f4)
   
   f <- if (n_four == 1) f %>% filter(four == "Four 1") else {
     if (n_four == 2) f %>% filter(four %in% c("Four 1", "Four 2") ) else {
       if (n_four == 3) f %>% filter(four != "Four 4") else {
         if (n_four == 4) f }}}
   
   f %>% mutate(content = paste0(four," - ",content), group = four, id = seq(nrow(f)))
 })    
   
 groups <- reactive({data.frame(
   id = unique(even()[["four"]]), 
   content = unique(even()[["four"]]))})
 
 ## Construction de la frise ----
 
 output$timeline <- renderTimevis({
   timevis(even(), 
           options = list(editable = TRUE),
           groups = groups())
 })
 }

# Run the app ----
shinyApp(ui = ui, server = server)


