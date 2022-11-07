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

# virer les NA & remplacer par ""
lieudits$lat[is.na(lieudits$lat)] <- 99.99
lieudits$lon[is.na(lieudits$lon)] <- 99.99


# write.csv(lieudits[, c("localite_id", "lieudit", "lat", "lon")],
#           row.names = FALSE,
#           "C:/Users/Public/TABLE_LIEUDITS_insertions.csv")
