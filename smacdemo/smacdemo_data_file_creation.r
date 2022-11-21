# Creation des DF pour insertion data dans chacune des table de BDD smacdemo
library(dplyr)
#### STEP 1 - Table "localites" ####
# Champs necessaires
# localite/dpt/pays
# valable que pour les actions faites en FRANCE

crbpo <- read.table("C:/Users/ccjuhasz/Desktop/SMAC/BDD_SMAC/DATA_TEST/INSERTION/BDD_smacdemo/MLC_Bilan_CRBPO_annuel_MODIF.txt",
                    h = TRUE,
                    sep = "\t",
                    dec = ",")
head(crbpo)
dim(crbpo)
summary(crbpo)

# traitement localites
localite <- unique(crbpo$LOCALITE)
crbpo$LOCALITE <- toupper(crbpo$LOCALITE)
crbpo$LIEUDIT <- toupper(crbpo$LIEUDIT)

# traitement dept
dept <- unique(crbpo$DEPT)

# traitement pays
pays <- unique(crbpo$PAYS)

# DF creation
localites <- crbpo[, c("LOCALITE", "DEPT", "PAYS")]
localites <- localites[!duplicated(localites), ]

# write.csv(localites,
#           row.names = FALSE,
#           "C:/Users/Public/TABLE_LOCALITES_insertions.csv")

#### STEP 2 -  Table "lieudits" ####
# Champs necessaires
# localite_id/lieudit/lat/lon
crbpo$LIEUDIT <- toupper(crbpo$LIEUDIT)
crbpo$LOCALITE <- toupper(crbpo$LOCALITE)

ld <- crbpo[, c("LOCALITE", "DEPT", "LIEUDIT", "LAT", "LON")]

# traitement lieudits
li <- unique(ld$LIEUDIT)
li[order(li)]

# correction des erreurs de frappe

ld$LIEUDIT[ld$LIEUDIT == "BDE"] <- "BRAS DES ETANGS"
ld$LIEUDIT[ld$LIEUDIT == "GBN"] <- "GRAND BENARE"

ld$LIEUDIT[ld$LIEUDIT == "COLONIE RDC"] <- "ROND DES CHEVRONS"
ld$LIEUDIT[ld$LIEUDIT == "COLONIE RIR"] <- "RIVIERE DES REMPARTS"

ld$LIEUDIT[ld$LIEUDIT == "SAINTE-CLOTHILDE"] <- "SAINTE-CLOTILDE"

# correction localite pour GBN
ld$LOCALITE[ld$LIEUDIT == "GRAND BENARE"] <- "SAINT-PAUL"

# correction coord gps multiple pour un seul nom de lieudit
ld$LAT[ld$LIEUDIT == "GRANDE ANSE_COLOC"] <- -21.36751
ld$LON[ld$LIEUDIT == "GRANDE ANSE_COLOC"] <- 55.54408


lieud <- ld[!duplicated(ld), ]
lieud[order(lieud$LIEUDIT), ]

# aggregation des id unique des Localites
loc_id <- read.csv("C:/Users/Public/TABLE_LOCALITES_updated.csv")[, c("localite_id", "localite", "dept")]
loc_id$key <- paste(loc_id$localite,
                    loc_id$dept,
                    sep = "-")

lieud$key <- paste(lieud$LOCALITE,
                    lieud$DEPT,
                    sep = "-")

lieudits <- left_join(lieud,
                      loc_id[, c("localite_id", "key")],
                      by = "key")
names(lieudits) <- tolower(names(lieudits))

# virer les NA & remplacer par 99.99
lieudits$lat[is.na(lieudits$lat)] <- 99.99
lieudits$lon[is.na(lieudits$lon)] <- 99.99


# write.csv(lieudits[, c("localite_id", "lieudit", "lat", "lon")],
#           row.names = FALSE,
#           "C:/Users/Public/TABLE_LIEUDITS_insertions.csv")

#### STEP 3 -  Table "Intervenants" ####
# Champs necessaires
# interv_nom/interv_prenom/initiales/organisme
head(crbpo)
int <- unique(crbpo$BG)
int <- int[order(int)]

# Typo correction
int1 <- int[-c(3, 5, 10)]

# Recuperation des initiales
ll1 <- strsplit(int1, ", ") # | means or
ll2 <- lapply(ll1,
              rev)
