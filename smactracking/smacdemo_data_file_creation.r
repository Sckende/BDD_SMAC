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

ld <- crbpo[, c("LOCALITE", "DEPT", "LIEUDIT", "LAT", "LON")]

# traitement lieudits
li <- unique(ld$LIEUDIT)
li[order(li)]

# correction des erreurs de frappe
# possible aussi de rechercher en fonction des coord gps
ld$LIEUDIT[ld$LIEUDIT == "BDE"] <- "BRAS DES ETANGS"
ld$LIEUDIT[ld$LIEUDIT == "GBN"] <- "GRAND BENARE"

ld$LIEUDIT[ld$LIEUDIT == "COLONIE RDC"] <- "ROND DES CHEVRONS"
ld$LIEUDIT[ld$LIEUDIT == "COLONIE RIR"] <- "RIVIERE DES REMPARTS"

lieud <- ld[!duplicated(ld), ]



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
