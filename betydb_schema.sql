-- MySQL dump 10.11
--
-- Host: localhost    Database: ebi_production
-- ------------------------------------------------------
-- Server version	5.0.77

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `citations`
--

DROP TABLE IF EXISTS `citations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `citations` (
  `id` int(11) NOT NULL auto_increment,
  `author` varchar(255) default NULL COMMENT 'last name of first author',
  `year` int(11) default NULL COMMENT 'year of publication',
  `title` varchar(255) default NULL COMMENT 'article title',
  `journal` varchar(255) default NULL COMMENT 'Journal name',
  `vol` int(11) default NULL,
  `pg` varchar(255) default NULL COMMENT 'page range of article',
  `url` varchar(512) default NULL COMMENT 'link to article url',
  `pdf` varchar(255) default NULL COMMENT 'link to pdf version of article',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `doi` varchar(255) default NULL COMMENT 'Digital Object Identifier',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=367 DEFAULT CHARSET=latin1 COMMENT='Table that records information for citations from which data';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `citations_sites`
--

DROP TABLE IF EXISTS `citations_sites`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `citations_sites` (
  `citation_id` int(11) default NULL,
  `site_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  UNIQUE KEY `index_citations_sites_on_citation_id_and_site_id` (`citation_id`,`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Lookup table to support many to many relationships between c';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `citations_treatments`
--

DROP TABLE IF EXISTS `citations_treatments`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `citations_treatments` (
  `citation_id` int(11) default NULL,
  `treatment_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  UNIQUE KEY `index_citations_treatments_on_citation_id_and_treatment_id` (`citation_id`,`treatment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='lookup table to support many to many relationships between c';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `covariates`
--

DROP TABLE IF EXISTS `covariates`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `covariates` (
  `id` int(11) NOT NULL auto_increment,
  `trait_id` int(11) default NULL,
  `variable_id` int(11) default NULL,
  `level` decimal(16,4) default NULL COMMENT 'Value of covariate, units are determined in variables table by the variable_id foreign key.',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_covariates_on_trait_id_and_variable_id` (`trait_id`,`variable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6767 DEFAULT CHARSET=latin1 COMMENT='The covariate table records conditions under which a measure';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cultivars`
--

DROP TABLE IF EXISTS `cultivars`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cultivars` (
  `id` int(11) NOT NULL auto_increment,
  `specie_id` int(11) default NULL,
  `name` varchar(255) default NULL COMMENT 'Cultivar name given by breeder or reported in citation.',
  `ecotype` varchar(255) default NULL COMMENT 'Does not apply for all species, used in the case of switchgrass to differentiate lowland and upland genotypes.',
  `notes` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `previous_id` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_cultivars_on_specie_id` (`specie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=292 DEFAULT CHARSET=latin1 COMMENT='The cultivar table records genotype or cultivar information ';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `error_logs`
--

DROP TABLE IF EXISTS `error_logs`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `error_logs` (
  `id` int(11) NOT NULL auto_increment,
  `record_id` int(11) default NULL,
  `description` varchar(255) default NULL COMMENT 'Description of error that needs to be addressed.',
  `relationship` varchar(255) default NULL,
  `user_id` int(11) default NULL COMMENT 'Identifies user responsible for handling error.',
  `fixed` int(11) default '0' COMMENT 'Set to 0 when error is reported, 1 after error has been checked and fixed.',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_error_logs_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=123975 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `inputs`
--

DROP TABLE IF EXISTS `inputs`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `inputs` (
  `id` int(11) NOT NULL auto_increment,
  `site_id` int(11) default NULL,
  `variable_id` int(11) default NULL,
  `filepath` varchar(255) default NULL,
  `format` text,
  `original_data` varchar(255) default NULL,
  `notes` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `inputs_runs`
--

DROP TABLE IF EXISTS `inputs_runs`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `inputs_runs` (
  `input_id` int(11) default NULL,
  `run_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  UNIQUE KEY `index_inputs_runs_on_input_id_and_run_id` (`input_id`,`run_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `likelihoods`
--

DROP TABLE IF EXISTS `likelihoods`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `likelihoods` (
  `id` int(11) NOT NULL auto_increment,
  `run_id` int(11) default NULL,
  `variable_id` int(11) default NULL,
  `input_id` int(11) default NULL,
  `loglikelihood` decimal(10,0) default NULL,
  `n_eff` decimal(10,0) default NULL,
  `weight` decimal(10,0) default NULL,
  `residual` decimal(10,0) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `managements`
--

DROP TABLE IF EXISTS `managements`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `managements` (
  `id` int(11) NOT NULL auto_increment,
  `citation_id` int(11) default NULL,
  `date` date default NULL COMMENT 'Date on which management was conducted.',
  `dateloc` decimal(4,2) default NULL COMMENT 'Level of confidence in value given as date. See documentation for details.',
  `mgmttype` varchar(255) default NULL COMMENT 'Type of management',
  `level` decimal(16,4) default NULL COMMENT 'Amount applied, not always required.',
  `units` varchar(255) default NULL COMMENT 'units, standardized for each management type.',
  `notes` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_managements_on_citation_id` (`citation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2373 DEFAULT CHARSET=latin1 COMMENT='A managment is an action that occurs at a specific time and ';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `managements_treatments`
--

DROP TABLE IF EXISTS `managements_treatments`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `managements_treatments` (
  `treatment_id` int(11) default NULL,
  `management_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  UNIQUE KEY `index_managements_treatments_on_management_id_and_treatment_id` (`management_id`,`treatment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='lookup table for many to many relationship between managemen';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `models`
--

DROP TABLE IF EXISTS `models`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `models` (
  `id` int(11) NOT NULL auto_increment,
  `model_name` varchar(255) default NULL,
  `model_path` varchar(255) default NULL,
  `revision` decimal(10,0) default NULL,
  `parent_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `pfts`
--

DROP TABLE IF EXISTS `pfts`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `pfts` (
  `id` int(11) NOT NULL auto_increment,
  `definition` text COMMENT 'Defines the creator and context under which the pft will be used.',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `name` varchar(255) default NULL COMMENT 'unique identifier used by PEcAn.',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COMMENT='The pfts table is used to associate a set of species with a ';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `pfts_priors`
--

DROP TABLE IF EXISTS `pfts_priors`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `pfts_priors` (
  `pft_id` int(11) default NULL,
  `prior_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  UNIQUE KEY `index_pfts_priors_on_pft_id_and_prior_id` (`pft_id`,`prior_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Lookup table for many to many relationship between pfts and ';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `pfts_species`
--

DROP TABLE IF EXISTS `pfts_species`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `pfts_species` (
  `pft_id` int(11) default NULL,
  `specie_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  UNIQUE KEY `index_pfts_species_on_pft_id_and_specie_id` (`pft_id`,`specie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Lookup table for many to many relationship between pfts and ';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `plants`
--

DROP TABLE IF EXISTS `plants`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `plants` (
  `id` int(11) NOT NULL auto_increment,
  `AcceptedSymbol` varchar(255) default NULL,
  `SynonymSymbol` varchar(255) default NULL,
  `ScientificName` varchar(255) default NULL,
  `Symbol` varchar(255) default NULL,
  `CommonName` varchar(255) default NULL,
  `PLANTS_Floristic_Area` text,
  `State` text,
  `Category` varchar(255) default NULL,
  `Genus` varchar(255) default NULL,
  `Family` varchar(255) default NULL,
  `FamilySymbol` varchar(255) default NULL,
  `FamilyCommonName` varchar(255) default NULL,
  `xOrder` varchar(255) default NULL,
  `SubClass` varchar(255) default NULL,
  `Class` varchar(255) default NULL,
  `SubDivision` varchar(255) default NULL,
  `Division` varchar(255) default NULL,
  `SuperDivision` varchar(255) default NULL,
  `SubKingdom` varchar(255) default NULL,
  `Kingdom` varchar(255) default NULL,
  `ITIS_TSN` int(11) default NULL,
  `Duration` varchar(255) default NULL,
  `GrowthHabit` varchar(255) default NULL,
  `NativeStatus` varchar(255) default NULL,
  `FederalNoxiousStatus` varchar(255) default NULL,
  `FederalNoxiousCommonName` varchar(255) default NULL,
  `StateNoxiousStatus` text,
  `StateNoxiousCommonName` text,
  `Invasive` varchar(255) default NULL,
  `Federal_TE_Status` varchar(255) default NULL,
  `State_TE_Status` varchar(255) default NULL,
  `State_TE_Common_Name` text,
  `NationalWetlandIndicatorStatus` varchar(255) default NULL,
  `RegionalWetlandIndicatorStatus` varchar(255) default NULL,
  `ActiveGrowthPeriod` varchar(255) default NULL,
  `AfterHarvestRegrowthRate` varchar(255) default NULL,
  `Bloat` varchar(255) default NULL,
  `C2N_Ratio` varchar(255) default NULL,
  `CoppicePotential` varchar(255) default NULL,
  `FallConspicuous` varchar(255) default NULL,
  `FireResistance` varchar(255) default NULL,
  `FlowerColor` varchar(255) default NULL,
  `FlowerConspicuous` varchar(255) default NULL,
  `FoliageColor` varchar(255) default NULL,
  `FoliagePorositySummer` varchar(255) default NULL,
  `FoliagePorosityWinter` varchar(255) default NULL,
  `FoliageTexture` varchar(255) default NULL,
  `FruitColor` varchar(255) default NULL,
  `FruitConspicuous` varchar(255) default NULL,
  `GrowthForm` varchar(255) default NULL,
  `GrowthRate` varchar(255) default NULL,
  `MaxHeight20Yrs` int(11) default NULL,
  `MatureHeight` int(11) default NULL,
  `KnownAllelopath` varchar(255) default NULL,
  `LeafRetention` varchar(255) default NULL,
  `Lifespan` varchar(255) default NULL,
  `LowGrowingGrass` varchar(255) default NULL,
  `NitrogenFixation` varchar(255) default NULL,
  `ResproutAbility` varchar(255) default NULL,
  `Shape_and_Orientation` varchar(255) default NULL,
  `Toxicity` varchar(255) default NULL,
  `AdaptedCoarseSoils` varchar(255) default NULL,
  `AdaptedMediumSoils` varchar(255) default NULL,
  `AdaptedFineSoils` varchar(255) default NULL,
  `AnaerobicTolerance` varchar(255) default NULL,
  `CaCO3Tolerance` varchar(255) default NULL,
  `ColdStratification` varchar(255) default NULL,
  `DroughtTolerance` varchar(255) default NULL,
  `FertilityRequirement` varchar(255) default NULL,
  `FireTolerance` varchar(255) default NULL,
  `MinFrostFreeDays` int(11) default NULL,
  `HedgeTolerance` varchar(255) default NULL,
  `MoistureUse` varchar(255) default NULL,
  `pH_Minimum` decimal(5,2) default NULL,
  `pH_Maximum` decimal(5,2) default NULL,
  `Min_PlantingDensity` int(11) default NULL,
  `Max_PlantingDensity` int(11) default NULL,
  `Precipitation_Minimum` int(11) default NULL,
  `Precipitation_Maximum` int(11) default NULL,
  `RootDepthMinimum` int(11) default NULL,
  `SalinityTolerance` varchar(255) default NULL,
  `ShadeTolerance` varchar(255) default NULL,
  `TemperatureMinimum` int(11) default NULL,
  `BloomPeriod` varchar(255) default NULL,
  `CommercialAvailability` varchar(255) default NULL,
  `FruitSeedAbundance` varchar(255) default NULL,
  `FruitSeedPeriodBegin` varchar(255) default NULL,
  `FruitSeedPeriodEnd` varchar(255) default NULL,
  `FruitSeedPersistence` varchar(255) default NULL,
  `Propogated_by_BareRoot` varchar(255) default NULL,
  `Propogated_by_Bulbs` varchar(255) default NULL,
  `Propogated_by_Container` varchar(255) default NULL,
  `Propogated_by_Corms` varchar(255) default NULL,
  `Propogated_by_Cuttings` varchar(255) default NULL,
  `Propogated_by_Seed` varchar(255) default NULL,
  `Propogated_by_Sod` varchar(255) default NULL,
  `Propogated_by_Sprigs` varchar(255) default NULL,
  `Propogated_by_Tubers` varchar(255) default NULL,
  `Seeds_per_Pound` int(11) default NULL,
  `SeedSpreadRate` varchar(255) default NULL,
  `SeedlingVigor` varchar(255) default NULL,
  `SmallGrain` varchar(255) default NULL,
  `VegetativeSpreadRate` varchar(255) default NULL,
  `Berry_Nut_Seed_Product` varchar(255) default NULL,
  `ChristmasTreeProduct` varchar(255) default NULL,
  `FodderProduct` varchar(255) default NULL,
  `FuelwoodProduct` varchar(255) default NULL,
  `LumberProduct` varchar(255) default NULL,
  `NavalStoreProduct` varchar(255) default NULL,
  `NurseryStockProduct` varchar(255) default NULL,
  `PalatableBrowseAnimal` varchar(255) default NULL,
  `PalatableGrazeAnimal` varchar(255) default NULL,
  `PalatableHuman` varchar(255) default NULL,
  `PostProduct` varchar(255) default NULL,
  `ProteinPotential` varchar(255) default NULL,
  `PulpwoodProduct` varchar(255) default NULL,
  `VeneerProduct` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50223 DEFAULT CHARSET=latin1 COMMENT='USDA Plants database. See plants.usda.gov for details.';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `posteriors`
--

DROP TABLE IF EXISTS `posteriors`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `posteriors` (
  `id` int(11) NOT NULL auto_increment,
  `pft_id` int(11) default NULL,
  `filename` varchar(255) default NULL,
  `parent_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `posteriors_runs`
--

DROP TABLE IF EXISTS `posteriors_runs`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `posteriors_runs` (
  `posterior_id` int(11) default NULL,
  `run_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  UNIQUE KEY `index_posteriors_runs_on_posterior_id_and_run_id` (`posterior_id`,`run_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `priors`
--

DROP TABLE IF EXISTS `priors`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `priors` (
  `id` int(11) NOT NULL auto_increment,
  `citation_id` int(11) default NULL,
  `variable_id` varchar(255) default NULL COMMENT 'Links to variable for which prior is used.',
  `phylogeny` varchar(255) default NULL COMMENT 'Used to note the group of plants for which the prior was specified, often the group of plants represented by the data used to specify the prior.',
  `distn` varchar(255) default NULL COMMENT 'Name of the probability distribution, using R naming convention (e.g. ''beta'',''f'', ''gamma'', ''lnorm'', ''norm'', ''pois'', ''t'', ''unif'', ''weibull''.',
  `parama` decimal(16,4) default NULL COMMENT 'First parameter for distribution, as specified by R.',
  `paramb` decimal(16,4) default NULL COMMENT 'Second parameter for distribution, as specified by R.',
  `paramc` decimal(16,4) default NULL COMMENT 'A third parameter, if required.',
  `n` int(11) default NULL COMMENT 'number of observations used to specify prior.',
  `notes` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_priors_on_citation_id` (`citation_id`),
  KEY `index_priors_on_variable_id` (`variable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=latin1 COMMENT='Prior distirbutions, one per trait per pft, can be used in m';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `runs`
--

DROP TABLE IF EXISTS `runs`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `runs` (
  `id` int(11) NOT NULL auto_increment,
  `model_id` int(11) default NULL,
  `site_id` int(11) default NULL,
  `start_time` datetime default NULL,
  `finish_time` datetime default NULL,
  `outdir` varchar(255) default NULL,
  `outprefix` varchar(255) default NULL,
  `setting` varchar(255) default NULL,
  `parameter_list` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL auto_increment,
  `usgsmuid` varchar(255) default NULL,
  `city` varchar(255) default NULL COMMENT 'Nearest city to site.',
  `state` varchar(255) default NULL COMMENT 'If in the United States, state in which study is conducted.',
  `country` varchar(255) default NULL,
  `lat` decimal(9,6) default NULL COMMENT 'Latitude, in decimal degrees',
  `lon` decimal(9,6) default NULL COMMENT 'Longitude, in decimal degrees.',
  `gdd` int(11) default NULL COMMENT 'Depreciated',
  `firstkillingfrost` date default NULL COMMENT 'Depreciated',
  `mat` int(11) default NULL COMMENT 'Mean Annual Temperature (C)',
  `map` int(11) default NULL COMMENT 'Mean Annual Precipitation (mm)',
  `masl` int(11) default NULL COMMENT 'Elevation (m above sea level)',
  `soil` varchar(255) default NULL COMMENT 'Soil type, as described in documentation.',
  `zrt` decimal(4,2) default NULL COMMENT 'Depreciated',
  `zh2o` decimal(4,1) default NULL COMMENT 'Depreciated',
  `som` decimal(4,2) default NULL COMMENT 'Depreciated',
  `notes` text,
  `soilnotes` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `sitename` varchar(255) default NULL,
  `greenhouse` tinyint(1) default NULL COMMENT 'Boolean: indicates if study was conducted in a field (0) or greenhouse, pot, or growth chamber (1)',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=582 DEFAULT CHARSET=latin1 COMMENT='Table of site-level information. A site is a unique location';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `species`
--

DROP TABLE IF EXISTS `species`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `species` (
  `id` int(11) NOT NULL auto_increment,
  `plant_id` int(11) default NULL,
  `spcd` int(11) default NULL,
  `pft` int(11) default NULL COMMENT 'Depreciated: moved to pfts_species table',
  `genus` varchar(255) default NULL,
  `species` varchar(255) default NULL,
  `scientificname` varchar(255) default NULL,
  `commonname` varchar(255) default NULL,
  `notes` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `AcceptedSymbol` varchar(255) default NULL,
  `SynonymSymbol` varchar(255) default NULL,
  `Symbol` varchar(255) default NULL,
  `PLANTS_Floristic_Area` text,
  `State` text,
  `Category` varchar(255) default NULL,
  `Family` varchar(255) default NULL,
  `FamilySymbol` varchar(255) default NULL,
  `FamilyCommonName` varchar(255) default NULL,
  `xOrder` varchar(255) default NULL,
  `SubClass` varchar(255) default NULL,
  `Class` varchar(255) default NULL,
  `SubDivision` varchar(255) default NULL,
  `Division` varchar(255) default NULL,
  `SuperDivision` varchar(255) default NULL,
  `SubKingdom` varchar(255) default NULL,
  `Kingdom` varchar(255) default NULL,
  `ITIS_TSN` int(11) default NULL,
  `Duration` varchar(255) default NULL,
  `GrowthHabit` varchar(255) default NULL,
  `NativeStatus` varchar(255) default NULL,
  `FederalNoxiousStatus` varchar(255) default NULL,
  `FederalNoxiousCommonName` varchar(255) default NULL,
  `StateNoxiousStatus` text,
  `StateNoxiousCommonName` text,
  `Invasive` varchar(255) default NULL,
  `Federal_TE_Status` varchar(255) default NULL,
  `State_TE_Status` varchar(255) default NULL,
  `State_TE_Common_Name` text,
  `NationalWetlandIndicatorStatus` varchar(255) default NULL,
  `RegionalWetlandIndicatorStatus` varchar(255) default NULL,
  `ActiveGrowthPeriod` varchar(255) default NULL,
  `AfterHarvestRegrowthRate` varchar(255) default NULL,
  `Bloat` varchar(255) default NULL,
  `C2N_Ratio` varchar(255) default NULL,
  `CoppicePotential` varchar(255) default NULL,
  `FallConspicuous` varchar(255) default NULL,
  `FireResistance` varchar(255) default NULL,
  `FlowerColor` varchar(255) default NULL,
  `FlowerConspicuous` varchar(255) default NULL,
  `FoliageColor` varchar(255) default NULL,
  `FoliagePorositySummer` varchar(255) default NULL,
  `FoliagePorosityWinter` varchar(255) default NULL,
  `FoliageTexture` varchar(255) default NULL,
  `FruitColor` varchar(255) default NULL,
  `FruitConspicuous` varchar(255) default NULL,
  `GrowthForm` varchar(255) default NULL,
  `GrowthRate` varchar(255) default NULL,
  `MaxHeight20Yrs` int(11) default NULL,
  `MatureHeight` int(11) default NULL,
  `KnownAllelopath` varchar(255) default NULL,
  `LeafRetention` varchar(255) default NULL,
  `Lifespan` varchar(255) default NULL,
  `LowGrowingGrass` varchar(255) default NULL,
  `NitrogenFixation` varchar(255) default NULL,
  `ResproutAbility` varchar(255) default NULL,
  `Shape_and_Orientation` varchar(255) default NULL,
  `Toxicity` varchar(255) default NULL,
  `AdaptedCoarseSoils` varchar(255) default NULL,
  `AdaptedMediumSoils` varchar(255) default NULL,
  `AdaptedFineSoils` varchar(255) default NULL,
  `AnaerobicTolerance` varchar(255) default NULL,
  `CaCO3Tolerance` varchar(255) default NULL,
  `ColdStratification` varchar(255) default NULL,
  `DroughtTolerance` varchar(255) default NULL,
  `FertilityRequirement` varchar(255) default NULL,
  `FireTolerance` varchar(255) default NULL,
  `MinFrostFreeDays` int(11) default NULL,
  `HedgeTolerance` varchar(255) default NULL,
  `MoistureUse` varchar(255) default NULL,
  `pH_Minimum` decimal(5,2) default NULL,
  `pH_Maximum` decimal(5,2) default NULL,
  `Min_PlantingDensity` int(11) default NULL,
  `Max_PlantingDensity` int(11) default NULL,
  `Precipitation_Minimum` int(11) default NULL,
  `Precipitation_Maximum` int(11) default NULL,
  `RootDepthMinimum` int(11) default NULL,
  `SalinityTolerance` varchar(255) default NULL,
  `ShadeTolerance` varchar(255) default NULL,
  `TemperatureMinimum` int(11) default NULL,
  `BloomPeriod` varchar(255) default NULL,
  `CommercialAvailability` varchar(255) default NULL,
  `FruitSeedAbundance` varchar(255) default NULL,
  `FruitSeedPeriodBegin` varchar(255) default NULL,
  `FruitSeedPeriodEnd` varchar(255) default NULL,
  `FruitSeedPersistence` varchar(255) default NULL,
  `Propogated_by_BareRoot` varchar(255) default NULL,
  `Propogated_by_Bulbs` varchar(255) default NULL,
  `Propogated_by_Container` varchar(255) default NULL,
  `Propogated_by_Corms` varchar(255) default NULL,
  `Propogated_by_Cuttings` varchar(255) default NULL,
  `Propogated_by_Seed` varchar(255) default NULL,
  `Propogated_by_Sod` varchar(255) default NULL,
  `Propogated_by_Sprigs` varchar(255) default NULL,
  `Propogated_by_Tubers` varchar(255) default NULL,
  `Seeds_per_Pound` int(11) default NULL,
  `SeedSpreadRate` varchar(255) default NULL,
  `SeedlingVigor` varchar(255) default NULL,
  `SmallGrain` varchar(255) default NULL,
  `VegetativeSpreadRate` varchar(255) default NULL,
  `Berry_Nut_Seed_Product` varchar(255) default NULL,
  `ChristmasTreeProduct` varchar(255) default NULL,
  `FodderProduct` varchar(255) default NULL,
  `FuelwoodProduct` varchar(255) default NULL,
  `LumberProduct` varchar(255) default NULL,
  `NavalStoreProduct` varchar(255) default NULL,
  `NurseryStockProduct` varchar(255) default NULL,
  `PalatableBrowseAnimal` varchar(255) default NULL,
  `PalatableGrazeAnimal` varchar(255) default NULL,
  `PalatableHuman` varchar(255) default NULL,
  `PostProduct` varchar(255) default NULL,
  `ProteinPotential` varchar(255) default NULL,
  `PulpwoodProduct` varchar(255) default NULL,
  `VeneerProduct` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51109 DEFAULT CHARSET=latin1 COMMENT='Table of species level information, for plants occurring in ';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `traits`
--

DROP TABLE IF EXISTS `traits`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `traits` (
  `id` int(11) NOT NULL auto_increment,
  `site_id` int(11) default NULL COMMENT 'Site at which measurement was taken.',
  `specie_id` int(11) default NULL COMMENT 'Species on which measurement was taken.',
  `citation_id` int(11) default NULL COMMENT 'Citation in which data was originally reported.',
  `cultivar_id` int(11) default NULL COMMENT 'Cultivar information, if any.',
  `treatment_id` int(11) default NULL COMMENT 'Experimental treatment identification. Required, can indicate observational study.',
  `date` datetime default NULL COMMENT 'Date on which measurement was made.',
  `dateloc` decimal(4,2) default NULL COMMENT 'Level of confidence in date. See documentation.',
  `time` time default NULL COMMENT 'Time at which measurement was taken. Sometimes necessary, e.g. for photosynthesis measurements.',
  `timeloc` decimal(4,2) default NULL COMMENT 'Level of confidence in time.',
  `mean` decimal(16,4) default NULL COMMENT 'Mean value of trait.',
  `n` int(11) default NULL COMMENT 'Number of experimental replicates used to estimate mean and statistical summary.',
  `statname` varchar(255) default NULL COMMENT 'Name of reported statistic.',
  `stat` decimal(16,4) default NULL COMMENT 'Value of reported statistic.',
  `notes` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `variable_id` int(11) default NULL COMMENT 'Links to information in variables table that describes trait being measured. ',
  `user_id` int(11) default NULL COMMENT 'ID of user who entered data.',
  `checked` tinyint(1) default '0' COMMENT 'Boolean, indicates if data have been checked after original entry.',
  `access_level` int(11) default NULL COMMENT 'Level of access required to view data.',
  PRIMARY KEY  (`id`),
  KEY `index_traits_on_specie_id` (`specie_id`),
  KEY `index_traits_on_site_id` (`site_id`),
  KEY `index_traits_on_citation_id` (`citation_id`),
  KEY `index_traits_on_cultivar_id` (`cultivar_id`),
  KEY `index_traits_on_treatment_id` (`treatment_id`),
  KEY `index_traits_on_variable_id` (`variable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36365 DEFAULT CHARSET=latin1 COMMENT='Table for recording trait data.';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `treatments`
--

DROP TABLE IF EXISTS `treatments`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `treatments` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL COMMENT 'Name of treatment, should be easy to associate with treatment name in original study.',
  `definition` varchar(255) default NULL COMMENT 'Description of treatment, e.g. levels of fertilizer applied, etc. This information may be redundant with ''levels'' information recorded in Managements table.',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `control` tinyint(1) default NULL COMMENT 'Boolean, indicates if treatment is a control or observational (1) or experimental treatment (0).',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1179 DEFAULT CHARSET=latin1 COMMENT='Treatments holds a separate record for each treatment in a s';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(40) default NULL COMMENT 'login id',
  `name` varchar(100) default '' COMMENT 'User name',
  `email` varchar(100) default NULL COMMENT 'email address',
  `city` varchar(255) default NULL,
  `country` varchar(255) default NULL,
  `field` varchar(255) default NULL COMMENT 'field of work (e.g. academic, industry, agriculture)',
  `crypted_password` varchar(40) default NULL,
  `salt` varchar(40) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `remember_token` varchar(40) default NULL,
  `remember_token_expires_at` datetime default NULL,
  `access_level` int(11) default NULL COMMENT 'data to which user has access',
  `page_access_level` int(11) default NULL COMMENT 'Determines the extent of data, if any, that user can edit.',
  `apikey` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_users_on_login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1 COMMENT='Records basic information about BETY users and contributors.';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `variables`
--

DROP TABLE IF EXISTS `variables`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `variables` (
  `id` int(11) NOT NULL auto_increment,
  `description` varchar(255) default NULL COMMENT 'Description or definition of variable.',
  `units` varchar(255) default NULL COMMENT 'units in which data must be entered.',
  `notes` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `name` varchar(255) default NULL COMMENT 'variable name, this is the name used by PEcAn and in other modeling contexts.',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=latin1 COMMENT='Defines variables used in traits, priors, and covariates tab';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `visitors`
--

DROP TABLE IF EXISTS `visitors`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `visitors` (
  `id` int(11) NOT NULL auto_increment,
  `ip` varchar(255) default NULL,
  `page` text,
  `visitdate` datetime default NULL,
  `lat` decimal(16,8) default NULL,
  `lon` decimal(16,8) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `yields`
--

DROP TABLE IF EXISTS `yields`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `yields` (
  `id` int(11) NOT NULL auto_increment,
  `citation_id` int(11) default NULL COMMENT 'Citation in which data originally reported.',
  `site_id` int(11) default NULL COMMENT 'Site at which crop was harvested.',
  `specie_id` int(11) default NULL COMMENT 'Species for which yield was measured.',
  `treatment_id` int(11) default NULL COMMENT 'Experimental treatment identification. Required, can indicate observational study.',
  `cultivar_id` int(11) default NULL COMMENT 'Cultivar information, if any.',
  `date` date default NULL COMMENT 'Date on which crop was harvested.',
  `dateloc` decimal(4,2) default NULL COMMENT 'Level of confidence in harvest date. See documentation.',
  `statname` varchar(255) default NULL COMMENT 'Name of reported statistic.',
  `stat` decimal(16,4) default NULL COMMENT 'Value of reported statistic.',
  `mean` decimal(16,4) default NULL COMMENT 'Mean yield reported. ',
  `n` int(11) default NULL COMMENT 'Number of replicates used to estimate mean and statistical summary.',
  `notes` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `user_id` int(11) default NULL COMMENT 'ID of user who entered data.',
  `checked` tinyint(1) default '0' COMMENT 'Boolean, indicates if data have been checked after original entry.',
  `access_level` int(11) default NULL COMMENT 'Level of access required to view data.',
  PRIMARY KEY  (`id`),
  KEY `index_yields_on_citation_id` (`citation_id`),
  KEY `index_yields_on_site_id` (`site_id`),
  KEY `index_yields_on_specie_id` (`specie_id`),
  KEY `index_yields_on_treatment_id` (`treatment_id`),
  KEY `index_yields_on_cultivar_id` (`cultivar_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8698 DEFAULT CHARSET=latin1 COMMENT='Table for recording yield (i.e.: aboveground biomass) data.';
SET character_set_client = @saved_cs_client;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-04-25 17:57:53