int2 <- as.data.frame(do.call("rbind", ll2))
names(int2) <- c("interv_prenom", "interv_nom")
int2$interv_nom <- toupper(int2$interv_nom)

int2$i1 <- substr(int2$interv_prenom, 1, 1)

ll3 <- strsplit(int2$interv_nom, " |-") # | means or
ll4 <- lapply(ll3, substr, 1, 1)
int2$i2 <- sapply(ll4, paste, collapse ="")

int2$initiales <- paste(int2$i1, int2$i2, sep = "")
int2$organisme <- c(rep("UR", 3), "PNR", "UR", "ONF", "PNR", rep("UR", 3))

# write.csv(int2[, c("interv_nom", "interv_prenom", "initiales", "organisme")],
#           row.names = FALSE,
#           "C:/Users/Public/TABLE_INTERVENANTS_insertions.csv")

#### STEP 4 - Table "Protocoles" ####
# Champs necessaires
# protocole_nom/theme
# CF le script SQL

#### STEP 5 - Table "Missions"
# Champs necessaires
# mission_nom/mission_date_debut/mission_date_fin/fonds/cr/lieudit_id

mis <- read.table("C:/Users/Public/Fichier_ex_details_missions.txt",
                  h = T,
                  sep = "\t")
# FIRST - traitement des protocole_nom
manip <- strsplit(mis$protocole_nom,
                  ",")
obj <- rep(1:nrow(mis),
           times = lengths(manip))

mis2 <- mis[obj, ]
mis2$protocole_nom <- unlist(manip) # erase & reset the protocole_nom variable

# SECOND - traitement des protocole_theme
manip2 <- strsplit(mis2$intervenant_initiales,
                  ",")
obj2 <- rep(1:nrow(mis2),
           times = lengths(manip2))

mis3 <- mis2[obj2, ]
mis3$initiales <- unlist(manip2) 
# split(mis3, mis3$mission_nom) # verification

# THIRD - lien avec les intervenant_id
interv <- read.csv("C:/Users/Public/TABLE_INTERVENANTS_updated.csv",
                   h = T)

interv$initiales[interv$interv_nom == "AVARGUES"] <- "NA"

mis4 <- left_join(mis3,
                  interv[, c("intervenant_id", "initiales")],
                  by = "initiales")

# FOURTH - lien avec les lieudit_id
lieudit <- read.csv("C:/Users/Public/TABLE_LIEUDITS_updated.csv",
                   h = T)

mis5 <- left_join(mis4,
                  lieudit[, c("lieudit_id", "lieudit")],
                  by = c("localisation" = "lieudit"))

# FIFTH - lien avec les protocole_id
proto <- read.csv("C:/Users/Public/TABLE_PROTOCOLES_updated.csv",
                   h = T)

mis6 <- left_join(mis5,
                  proto,
                  by = c("theme", "protocole_nom"))

# fichier pour insertion table MISSIONS
missions <- mis6[, c("mission_nom", "mission_date_debut", "mission_date_fin", "cr", "lieudit_id")]
missions <- missions[!duplicated(missions), ]

# storage du fichier
# write.csv(missions,
#           row.names = FALSE,
#           "C:/Users/Public/TABLE_MISSIONS_insertions.csv")

# SIXTH - Recuperation des ID des missions
miss_up <- read.csv("C:/Users/Public/TABLE_MISSIONS_updated.csv",
                    h = T)

mis7 <- left_join(mis6,
                  miss_up[, c("mission_id", "mission_nom")],
                  by = "mission_nom")

#### STEP 6 - Table "Missions_Protocoles"
# Champs necessaires
# mission_id/protocole_id
mis_pro <- mis7[, c("mission_id", "protocole_id")]
mis_pro2 <- mis_pro[!duplicated(mis_pro), ]

# storage du fichier
# write.csv(mis_pro2,
#           row.names = FALSE,
#           "C:/Users/Public/TABLE_MISSIONS_PROTOCOLES_insertions.csv")

#### STEP 7 - Table "Missions_Intervenants"
# Champs necessaires
# mission_id/intervenant_id
mis_int <- mis7[, c("mission_id", "intervenant_id")]
mis_int2 <- mis_int[!duplicated(mis_int), ]

# storage du fichier
# write.csv(mis_int2,
#           row.names = FALSE,
#           "C:/Users/Public/TABLE_MISSIONS_INTERVENANTS_insertions.csv")