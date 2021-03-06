drop table "BILANA"."BANK0";
create table "BILANA"."BANK0"(
	CODIMP varchar2(20) not null primary key,
	PROVOPE varchar2(60),
	FLAGINF varchar2(60),
	TIPOSOGG varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK1";
create table "BILANA"."BANK1"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	FLAGINV varchar2(60));
drop table "BILANA"."BANK2";
create table "BILANA"."BANK2"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	STRUTBIL varchar2(60));
drop table "BILANA"."BANK3";
create table "BILANA"."BANK3"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARICL varchar2(60),
	STATOPATDED varchar2(60),
	STATOANAREVIS varchar2(60),
	STATOTAB40 varchar2(60));
drop table "BILANA"."BANK4";
create table "BILANA"."BANK4"(
	CODIMP varchar2(20) not null primary key,
	DATAAMM varchar2(60),
	STATOTAB45 varchar2(60),
	PROVOPE varchar2(60));
drop table "BILANA"."BANK5";
create table "BILANA"."BANK5"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB45 varchar2(60),
	STATORIL varchar2(60));
drop table "BILANA"."BANK6";
create table "BILANA"."BANK6"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB16 varchar2(60),
	STATOMODLAV varchar2(60),
	STATOTAB31 varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK7";
create table "BILANA"."BANK7"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	STATOTAB50 varchar2(60),
	DATAINS varchar2(60),
	FORMGIU varchar2(60),
	STATOTAB16 varchar2(60));
drop table "BILANA"."BANK8";
create table "BILANA"."BANK8"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	STATOTAB16 varchar2(60),
	STATOTAB75 varchar2(60),
	STATOTAB71 varchar2(60));
drop table "BILANA"."BANK9";
create table "BILANA"."BANK9"(
	CODIMP varchar2(20) not null primary key,
	DATARIC varchar2(60),
	CARBIL varchar2(60),
	STATOTAB20 varchar2(60),
	STATOTAB10 varchar2(60));
drop table "BILANA"."BANK10";
create table "BILANA"."BANK10"(
	CODIMP varchar2(20) not null primary key,
	DATARIC varchar2(60),
	ZONALEG varchar2(60));
drop table "BILANA"."BANK11";
create table "BILANA"."BANK11"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	FLAGD varchar2(60),
	LIREEURO varchar2(60));
drop table "BILANA"."BANK12";
create table "BILANA"."BANK12"(
	CODIMP varchar2(20) not null primary key,
	FLAGCBBANCHE varchar2(60),
	STATOTAB30 varchar2(60),
	STATOALTRICRITVAL varchar2(60));
drop table "BILANA"."BANK13";
create table "BILANA"."BANK13"(
	CODIMP varchar2(20) not null primary key,
	ZONALEG varchar2(60),
	STATOTAB65 varchar2(60),
	STATOANAATT varchar2(60),
	DATABIL varchar2(60),
	STATOANA varchar2(60));
drop table "BILANA"."BANK14";
create table "BILANA"."BANK14"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	STRUTBIL varchar2(60),
	NATURA varchar2(60),
	STATOTAB55 varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK15";
create table "BILANA"."BANK15"(
	CODIMP varchar2(20) not null primary key,
	DURLEG varchar2(60),
	SETTORE varchar2(60));
drop table "BILANA"."BANK16";
create table "BILANA"."BANK16"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK5"(CODIMP),
	PROVOPE varchar2(60),
	STATOPATDED varchar2(60),
	STATOANAVALSCORT varchar2(60),
	STATONOR varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK17";
create table "BILANA"."BANK17"(
	CODIMP varchar2(20) not null primary key,
	ZONALEG varchar2(60),
	STATORIL varchar2(60));
drop table "BILANA"."BANK18";
create table "BILANA"."BANK18"(
	CODIMP varchar2(20) not null primary key,
	REGLEG varchar2(60),
	STATOANAREVIS varchar2(60));
drop table "BILANA"."BANK19";
create table "BILANA"."BANK19"(
	CODIMP varchar2(20) not null primary key,
	PROVOPE varchar2(60),
	LIREEURO varchar2(60),
	STATONOR varchar2(60));
drop table "BILANA"."BANK20";
create table "BILANA"."BANK20"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB50 varchar2(60),
	STATOTAB20 varchar2(60),
	DATABIL varchar2(60));
drop table "BILANA"."BANK21";
create table "BILANA"."BANK21"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB31 varchar2(60),
	ZONALEG varchar2(60),
	STATOTAB55 varchar2(60));
drop table "BILANA"."BANK22";
create table "BILANA"."BANK22"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK4"(CODIMP),
	ATECO002 varchar2(60),
	STRUTBIL varchar2(60),
	TIPOSOGG varchar2(60),
	NATURA varchar2(60),
	STATOTAB31 varchar2(60));
drop table "BILANA"."BANK23";
create table "BILANA"."BANK23"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK5"(CODIMP),
	FLAGINF varchar2(60),
	CODDIP0 varchar2(60),
	CODBANCA varchar2(60),
	PROVLEG varchar2(60),
	LIREEURO varchar2(60));
drop table "BILANA"."BANK24";
create table "BILANA"."BANK24"(
	CODIMP varchar2(20) not null primary key,
	STRUTBIL varchar2(60),
	STATOTAB50 varchar2(60),
	STATOANAREVIS varchar2(60));
drop table "BILANA"."BANK25";
create table "BILANA"."BANK25"(
	CODIMP varchar2(20) not null primary key,
	FLAGCBBANCHE varchar2(60),
	STATOALTRICRITVAL varchar2(60),
	CODCCIA varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK26";
create table "BILANA"."BANK26"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB40 varchar2(60),
	STATOTAB60 varchar2(60),
	MODRIL varchar2(60),
	FORMGIU varchar2(60),
	STATOTAB15 varchar2(60));
drop table "BILANA"."BANK27";
create table "BILANA"."BANK27"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	STATOCOMPCAP varchar2(60),
	STATOANAATT varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK28";
create table "BILANA"."BANK28"(
	CODIMP varchar2(20) not null primary key,
	CABOPE varchar2(60),
	STATOANAREVIS varchar2(60),
	STATOANAATT varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK29";
create table "BILANA"."BANK29"(
	CODIMP varchar2(20) not null primary key,
	FLAGINF varchar2(60),
	STATORIC varchar2(60),
	STATOTAB75 varchar2(60),
	STATOTAB30 varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK30";
create table "BILANA"."BANK30"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB45 varchar2(60),
	STATOTAB50 varchar2(60),
	CODISTAT varchar2(60));
drop table "BILANA"."BANK31";
create table "BILANA"."BANK31"(
	CODIMP varchar2(20) not null primary key,
	DURLEG varchar2(60),
	STATOTAB16 varchar2(60));
drop table "BILANA"."BANK32";
create table "BILANA"."BANK32"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	STATOTAB72 varchar2(60));
drop table "BILANA"."BANK33";
create table "BILANA"."BANK33"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK12"(CODIMP),
	FLAGD varchar2(60),
	STATOANA varchar2(60),
	TIPOCONT varchar2(60));
drop table "BILANA"."BANK34";
create table "BILANA"."BANK34"(
	CODIMP varchar2(20) not null primary key,
	FLAGCBBANCHE varchar2(60),
	SETTORE varchar2(60),
	FORMGIU varchar2(60),
	STATOTAB30 varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK35";
create table "BILANA"."BANK35"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB60 varchar2(60),
	CODDIP0 varchar2(60),
	STATOANAREVIS varchar2(60));
drop table "BILANA"."BANK36";
create table "BILANA"."BANK36"(
	CODIMP varchar2(20) not null primary key,
	DATAINVIO varchar2(60),
	STATOTAB55 varchar2(60));
drop table "BILANA"."BANK37";
create table "BILANA"."BANK37"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB45 varchar2(60),
	RAMO varchar2(60),
	STATORIL varchar2(60));
drop table "BILANA"."BANK38";
create table "BILANA"."BANK38"(
	CODIMP varchar2(20) not null primary key,
	STATORIC varchar2(60),
	CABOPE varchar2(60),
	STATOTAB75 varchar2(60));
drop table "BILANA"."BANK39";
create table "BILANA"."BANK39"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	STATOANAOCC varchar2(60),
	FORMGIU varchar2(60),
	STATOANAREVIS varchar2(60));
drop table "BILANA"."BANK40";
create table "BILANA"."BANK40"(
	CODIMP varchar2(20) not null primary key,
	DATAAMM varchar2(60),
	STATOTAB45 varchar2(60),
	FLAGCBBANCHE varchar2(60),
	SETTORE varchar2(60));
drop table "BILANA"."BANK41";
create table "BILANA"."BANK41"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK16"(CODIMP),
	TIPOBIL varchar2(60),
	PROVLEG varchar2(60),
	STATOTAB05 varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK42";
create table "BILANA"."BANK42"(
	CODIMP varchar2(20) not null primary key,
	DATAINVIO varchar2(60),
	STATOTAB70 varchar2(60));
drop table "BILANA"."BANK43";
create table "BILANA"."BANK43"(
	CODIMP varchar2(20) not null primary key,
	STRUTBIL varchar2(60),
	STATOTAB50 varchar2(60),
	PROVLEG varchar2(60),
	STATOANAVALSCORT varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK44";
create table "BILANA"."BANK44"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	PROVLEG varchar2(60),
	PROVOPE varchar2(60),
	STATOTAB75 varchar2(60),
	TIPOSOGG varchar2(60));
drop table "BILANA"."BANK45";
create table "BILANA"."BANK45"(
	CODIMP varchar2(20) not null primary key,
	STATOPATDED varchar2(60),
	MODRIL varchar2(60),
	TIPOBIL varchar2(60),
	STATOTAB55 varchar2(60),
	DURLEG varchar2(60));
drop table "BILANA"."BANK46";
create table "BILANA"."BANK46"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK29"(CODIMP),
	CODISTAT varchar2(60),
	STATOTAB15 varchar2(60),
	FLAGINV varchar2(60),
	DATABIL varchar2(60),
	STATOTAB45 varchar2(60));
drop table "BILANA"."BANK47";
create table "BILANA"."BANK47"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB16 varchar2(60),
	CARBIL varchar2(60),
	STATOTAB10 varchar2(60));
drop table "BILANA"."BANK48";
create table "BILANA"."BANK48"(
	CODIMP varchar2(20) not null primary key,
	DURLEG varchar2(60),
	STATOTAB16 varchar2(60));
drop table "BILANA"."BANK49";
create table "BILANA"."BANK49"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	DENOMSTA varchar2(60),
	FLAGCBBANCHE varchar2(60));
drop table "BILANA"."BANK50";
create table "BILANA"."BANK50"(
	CODIMP varchar2(20) not null primary key,
	DATARIC varchar2(60),
	STATOPATDED varchar2(60),
	STATOANAATT varchar2(60),
	CODOPE varchar2(60));
drop table "BILANA"."BANK51";
create table "BILANA"."BANK51"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	STATOTAB70 varchar2(60),
	STATOMODLAV varchar2(60));
drop table "BILANA"."BANK52";
create table "BILANA"."BANK52"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK11"(CODIMP),
	DURLEG varchar2(60),
	SCHEMARICL varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK53";
create table "BILANA"."BANK53"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	CODISTAT varchar2(60),
	DATAINS varchar2(60),
	STATOALTRICRITVAL varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK54";
create table "BILANA"."BANK54"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	STATOTAB15 varchar2(60),
	REGLEG varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK55";
create table "BILANA"."BANK55"(
	CODIMP varchar2(20) not null primary key,
	CODDIP varchar2(60),
	STATOTAB20 varchar2(60),
	STATONOR varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK56";
create table "BILANA"."BANK56"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	REGLEG varchar2(60),
	STATOANAVALSCORT varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK57";
create table "BILANA"."BANK57"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	STRUTBIL varchar2(60),
	STATOTAB60 varchar2(60),
	STATOTAB72 varchar2(60),
	STATOGENTAB varchar2(60));
drop table "BILANA"."BANK58";
create table "BILANA"."BANK58"(
	CODIMP varchar2(20) not null primary key,
	FLAGCBBANCHE varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK59";
create table "BILANA"."BANK59"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB16 varchar2(60),
	STATOTAB72 varchar2(60),
	STATOPATDED varchar2(60),
	ATECO007 varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK60";
create table "BILANA"."BANK60"(
	CODIMP varchar2(20) not null primary key,
	FLAGCBBANCHE varchar2(60),
	DATAUPDT varchar2(60),
	STATOTAB40 varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK61";
create table "BILANA"."BANK61"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARICL varchar2(60),
	STATOTAB60 varchar2(60),
	STATOTAB05 varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK62";
create table "BILANA"."BANK62"(
	CODIMP varchar2(20) not null primary key,
	STATOCOMPCAP varchar2(60),
	DATABIL varchar2(60));
drop table "BILANA"."BANK63";
create table "BILANA"."BANK63"(
	CODIMP varchar2(20) not null primary key,
	NATURA varchar2(60),
	CODDIP0 varchar2(60),
	STATOANAATT varchar2(60));
drop table "BILANA"."BANK64";
create table "BILANA"."BANK64"(
	CODIMP varchar2(20) not null primary key,
	SETTORE varchar2(60),
	SCHEMARIL varchar2(60));
drop table "BILANA"."BANK65";
create table "BILANA"."BANK65"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB60 varchar2(60),
	STATOTAB30 varchar2(60),
	STATOTAB55 varchar2(60),
	ZONALEG varchar2(60));
drop table "BILANA"."BANK66";
create table "BILANA"."BANK66"(
	CODIMP varchar2(20) not null primary key,
	TIPOSOGG varchar2(60),
	STATOTAB15 varchar2(60));
drop table "BILANA"."BANK67";
create table "BILANA"."BANK67"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	STATOANA varchar2(60),
	ATECO007 varchar2(60),
	STATOANAVALSCORT varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK68";
create table "BILANA"."BANK68"(
	CODIMP varchar2(20) not null primary key,
	DATAINS varchar2(60),
	STATORIL varchar2(60));
drop table "BILANA"."BANK69";
create table "BILANA"."BANK69"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB15 varchar2(60),
	NATURA varchar2(60),
	CODCCIA varchar2(60));
drop table "BILANA"."BANK70";
create table "BILANA"."BANK70"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	DATAINS varchar2(60));
drop table "BILANA"."BANK71";
create table "BILANA"."BANK71"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARICL varchar2(60),
	TIPOBIL varchar2(60),
	STATOTAB40 varchar2(60),
	DURLEG varchar2(60));
drop table "BILANA"."BANK72";
create table "BILANA"."BANK72"(
	CODIMP varchar2(20) not null primary key,
	SETTORE varchar2(60),
	FLAGINF varchar2(60),
	STATOANAREVIS varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK73";
create table "BILANA"."BANK73"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB70 varchar2(60),
	STATOMODLAV varchar2(60),
	ATECO007 varchar2(60),
	STATOTAB20 varchar2(60));
drop table "BILANA"."BANK74";
create table "BILANA"."BANK74"(
	CODIMP varchar2(20) not null primary key,
	DURLEG varchar2(60),
	CABOPE varchar2(60),
	SCHEMARIL varchar2(60),
	STATOANAVALSCORT varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK75";
create table "BILANA"."BANK75"(
	CODIMP varchar2(20) not null primary key,
	FLAGINV varchar2(60),
	STRUTBIL varchar2(60),
	STATOPATDED varchar2(60));
drop table "BILANA"."BANK76";
create table "BILANA"."BANK76"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK18"(CODIMP),
	STATOTAB10 varchar2(60),
	STATOTAB15 varchar2(60),
	FLAGD varchar2(60),
	DATABIL varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK77";
create table "BILANA"."BANK77"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	STATOTAB45 varchar2(60),
	DATAUPDT varchar2(60),
	STATOANA varchar2(60),
	STATORIC varchar2(60));
drop table "BILANA"."BANK78";
create table "BILANA"."BANK78"(
	CODIMP varchar2(20) not null primary key,
	STATOMODLAV varchar2(60),
	STATOTAB05 varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK79";
create table "BILANA"."BANK79"(
	CODIMP varchar2(20) not null primary key,
	FLAGINF varchar2(60),
	RAMO varchar2(60),
	FLAGINV varchar2(60),
	STATOTAB10 varchar2(60));
drop table "BILANA"."BANK80";
create table "BILANA"."BANK80"(
	CODIMP varchar2(20) not null primary key,
	STATORIC varchar2(60),
	STATOTAB50 varchar2(60),
	STATOTAB30 varchar2(60));
drop table "BILANA"."BANK81";
create table "BILANA"."BANK81"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	STATOANAPRINC varchar2(60),
	DUROPE varchar2(60),
	STATOALTRICRITVAL varchar2(60));
drop table "BILANA"."BANK82";
create table "BILANA"."BANK82"(
	CODIMP varchar2(20) not null primary key,
	STATORIC varchar2(60),
	STATOTAB18 varchar2(60),
	STATOTAB72 varchar2(60),
	SCHEMARIL varchar2(60),
	CODISTAT varchar2(60));
drop table "BILANA"."BANK83";
create table "BILANA"."BANK83"(
	CODIMP varchar2(20) not null primary key,
	ATECO002 varchar2(60),
	PROVOPE varchar2(60));
drop table "BILANA"."BANK84";
create table "BILANA"."BANK84"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB30 varchar2(60),
	STATOALTRICRITVAL varchar2(60));
drop table "BILANA"."BANK85";
create table "BILANA"."BANK85"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARICL varchar2(60),
	LIREEURO varchar2(60),
	FLAGINF varchar2(60),
	CODCCIA varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK86";
create table "BILANA"."BANK86"(
	CODIMP varchar2(20) not null primary key,
	STATORIC varchar2(60),
	TIPOSOGG varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK87";
create table "BILANA"."BANK87"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB45 varchar2(60),
	FLAGINV varchar2(60),
	STATOTAB05 varchar2(60),
	STATOTAB10 varchar2(60));
drop table "BILANA"."BANK88";
create table "BILANA"."BANK88"(
	CODIMP varchar2(20) not null primary key,
	DURLEG varchar2(60),
	TIPOSOGG varchar2(60),
	FLAGCBBANCHE varchar2(60),
	STATOTAB30 varchar2(60),
	STATOTAB20 varchar2(60));
drop table "BILANA"."BANK89";
create table "BILANA"."BANK89"(
	CODIMP varchar2(20) not null primary key,
	DATAINS varchar2(60),
	TIPOCONT varchar2(60));
drop table "BILANA"."BANK90";
create table "BILANA"."BANK90"(
	CODIMP varchar2(20) not null primary key,
	STATOCOMPCAP varchar2(60),
	CODOPE varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK91";
create table "BILANA"."BANK91"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	STATOTAB40 varchar2(60),
	STATOTAB30 varchar2(60),
	STATORIL varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK92";
create table "BILANA"."BANK92"(
	CODIMP varchar2(20) not null primary key,
	DATAAMM varchar2(60),
	CABOPE varchar2(60),
	TIPOCONT varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK93";
create table "BILANA"."BANK93"(
	CODIMP varchar2(20) not null primary key,
	DURLEG varchar2(60),
	STATORIC varchar2(60));
drop table "BILANA"."BANK94";
create table "BILANA"."BANK94"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB30 varchar2(60),
	ATECO007 varchar2(60));
drop table "BILANA"."BANK95";
create table "BILANA"."BANK95"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB62 varchar2(60),
	FLAGINF varchar2(60),
	TIPOCONT varchar2(60));
drop table "BILANA"."BANK96";
create table "BILANA"."BANK96"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB16 varchar2(60),
	LIREEURO varchar2(60),
	DENOMSTA varchar2(60));
drop table "BILANA"."BANK97";
create table "BILANA"."BANK97"(
	CODIMP varchar2(20) not null primary key,
	REGLEG varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK98";
create table "BILANA"."BANK98"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	STATOTAB05 varchar2(60),
	STATOTAB20 varchar2(60));
drop table "BILANA"."BANK99";
create table "BILANA"."BANK99"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK9"(CODIMP),
	NATURA varchar2(60),
	MODRIL varchar2(60),
	STATOANAVALSCORT varchar2(60),
	STATOTAB55 varchar2(60),
	STATOANAREVIS varchar2(60));
drop table "BILANA"."BANK100";
create table "BILANA"."BANK100"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	DATARIC varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK101";
create table "BILANA"."BANK101"(
	CODIMP varchar2(20) not null primary key,
	MODRIL varchar2(60),
	STRUTBIL varchar2(60),
	STATOTAB40 varchar2(60));
drop table "BILANA"."BANK102";
create table "BILANA"."BANK102"(
	CODIMP varchar2(20) not null primary key,
	DATAINVIO varchar2(60),
	DENOMSTA varchar2(60),
	STATOANAATT varchar2(60),
	CODOPE varchar2(60));
drop table "BILANA"."BANK103";
create table "BILANA"."BANK103"(
	CODIMP varchar2(20) not null primary key,
	FLAGINF varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK104";
create table "BILANA"."BANK104"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	STATOMODLAV varchar2(60),
	STATOANAVALSCORT varchar2(60),
	STATOANAREVIS varchar2(60));
drop table "BILANA"."BANK105";
create table "BILANA"."BANK105"(
	CODIMP varchar2(20) not null primary key,
	DATAINS varchar2(60),
	CODCCIA varchar2(60));
drop table "BILANA"."BANK106";
create table "BILANA"."BANK106"(
	CODIMP varchar2(20) not null primary key,
	STATORIC varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK107";
create table "BILANA"."BANK107"(
	CODIMP varchar2(20) not null primary key,
	FLAGD varchar2(60),
	CODDIP0 varchar2(60),
	STATOMODLAV varchar2(60));
drop table "BILANA"."BANK108";
create table "BILANA"."BANK108"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB62 varchar2(60),
	STATOTAB60 varchar2(60),
	REGLEG varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK109";
create table "BILANA"."BANK109"(
	CODIMP varchar2(20) not null primary key,
	STATOANAOCC varchar2(60),
	STATOTAB15 varchar2(60),
	PROVLEG varchar2(60),
	STATOTAB05 varchar2(60),
	STATOALTRICRITVAL varchar2(60));
drop table "BILANA"."BANK110";
create table "BILANA"."BANK110"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	DATAAMM varchar2(60),
	TIPOCONT varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK111";
create table "BILANA"."BANK111"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK23"(CODIMP),
	STATOTAB80 varchar2(60),
	STATOTAB50 varchar2(60),
	TIPOCONT varchar2(60),
	STATORIL varchar2(60));
drop table "BILANA"."BANK112";
create table "BILANA"."BANK112"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB31 varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK113";
create table "BILANA"."BANK113"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB60 varchar2(60),
	SCHEMARIL varchar2(60),
	FORMGIU varchar2(60),
	STATOANAREVIS varchar2(60),
	LIREEURO varchar2(60));
drop table "BILANA"."BANK114";
create table "BILANA"."BANK114"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	FLAGD varchar2(60),
	STATOANAREVIS varchar2(60),
	STATONOR varchar2(60),
	CARBIL varchar2(60));
drop table "BILANA"."BANK115";
create table "BILANA"."BANK115"(
	CODIMP varchar2(20) not null primary key,
	STATOANAOCC varchar2(60),
	STATOTAB50 varchar2(60),
	STATOMODLAV varchar2(60),
	STATOTAB72 varchar2(60));
drop table "BILANA"."BANK116";
create table "BILANA"."BANK116"(
	CODIMP varchar2(20) not null primary key,
	PROVOPE varchar2(60),
	RAMO varchar2(60),
	STATOALTRICRITVAL varchar2(60));
drop table "BILANA"."BANK117";
create table "BILANA"."BANK117"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK56"(CODIMP),
	DENOMSTA varchar2(60),
	STATOTAB15 varchar2(60));
drop table "BILANA"."BANK118";
create table "BILANA"."BANK118"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK52"(CODIMP),
	FLAGINV varchar2(60),
	STATOTAB75 varchar2(60));
drop table "BILANA"."BANK119";
create table "BILANA"."BANK119"(
	CODIMP varchar2(20) not null primary key,
	CODDIP0 varchar2(60),
	STATOTAB55 varchar2(60));
drop table "BILANA"."BANK120";
create table "BILANA"."BANK120"(
	CODIMP varchar2(20) not null primary key,
	FLAGCBBANCHE varchar2(60),
	STATOTAB05 varchar2(60));
drop table "BILANA"."BANK121";
create table "BILANA"."BANK121"(
	CODIMP varchar2(20) not null primary key,
	CABOPE varchar2(60),
	MODRIL varchar2(60));
drop table "BILANA"."BANK122";
create table "BILANA"."BANK122"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK77"(CODIMP),
	CABLEG varchar2(60),
	NATURA varchar2(60),
	STATOTAB75 varchar2(60));
drop table "BILANA"."BANK123";
create table "BILANA"."BANK123"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	SCHEMARICL varchar2(60),
	CABOPE varchar2(60),
	FLAGINF varchar2(60));
drop table "BILANA"."BANK124";
create table "BILANA"."BANK124"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK74"(CODIMP),
	STATOTAB60 varchar2(60),
	LIREEURO varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK125";
create table "BILANA"."BANK125"(
	CODIMP varchar2(20) not null primary key,
	STATOANAOCC varchar2(60),
	STATOTAB60 varchar2(60),
	FORMGIU varchar2(60));
drop table "BILANA"."BANK126";
create table "BILANA"."BANK126"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	SETTORE varchar2(60));
drop table "BILANA"."BANK127";
create table "BILANA"."BANK127"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB31 varchar2(60),
	ZONALEG varchar2(60));
drop table "BILANA"."BANK128";
create table "BILANA"."BANK128"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK94"(CODIMP),
	CODISTAT varchar2(60),
	STATOGENTAB varchar2(60),
	STATOTAB19 varchar2(60));
drop table "BILANA"."BANK129";
create table "BILANA"."BANK129"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK112"(CODIMP),
	DENOMSTA varchar2(60),
	STATONOR varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK130";
create table "BILANA"."BANK130"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK67"(CODIMP),
	STATOANAPRINC varchar2(60),
	CABLEG varchar2(60));
drop table "BILANA"."BANK131";
create table "BILANA"."BANK131"(
	CODIMP varchar2(20) not null primary key,
	ATECO002 varchar2(60),
	CODISTAT varchar2(60),
	PROVOPE varchar2(60),
	ZONALEG varchar2(60),
	CODBANCA varchar2(60));
drop table "BILANA"."BANK132";
create table "BILANA"."BANK132"(
	CODIMP varchar2(20) not null primary key,
	NUMPATDED varchar2(60),
	NATURA varchar2(60),
	STATOTAB50 varchar2(60),
	DATAUPDT varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK133";
create table "BILANA"."BANK133"(
	CODIMP varchar2(20) not null primary key,
	DATAINVIO varchar2(60),
	STATOTAB31 varchar2(60),
	ZONALEG varchar2(60),
	TIPOCONT varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK134";
create table "BILANA"."BANK134"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	DATAINVIO varchar2(60),
	STRUTBIL varchar2(60),
	CODOPE varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK135";
create table "BILANA"."BANK135"(
	CODIMP varchar2(20) not null primary key,
	ATECO002 varchar2(60),
	RAMO varchar2(60),
	STATOTAB31 varchar2(60),
	ATECO007 varchar2(60));
drop table "BILANA"."BANK136";
create table "BILANA"."BANK136"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK5"(CODIMP),
	DATARIC varchar2(60),
	STRUTBIL varchar2(60),
	STATOTAB20 varchar2(60));
drop table "BILANA"."BANK137";
create table "BILANA"."BANK137"(
	CODIMP varchar2(20) not null primary key,
	FLAGCBBANCHE varchar2(60),
	FLAGINF varchar2(60));
drop table "BILANA"."BANK138";
create table "BILANA"."BANK138"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB18 varchar2(60),
	STATOTAB30 varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK139";
create table "BILANA"."BANK139"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB15 varchar2(60),
	MODRIL varchar2(60),
	STATOANAATT varchar2(60),
	STATOTAB55 varchar2(60));
drop table "BILANA"."BANK140";
create table "BILANA"."BANK140"(
	CODIMP varchar2(20) not null primary key,
	DATAAMM varchar2(60),
	STATOPATDED varchar2(60));
drop table "BILANA"."BANK141";
create table "BILANA"."BANK141"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	STATORIC varchar2(60),
	SCHEMARICL varchar2(60),
	MODRIL varchar2(60),
	DATARIC varchar2(60));
drop table "BILANA"."BANK142";
create table "BILANA"."BANK142"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB60 varchar2(60),
	STATOTAB50 varchar2(60),
	ATECO007 varchar2(60),
	STATOTAB55 varchar2(60),
	CARBIL varchar2(60));
drop table "BILANA"."BANK143";
create table "BILANA"."BANK143"(
	CODIMP varchar2(20) not null primary key,
	PROVOPE varchar2(60),
	STRUTBIL varchar2(60),
	TIPOBIL varchar2(60),
	DATAINS varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK144";
create table "BILANA"."BANK144"(
	CODIMP varchar2(20) not null primary key,
	CODBANCA varchar2(60),
	DATABIL varchar2(60));
drop table "BILANA"."BANK145";
create table "BILANA"."BANK145"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK8"(CODIMP),
	FLAGD varchar2(60),
	ATECO007 varchar2(60));
drop table "BILANA"."BANK146";
create table "BILANA"."BANK146"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK99"(CODIMP),
	SETTORE varchar2(60),
	STATOANA varchar2(60));
drop table "BILANA"."BANK147";
create table "BILANA"."BANK147"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	FLAGD varchar2(60),
	STATOGENTAB varchar2(60),
	REGOPE varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK148";
create table "BILANA"."BANK148"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	STRUTBIL varchar2(60),
	TIPOCONT varchar2(60),
	STATOTAB10 varchar2(60));
drop table "BILANA"."BANK149";
create table "BILANA"."BANK149"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	STATOTAB70 varchar2(60),
	STATOMODLAV varchar2(60),
	STATOANA varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK150";
create table "BILANA"."BANK150"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	PROVLEG varchar2(60));
drop table "BILANA"."BANK151";
create table "BILANA"."BANK151"(
	CODIMP varchar2(20) not null primary key,
	STATORIC varchar2(60),
	PROVOPE varchar2(60),
	STATOANAREVIS varchar2(60),
	ZONALEG varchar2(60));
drop table "BILANA"."BANK152";
create table "BILANA"."BANK152"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB45 varchar2(60),
	FORMGIU varchar2(60),
	STATOTAB19 varchar2(60));
drop table "BILANA"."BANK153";
create table "BILANA"."BANK153"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	SCHEMARIL varchar2(60),
	STATOTAB55 varchar2(60),
	STATONOR varchar2(60));
drop table "BILANA"."BANK154";
create table "BILANA"."BANK154"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK126"(CODIMP),
	STATOTAB60 varchar2(60),
	MODRIL varchar2(60),
	ATECO007 varchar2(60));
drop table "BILANA"."BANK155";
create table "BILANA"."BANK155"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	STATOMODLAV varchar2(60),
	TIPOCONT varchar2(60));
drop table "BILANA"."BANK156";
create table "BILANA"."BANK156"(
	CODIMP varchar2(20) not null primary key,
	DUROPE varchar2(60),
	STATOTAB60 varchar2(60),
	ZONAOPE varchar2(60),
	STATOANAREVIS varchar2(60),
	STATOTAB30 varchar2(60));
drop table "BILANA"."BANK157";
create table "BILANA"."BANK157"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	DATARIC varchar2(60),
	FORMGIU varchar2(60),
	TIPOCONT varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK158";
create table "BILANA"."BANK158"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	SETTORE varchar2(60));
drop table "BILANA"."BANK159";
create table "BILANA"."BANK159"(
	CODIMP varchar2(20) not null primary key,
	STATOCOMPCAP varchar2(60),
	STATOTAB15 varchar2(60),
	STATOTAB72 varchar2(60),
	TIPOBIL varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK160";
create table "BILANA"."BANK160"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	DURLEG varchar2(60),
	CABOPE varchar2(60),
	NATURA varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK161";
create table "BILANA"."BANK161"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB45 varchar2(60),
	REGOPE varchar2(60),
	STATOTAB55 varchar2(60));
drop table "BILANA"."BANK162";
create table "BILANA"."BANK162"(
	CODIMP varchar2(20) not null primary key,
	TIPOBIL varchar2(60),
	STATOTAB75 varchar2(60),
	ZONALEG varchar2(60));
drop table "BILANA"."BANK163";
create table "BILANA"."BANK163"(
	CODIMP varchar2(20) not null primary key,
	CODDIP0 varchar2(60),
	STATORIL varchar2(60));
drop table "BILANA"."BANK164";
create table "BILANA"."BANK164"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK7"(CODIMP),
	CABLEG varchar2(60),
	CODISTAT varchar2(60),
	FLAGD varchar2(60));
drop table "BILANA"."BANK165";
create table "BILANA"."BANK165"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB62 varchar2(60),
	STATORIC varchar2(60),
	STATORIL varchar2(60));
drop table "BILANA"."BANK166";
create table "BILANA"."BANK166"(
	CODIMP varchar2(20) not null primary key,
	DATAINVIO varchar2(60),
	STATOTAB19 varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK167";
create table "BILANA"."BANK167"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	DURLEG varchar2(60),
	DENOMSTA varchar2(60));
drop table "BILANA"."BANK168";
create table "BILANA"."BANK168"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	CABOPE varchar2(60),
	FLAGCBBANCHE varchar2(60));
drop table "BILANA"."BANK169";
create table "BILANA"."BANK169"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	SETTORE varchar2(60),
	FLAGINV varchar2(60),
	STATOANAREVIS varchar2(60),
	ATECO007 varchar2(60));
drop table "BILANA"."BANK170";
create table "BILANA"."BANK170"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK165"(CODIMP),
	NATURA varchar2(60),
	FLAGINV varchar2(60),
	LIREEURO varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK171";
create table "BILANA"."BANK171"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	STATORIC varchar2(60),
	MODRIL varchar2(60),
	REGOPE varchar2(60),
	STATONOR varchar2(60));
drop table "BILANA"."BANK172";
create table "BILANA"."BANK172"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	DURLEG varchar2(60),
	STATOTAB50 varchar2(60),
	CODOPE varchar2(60),
	DATABIL varchar2(60));
drop table "BILANA"."BANK173";
create table "BILANA"."BANK173"(
	CODIMP varchar2(20) not null primary key,
	ATECO007 varchar2(60),
	CODOPE varchar2(60));
drop table "BILANA"."BANK174";
create table "BILANA"."BANK174"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK82"(CODIMP),
	REGOPE varchar2(60),
	TIPOCONT varchar2(60));
drop table "BILANA"."BANK175";
create table "BILANA"."BANK175"(
	CODIMP varchar2(20) not null primary key,
	DATAAMM varchar2(60),
	SCHEMARICL varchar2(60),
	CODISTAT varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK176";
create table "BILANA"."BANK176"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB15 varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK177";
create table "BILANA"."BANK177"(
	CODIMP varchar2(20) not null primary key,
	DATARIC varchar2(60),
	STATOPATDED varchar2(60));
drop table "BILANA"."BANK178";
create table "BILANA"."BANK178"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	DATARIC varchar2(60),
	STATOTAB75 varchar2(60),
	STATOANAREVIS varchar2(60));
drop table "BILANA"."BANK179";
create table "BILANA"."BANK179"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	DATAUPDT varchar2(60),
	STATOTAB10 varchar2(60));
drop table "BILANA"."BANK180";
create table "BILANA"."BANK180"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB70 varchar2(60),
	STATOANAATT varchar2(60));
drop table "BILANA"."BANK181";
create table "BILANA"."BANK181"(
	CODIMP varchar2(20) not null primary key,
	ATECO002 varchar2(60),
	STATOTAB16 varchar2(60));
drop table "BILANA"."BANK182";
create table "BILANA"."BANK182"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	STATOTAB70 varchar2(60),
	CABOPE varchar2(60),
	NATURA varchar2(60),
	STATOTAB16 varchar2(60));
drop table "BILANA"."BANK183";
create table "BILANA"."BANK183"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	SCHEMARIL varchar2(60),
	STATOMODLAV varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK184";
create table "BILANA"."BANK184"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB15 varchar2(60),
	FLAGD varchar2(60),
	STATOTAB20 varchar2(60));
drop table "BILANA"."BANK185";
create table "BILANA"."BANK185"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	DATAINVIO varchar2(60),
	CARBIL varchar2(60));
drop table "BILANA"."BANK186";
create table "BILANA"."BANK186"(
	CODIMP varchar2(20) not null primary key,
	PROVLEG varchar2(60),
	STATOGENTAB varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK187";
create table "BILANA"."BANK187"(
	CODIMP varchar2(20) not null primary key,
	STATONOR varchar2(60),
	STATORIL varchar2(60));
drop table "BILANA"."BANK188";
create table "BILANA"."BANK188"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB70 varchar2(60),
	SETTORE varchar2(60),
	STATOMODLAV varchar2(60),
	REGOPE varchar2(60),
	STRUTBIL varchar2(60));
drop table "BILANA"."BANK189";
create table "BILANA"."BANK189"(
	CODIMP varchar2(20) not null primary key,
	DATAAMM varchar2(60),
	STATOTAB45 varchar2(60),
	STATOTAB19 varchar2(60),
	STATOANAOCC varchar2(60));
drop table "BILANA"."BANK190";
create table "BILANA"."BANK190"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	STATOTAB70 varchar2(60),
	CARBIL varchar2(60));
drop table "BILANA"."BANK191";
create table "BILANA"."BANK191"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARIL varchar2(60),
	STATOTAB19 varchar2(60));
drop table "BILANA"."BANK192";
create table "BILANA"."BANK192"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK15"(CODIMP),
	STATOTAB45 varchar2(60),
	PROVOPE varchar2(60),
	STATOTAB72 varchar2(60));
drop table "BILANA"."BANK193";
create table "BILANA"."BANK193"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARIL varchar2(60),
	STATOTAB19 varchar2(60),
	CARBIL varchar2(60),
	STATONOR varchar2(60),
	CODBANCA varchar2(60));
drop table "BILANA"."BANK194";
create table "BILANA"."BANK194"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK8"(CODIMP),
	NATURA varchar2(60),
	STATOANA varchar2(60));
drop table "BILANA"."BANK195";
create table "BILANA"."BANK195"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK139"(CODIMP),
	FLAGCBBANCHE varchar2(60),
	ZONAOPE varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK196";
create table "BILANA"."BANK196"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	MODRIL varchar2(60),
	REGLEG varchar2(60),
	STATOTAB10 varchar2(60));
drop table "BILANA"."BANK197";
create table "BILANA"."BANK197"(
	CODIMP varchar2(20) not null primary key,
	FLAGCBBANCHE varchar2(60),
	CODCCIA varchar2(60));
drop table "BILANA"."BANK198";
create table "BILANA"."BANK198"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB30 varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK199";
create table "BILANA"."BANK199"(
	CODIMP varchar2(20) not null primary key,
	FLAGINV varchar2(60),
	CODOPE varchar2(60));
drop table "BILANA"."BANK200";
create table "BILANA"."BANK200"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK22"(CODIMP),
	STATOTAB71 varchar2(60),
	DENOMSTA varchar2(60),
	SETTORE varchar2(60),
	STATOANAOCC varchar2(60));
drop table "BILANA"."BANK201";
create table "BILANA"."BANK201"(
	CODIMP varchar2(20) not null primary key,
	STATOGENTAB varchar2(60),
	FLAGCBBANCHE varchar2(60),
	CODDIP0 varchar2(60),
	LIREEURO varchar2(60),
	STATOTAB05 varchar2(60));
drop table "BILANA"."BANK202";
create table "BILANA"."BANK202"(
	CODIMP varchar2(20) not null primary key,
	CABOPE varchar2(60),
	FLAGINF varchar2(60),
	FLAGCBBANCHE varchar2(60),
	STATOTAB55 varchar2(60));
drop table "BILANA"."BANK203";
create table "BILANA"."BANK203"(
	CODIMP varchar2(20) not null primary key,
	STATONOR varchar2(60),
	STATOTAB55 varchar2(60));
drop table "BILANA"."BANK204";
create table "BILANA"."BANK204"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB40 varchar2(60),
	CARBIL varchar2(60),
	STATOANAVALSCORT varchar2(60),
	STATORIL varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK205";
create table "BILANA"."BANK205"(
	CODIMP varchar2(20) not null primary key,
	FORMGIU varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK206";
create table "BILANA"."BANK206"(
	CODIMP varchar2(20) not null primary key,
	STATORIC varchar2(60),
	SCHEMARIL varchar2(60),
	STATOTAB72 varchar2(60),
	ZONALEG varchar2(60),
	CODISTAT varchar2(60));
drop table "BILANA"."BANK207";
create table "BILANA"."BANK207"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	STATONOR varchar2(60));
drop table "BILANA"."BANK208";
create table "BILANA"."BANK208"(
	CODIMP varchar2(20) not null primary key,
	STATOALTRICRITVAL varchar2(60),
	FORMGIU varchar2(60),
	STATOTAB55 varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK209";
create table "BILANA"."BANK209"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	DATAAMM varchar2(60),
	DATAINVIO varchar2(60),
	ATECO007 varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK210";
create table "BILANA"."BANK210"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB70 varchar2(60),
	TIPOSOGG varchar2(60),
	STATOTAB72 varchar2(60),
	CODBANCA varchar2(60),
	TIPOCONT varchar2(60));
drop table "BILANA"."BANK211";
create table "BILANA"."BANK211"(
	CODIMP varchar2(20) not null primary key,
	STATOCOMPCAP varchar2(60),
	RAMO varchar2(60),
	FLAGD varchar2(60),
	SCHEMARIL varchar2(60),
	CODISTAT varchar2(60));
drop table "BILANA"."BANK212";
create table "BILANA"."BANK212"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	STATOTAB75 varchar2(60),
	STATOTAB05 varchar2(60),
	STATORIL varchar2(60),
	STATOANAREVIS varchar2(60));
drop table "BILANA"."BANK213";
create table "BILANA"."BANK213"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK190"(CODIMP),
	STATOTAB45 varchar2(60),
	FLAGINV varchar2(60),
	CODISTAT varchar2(60));
drop table "BILANA"."BANK214";
create table "BILANA"."BANK214"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	STATOTAB60 varchar2(60),
	STATOTAB31 varchar2(60));
drop table "BILANA"."BANK215";
create table "BILANA"."BANK215"(
	CODIMP varchar2(20) not null primary key,
	PROVOPE varchar2(60),
	STRUTBIL varchar2(60),
	STATOTAB05 varchar2(60));
drop table "BILANA"."BANK216";
create table "BILANA"."BANK216"(
	CODIMP varchar2(20) not null primary key,
	CABOPE varchar2(60),
	CODCCIA varchar2(60),
	STATONOR varchar2(60));
drop table "BILANA"."BANK217";
create table "BILANA"."BANK217"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	STATOTAB50 varchar2(60),
	FLAGINF varchar2(60),
	STATORIL varchar2(60),
	DATABIL varchar2(60));
drop table "BILANA"."BANK218";
create table "BILANA"."BANK218"(
	CODIMP varchar2(20) not null primary key,
	STATOANAOCC varchar2(60),
	STATOTAB72 varchar2(60),
	STATOANA varchar2(60),
	STATOTAB20 varchar2(60));
drop table "BILANA"."BANK219";
create table "BILANA"."BANK219"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB15 varchar2(60),
	STATOTAB55 varchar2(60),
	CODOPE varchar2(60));
drop table "BILANA"."BANK220";
create table "BILANA"."BANK220"(
	CODIMP varchar2(20) not null primary key,
	REGLEG varchar2(60),
	FLAGD varchar2(60),
	TIPOBIL varchar2(60),
	REGOPE varchar2(60),
	DURLEG varchar2(60));
drop table "BILANA"."BANK221";
create table "BILANA"."BANK221"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK36"(CODIMP),
	DURLEG varchar2(60),
	CODDIP0 varchar2(60));
drop table "BILANA"."BANK222";
create table "BILANA"."BANK222"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK79"(CODIMP),
	STATOTAB80 varchar2(60),
	STATOANAOCC varchar2(60),
	STATOTAB35 varchar2(60),
	STATOANAATT varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK223";
create table "BILANA"."BANK223"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	STATOTAB71 varchar2(60),
	STATOTAB05 varchar2(60));
drop table "BILANA"."BANK224";
create table "BILANA"."BANK224"(
	CODIMP varchar2(20) not null primary key,
	NATURA varchar2(60),
	SCHEMARIL varchar2(60),
	STATOPATDED varchar2(60),
	STATOTAB19 varchar2(60),
	STATOTAB10 varchar2(60));
drop table "BILANA"."BANK225";
create table "BILANA"."BANK225"(
	CODIMP varchar2(20) not null primary key,
	FLAGINF varchar2(60),
	SCHEMARIL varchar2(60),
	STATOTAB40 varchar2(60),
	STATOTAB55 varchar2(60));
drop table "BILANA"."BANK226";
create table "BILANA"."BANK226"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	SCHEMARICL varchar2(60),
	LIREEURO varchar2(60));
drop table "BILANA"."BANK227";
create table "BILANA"."BANK227"(
	CODIMP varchar2(20) not null primary key,
	CABOPE varchar2(60),
	CODDIP0 varchar2(60),
	CODCCIA varchar2(60),
	STATORIL varchar2(60));
drop table "BILANA"."BANK228";
create table "BILANA"."BANK228"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB31 varchar2(60),
	CODOPE varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK229";
create table "BILANA"."BANK229"(
	CODIMP varchar2(20) not null primary key,
	CABOPE varchar2(60),
	STRUTBIL varchar2(60),
	STATOTAB40 varchar2(60),
	CODBANCA varchar2(60));
drop table "BILANA"."BANK230";
create table "BILANA"."BANK230"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB16 varchar2(60),
	CABOPE varchar2(60),
	FLAGINV varchar2(60),
	STATOTAB30 varchar2(60),
	CODISTAT varchar2(60));
drop table "BILANA"."BANK231";
create table "BILANA"."BANK231"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	FLAGCBBANCHE varchar2(60));
drop table "BILANA"."BANK232";
create table "BILANA"."BANK232"(
	CODIMP varchar2(20) not null primary key,
	DATARIC varchar2(60),
	SETTORE varchar2(60));
drop table "BILANA"."BANK233";
create table "BILANA"."BANK233"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	REGLEG varchar2(60),
	STATOANAOCC varchar2(60));
drop table "BILANA"."BANK234";
create table "BILANA"."BANK234"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB72 varchar2(60),
	FLAGINV varchar2(60));
drop table "BILANA"."BANK235";
create table "BILANA"."BANK235"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	STATORIC varchar2(60),
	STATOTAB62 varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK236";
create table "BILANA"."BANK236"(
	CODIMP varchar2(20) not null primary key,
	CABOPE varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK237";
create table "BILANA"."BANK237"(
	CODIMP varchar2(20) not null primary key,
	STATOANAOCC varchar2(60),
	FLAGINF varchar2(60),
	STATOTAB55 varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK238";
create table "BILANA"."BANK238"(
	CODIMP varchar2(20) not null primary key,
	FLAGCBBANCHE varchar2(60),
	SCHEMARIL varchar2(60));
drop table "BILANA"."BANK239";
create table "BILANA"."BANK239"(
	CODIMP varchar2(20) not null primary key,
	MODRIL varchar2(60),
	DATABIL varchar2(60));
drop table "BILANA"."BANK240";
create table "BILANA"."BANK240"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK22"(CODIMP),
	DATAINVIO varchar2(60),
	RAMO varchar2(60),
	TIPOBIL varchar2(60),
	STATOTAB55 varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK241";
create table "BILANA"."BANK241"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	STATOPATDED varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK242";
create table "BILANA"."BANK242"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	CODOPE varchar2(60));
drop table "BILANA"."BANK243";
create table "BILANA"."BANK243"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	STATOTAB71 varchar2(60),
	TIPOBIL varchar2(60),
	ATECO002 varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK244";
create table "BILANA"."BANK244"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	TIPOBIL varchar2(60),
	STATOTAB55 varchar2(60),
	STATOALTRICRITVAL varchar2(60));
drop table "BILANA"."BANK245";
create table "BILANA"."BANK245"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	STATOTAB40 varchar2(60),
	STATOTAB30 varchar2(60),
	STATOALTRICRITVAL varchar2(60));
drop table "BILANA"."BANK246";
create table "BILANA"."BANK246"(
	CODIMP varchar2(20) not null primary key,
	STATOANAOCC varchar2(60),
	STATOTAB40 varchar2(60),
	STATOPATDED varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK247";
create table "BILANA"."BANK247"(
	CODIMP varchar2(20) not null primary key,
	FLAGCBBANCHE varchar2(60),
	FORMGIU varchar2(60),
	CARBIL varchar2(60),
	STATOTAB10 varchar2(60));
drop table "BILANA"."BANK248";
create table "BILANA"."BANK248"(
	CODIMP varchar2(20) not null primary key,
	STATOCOMPCAP varchar2(60),
	CABLEG varchar2(60),
	RAMO varchar2(60),
	ATECO007 varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK249";
create table "BILANA"."BANK249"(
	CODIMP varchar2(20) not null primary key,
	REGLEG varchar2(60),
	CARBIL varchar2(60),
	STATOTAB55 varchar2(60));
drop table "BILANA"."BANK250";
create table "BILANA"."BANK250"(
	CODIMP varchar2(20) not null primary key,
	DATAINVIO varchar2(60),
	STATORIC varchar2(60),
	TIPOSOGG varchar2(60),
	RAMO varchar2(60),
	STATOTAB55 varchar2(60));
drop table "BILANA"."BANK251";
create table "BILANA"."BANK251"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB65 varchar2(60),
	ZONAOPE varchar2(60),
	CARBIL varchar2(60),
	STATOANAVALSCORT varchar2(60),
	ZONALEG varchar2(60));
drop table "BILANA"."BANK252";
create table "BILANA"."BANK252"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK124"(CODIMP),
	ZONALEG varchar2(60),
	STATOTAB55 varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK253";
create table "BILANA"."BANK253"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB62 varchar2(60),
	SCHEMARICL varchar2(60),
	STRUTBIL varchar2(60),
	STATOMODLAV varchar2(60),
	TIPOCONT varchar2(60));
drop table "BILANA"."BANK254";
create table "BILANA"."BANK254"(
	CODIMP varchar2(20) not null primary key,
	TIPOSOGG varchar2(60),
	STATOANA varchar2(60));
drop table "BILANA"."BANK255";
create table "BILANA"."BANK255"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB72 varchar2(60),
	ATECO007 varchar2(60));
drop table "BILANA"."BANK256";
create table "BILANA"."BANK256"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARICL varchar2(60),
	STATOTAB40 varchar2(60),
	STATOANA varchar2(60),
	STATOTAB30 varchar2(60));
drop table "BILANA"."BANK257";
create table "BILANA"."BANK257"(
	CODIMP varchar2(20) not null primary key,
	DATAINVIO varchar2(60),
	CARBIL varchar2(60));
drop table "BILANA"."BANK258";
create table "BILANA"."BANK258"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB62 varchar2(60),
	DATAINS varchar2(60),
	STATOTAB05 varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK259";
create table "BILANA"."BANK259"(
	CODIMP varchar2(20) not null primary key,
	DATARIC varchar2(60),
	STATOTAB10 varchar2(60),
	SCHEMARIL varchar2(60),
	PROVLEG varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK260";
create table "BILANA"."BANK260"(
	CODIMP varchar2(20) not null primary key,
	STRUTBIL varchar2(60),
	FLAGD varchar2(60),
	SCHEMARIL varchar2(60),
	CODCCIA varchar2(60),
	STATOANAATT varchar2(60));
drop table "BILANA"."BANK261";
create table "BILANA"."BANK261"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK114"(CODIMP),
	DATARIC varchar2(60),
	NATURA varchar2(60),
	STATOTAB19 varchar2(60));
drop table "BILANA"."BANK262";
create table "BILANA"."BANK262"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	RAMO varchar2(60),
	CODOPE varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK263";
create table "BILANA"."BANK263"(
	CODIMP varchar2(20) not null primary key,
	RAMO varchar2(60),
	NATURA varchar2(60),
	STATOTAB15 varchar2(60),
	DATAINS varchar2(60),
	STATOPATDED varchar2(60));
drop table "BILANA"."BANK264";
create table "BILANA"."BANK264"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB15 varchar2(60),
	STATOMODLAV varchar2(60),
	STATOTAB40 varchar2(60),
	STATOTAB30 varchar2(60),
	TIPOCONT varchar2(60));
drop table "BILANA"."BANK265";
create table "BILANA"."BANK265"(
	CODIMP varchar2(20) not null primary key,
	DURLEG varchar2(60),
	RAMO varchar2(60),
	STATOTAB45 varchar2(60));
drop table "BILANA"."BANK266";
create table "BILANA"."BANK266"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARIL varchar2(60),
	STATORIL varchar2(60));
drop table "BILANA"."BANK267";
create table "BILANA"."BANK267"(
	CODIMP varchar2(20) not null primary key,
	DURLEG varchar2(60),
	TIPOCONT varchar2(60),
	STRUTBIL varchar2(60),
	STATOANAREVIS varchar2(60),
	CODOPE varchar2(60));
drop table "BILANA"."BANK268";
create table "BILANA"."BANK268"(
	CODIMP varchar2(20) not null primary key,
	STATOCOMPCAP varchar2(60),
	RAMO varchar2(60),
	TIPOBIL varchar2(60));
drop table "BILANA"."BANK269";
create table "BILANA"."BANK269"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	PROVLEG varchar2(60),
	STATOGENTAB varchar2(60),
	REGOPE varchar2(60),
	STATOTAB10 varchar2(60));
drop table "BILANA"."BANK270";
create table "BILANA"."BANK270"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	STATOTAB20 varchar2(60),
	PROVLEG varchar2(60),
	STATOTAB30 varchar2(60),
	STATOTAB19 varchar2(60));
drop table "BILANA"."BANK271";
create table "BILANA"."BANK271"(
	CODIMP varchar2(20) not null primary key,
	DURLEG varchar2(60),
	SCHEMARIL varchar2(60),
	CARBIL varchar2(60));
drop table "BILANA"."BANK272";
create table "BILANA"."BANK272"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARICL varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK273";
create table "BILANA"."BANK273"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	STATOTAB70 varchar2(60),
	STATOTAB15 varchar2(60),
	DATABIL varchar2(60));
drop table "BILANA"."BANK274";
create table "BILANA"."BANK274"(
	CODIMP varchar2(20) not null primary key,
	STATOCOMPCAP varchar2(60),
	DATAINS varchar2(60));
drop table "BILANA"."BANK275";
create table "BILANA"."BANK275"(
	CODIMP varchar2(20) not null primary key,
	RAMO varchar2(60),
	CARBIL varchar2(60),
	STATONOR varchar2(60),
	STATOANA varchar2(60));
drop table "BILANA"."BANK276";
create table "BILANA"."BANK276"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	STATOTAB16 varchar2(60),
	CABOPE varchar2(60),
	DATAINS varchar2(60),
	STATOTAB31 varchar2(60));
drop table "BILANA"."BANK277";
create table "BILANA"."BANK277"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	CODISTAT varchar2(60),
	TIPOSOGG varchar2(60),
	CODCCIA varchar2(60));
drop table "BILANA"."BANK278";
create table "BILANA"."BANK278"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	TIPOCONT varchar2(60),
	STATOTAB16 varchar2(60));
drop table "BILANA"."BANK279";
create table "BILANA"."BANK279"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	STATOMODLAV varchar2(60));
drop table "BILANA"."BANK280";
create table "BILANA"."BANK280"(
	CODIMP varchar2(20) not null primary key,
	FLAGINF varchar2(60),
	STATOTAB19 varchar2(60));
drop table "BILANA"."BANK281";
create table "BILANA"."BANK281"(
	CODIMP varchar2(20) not null primary key,
	TIPOBIL varchar2(60),
	ATECO007 varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK282";
create table "BILANA"."BANK282"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK59"(CODIMP),
	CABLEG varchar2(60),
	STATOTAB70 varchar2(60),
	DATAINS varchar2(60),
	TIPOCONT varchar2(60));
drop table "BILANA"."BANK283";
create table "BILANA"."BANK283"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB62 varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK284";
create table "BILANA"."BANK284"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB50 varchar2(60),
	LIREEURO varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK285";
create table "BILANA"."BANK285"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK40"(CODIMP),
	STATOPATDED varchar2(60),
	STATOTAB18 varchar2(60),
	STRUTBIL varchar2(60),
	REGLEG varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK286";
create table "BILANA"."BANK286"(
	CODIMP varchar2(20) not null primary key,
	STATOANAVALSCORT varchar2(60),
	STATOALTRICRITVAL varchar2(60));
drop table "BILANA"."BANK287";
create table "BILANA"."BANK287"(
	CODIMP varchar2(20) not null primary key,
	NATURA varchar2(60),
	ATECO007 varchar2(60),
	STATOANAVALSCORT varchar2(60));
drop table "BILANA"."BANK288";
create table "BILANA"."BANK288"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK36"(CODIMP),
	DURLEG varchar2(60),
	CODCCIA varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK289";
create table "BILANA"."BANK289"(
	CODIMP varchar2(20) not null primary key,
	DATARIC varchar2(60),
	STATOTAB60 varchar2(60),
	CODBANCA varchar2(60),
	STATOANA varchar2(60));
drop table "BILANA"."BANK290";
create table "BILANA"."BANK290"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	CABLEG varchar2(60),
	DATAINS varchar2(60));
drop table "BILANA"."BANK291";
create table "BILANA"."BANK291"(
	CODIMP varchar2(20) not null primary key,
	ATECO002 varchar2(60),
	NATURA varchar2(60),
	PROVLEG varchar2(60));
drop table "BILANA"."BANK292";
create table "BILANA"."BANK292"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	CODISTAT varchar2(60),
	TIPOSOGG varchar2(60),
	STRUTBIL varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK293";
create table "BILANA"."BANK293"(
	CODIMP varchar2(20) not null primary key,
	STRUTBIL varchar2(60),
	FLAGINV varchar2(60));
drop table "BILANA"."BANK294";
create table "BILANA"."BANK294"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	STATOTAB35 varchar2(60),
	PROVOPE varchar2(60),
	STATOTAB20 varchar2(60));
drop table "BILANA"."BANK295";
create table "BILANA"."BANK295"(
	CODIMP varchar2(20) not null primary key,
	STATOANAREVIS varchar2(60),
	TIPOCONT varchar2(60));
drop table "BILANA"."BANK296";
create table "BILANA"."BANK296"(
	CODIMP varchar2(20) not null primary key,
	TIPOSOGG varchar2(60),
	STATOMODLAV varchar2(60),
	STATOTAB05 varchar2(60),
	CODCCIA varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK297";
create table "BILANA"."BANK297"(
	CODIMP varchar2(20) not null primary key,
	PROVOPE varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK298";
create table "BILANA"."BANK298"(
	CODIMP varchar2(20) not null primary key,
	TIPOSOGG varchar2(60),
	STATOTAB31 varchar2(60),
	CARBIL varchar2(60));
drop table "BILANA"."BANK299";
create table "BILANA"."BANK299"(
	CODIMP varchar2(20) not null primary key,
	DATAINVIO varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK300";
create table "BILANA"."BANK300"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	ZONALEG varchar2(60),
	DATABIL varchar2(60));
drop table "BILANA"."BANK301";
create table "BILANA"."BANK301"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB30 varchar2(60),
	CARBIL varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK302";
create table "BILANA"."BANK302"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB70 varchar2(60),
	MODRIL varchar2(60),
	DATABIL varchar2(60),
	STATORIL varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK303";
create table "BILANA"."BANK303"(
	CODIMP varchar2(20) not null primary key,
	SETTORE varchar2(60),
	STATOANAREVIS varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK304";
create table "BILANA"."BANK304"(
	CODIMP varchar2(20) not null primary key,
	DURLEG varchar2(60),
	DUROPE varchar2(60),
	STATOPATDED varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK305";
create table "BILANA"."BANK305"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB70 varchar2(60),
	STRUTBIL varchar2(60));
drop table "BILANA"."BANK306";
create table "BILANA"."BANK306"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	STATOTAB75 varchar2(60));
drop table "BILANA"."BANK307";
create table "BILANA"."BANK307"(
	CODIMP varchar2(20) not null primary key,
	SETTORE varchar2(60),
	STATOTAB30 varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK308";
create table "BILANA"."BANK308"(
	CODIMP varchar2(20) not null primary key,
	STRUTBIL varchar2(60),
	STATOMODLAV varchar2(60),
	STATOTAB31 varchar2(60));
drop table "BILANA"."BANK309";
create table "BILANA"."BANK309"(
	CODIMP varchar2(20) not null primary key,
	DATABIL varchar2(60),
	STATOANAOCC varchar2(60),
	STATOANAATT varchar2(60),
	STATORIL varchar2(60),
	STATOANAVALSCORT varchar2(60));
drop table "BILANA"."BANK310";
create table "BILANA"."BANK310"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	DENOMSTA varchar2(60),
	STATOTAB60 varchar2(60),
	ATECO002 varchar2(60));
drop table "BILANA"."BANK311";
create table "BILANA"."BANK311"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB72 varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK312";
create table "BILANA"."BANK312"(
	CODIMP varchar2(20) not null primary key,
	DATAAMM varchar2(60),
	STATOANA varchar2(60),
	STATONOR varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK313";
create table "BILANA"."BANK313"(
	CODIMP varchar2(20) not null primary key,
	ATECO007 varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK314";
create table "BILANA"."BANK314"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB15 varchar2(60),
	DATABIL varchar2(60));
drop table "BILANA"."BANK315";
create table "BILANA"."BANK315"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB70 varchar2(60),
	PROVOPE varchar2(60),
	STATOTAB50 varchar2(60),
	STATOTAB10 varchar2(60));
drop table "BILANA"."BANK316";
create table "BILANA"."BANK316"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB16 varchar2(60),
	STATOTAB15 varchar2(60),
	STATOTAB45 varchar2(60));
drop table "BILANA"."BANK317";
create table "BILANA"."BANK317"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK151"(CODIMP),
	CABLEG varchar2(60),
	PROVOPE varchar2(60),
	CODCCIA varchar2(60),
	STATOTAB19 varchar2(60));
drop table "BILANA"."BANK318";
create table "BILANA"."BANK318"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK280"(CODIMP),
	FORMGIU varchar2(60),
	CABOPE varchar2(60),
	PROVLEG varchar2(60),
	STATOTAB20 varchar2(60),
	CODISTAT varchar2(60));
drop table "BILANA"."BANK319";
create table "BILANA"."BANK319"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	DENOMSTA varchar2(60),
	MODRIL varchar2(60),
	CARBIL varchar2(60),
	STATOANAOCC varchar2(60));
drop table "BILANA"."BANK320";
create table "BILANA"."BANK320"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	STATOTAB50 varchar2(60),
	DATAINS varchar2(60),
	STATOTAB20 varchar2(60));
drop table "BILANA"."BANK321";
create table "BILANA"."BANK321"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB31 varchar2(60),
	STATOANAATT varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK322";
create table "BILANA"."BANK322"(
	CODIMP varchar2(20) not null primary key,
	DATAINVIO varchar2(60),
	STATORIC varchar2(60),
	DATAINS varchar2(60),
	CABLEG varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK323";
create table "BILANA"."BANK323"(
	CODIMP varchar2(20) not null primary key,
	CODDIP0 varchar2(60),
	STATOANA varchar2(60));
drop table "BILANA"."BANK324";
create table "BILANA"."BANK324"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	MODRIL varchar2(60),
	NATURA varchar2(60),
	SCHEMARIL varchar2(60));
drop table "BILANA"."BANK325";
create table "BILANA"."BANK325"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	STATOANAVALSCORT varchar2(60),
	STATOTAB19 varchar2(60));
drop table "BILANA"."BANK326";
create table "BILANA"."BANK326"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB62 varchar2(60),
	STATORIC varchar2(60),
	PROVLEG varchar2(60),
	CODOPE varchar2(60));
drop table "BILANA"."BANK327";
create table "BILANA"."BANK327"(
	CODIMP varchar2(20) not null primary key,
	DATAINS varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK328";
create table "BILANA"."BANK328"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	CODDIP0 varchar2(60),
	STATOTAB71 varchar2(60),
	STATOTAB31 varchar2(60));
drop table "BILANA"."BANK329";
create table "BILANA"."BANK329"(
	CODIMP varchar2(20) not null primary key,
	CODDIP0 varchar2(60),
	FORMGIU varchar2(60));
drop table "BILANA"."BANK330";
create table "BILANA"."BANK330"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK97"(CODIMP),
	ATECO002 varchar2(60),
	TIPOSOGG varchar2(60),
	STATOTAB15 varchar2(60),
	CARBIL varchar2(60),
	CODCCIA varchar2(60));
drop table "BILANA"."BANK331";
create table "BILANA"."BANK331"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARICL varchar2(60),
	CARBIL varchar2(60),
	DATABIL varchar2(60),
	STATOANAOCC varchar2(60));
drop table "BILANA"."BANK332";
create table "BILANA"."BANK332"(
	CODIMP varchar2(20) not null primary key,
	PROVOPE varchar2(60),
	STATOTAB40 varchar2(60),
	STATOANAATT varchar2(60),
	STATOTAB20 varchar2(60));
drop table "BILANA"."BANK333";
create table "BILANA"."BANK333"(
	CODIMP varchar2(20) not null primary key,
	STATOMODLAV varchar2(60),
	CODDIP0 varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK334";
create table "BILANA"."BANK334"(
	CODIMP varchar2(20) not null primary key,
	DATAUPDT varchar2(60),
	STATOTAB19 varchar2(60),
	STATOALTRICRITVAL varchar2(60));
drop table "BILANA"."BANK335";
create table "BILANA"."BANK335"(
	CODIMP varchar2(20) not null primary key,
	STATOANAOCC varchar2(60),
	DATAINS varchar2(60),
	TIPOBIL varchar2(60),
	STATOANAREVIS varchar2(60),
	STATONOR varchar2(60));
drop table "BILANA"."BANK336";
create table "BILANA"."BANK336"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	PROVOPE varchar2(60),
	SCHEMARIL varchar2(60),
	PROVLEG varchar2(60));
drop table "BILANA"."BANK337";
create table "BILANA"."BANK337"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB70 varchar2(60),
	STATOANAOCC varchar2(60));
drop table "BILANA"."BANK338";
create table "BILANA"."BANK338"(
	CODIMP varchar2(20) not null primary key,
	FLAGINV varchar2(60),
	STATOANAATT varchar2(60));
drop table "BILANA"."BANK339";
create table "BILANA"."BANK339"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	STRUTBIL varchar2(60),
	TIPOCONT varchar2(60),
	STATORIL varchar2(60));
drop table "BILANA"."BANK340";
create table "BILANA"."BANK340"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK6"(CODIMP),
	ATECO002 varchar2(60),
	REGOPE varchar2(60),
	CARBIL varchar2(60),
	STATONOR varchar2(60),
	STATOANAVALSCORT varchar2(60));
drop table "BILANA"."BANK341";
create table "BILANA"."BANK341"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK82"(CODIMP),
	FLAGD varchar2(60),
	ZONAOPE varchar2(60),
	CODDIP varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK342";
create table "BILANA"."BANK342"(
	CODIMP varchar2(20) not null primary key,
	DATAINVIO varchar2(60),
	SCHEMARICL varchar2(60),
	STATOTAB75 varchar2(60));
drop table "BILANA"."BANK343";
create table "BILANA"."BANK343"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	CODCCIA varchar2(60),
	ATECO007 varchar2(60));
drop table "BILANA"."BANK344";
create table "BILANA"."BANK344"(
	CODIMP varchar2(20) not null primary key,
	ATECO002 varchar2(60),
	STATOTAB45 varchar2(60),
	PROVLEG varchar2(60));
drop table "BILANA"."BANK345";
create table "BILANA"."BANK345"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB60 varchar2(60),
	TIPOBIL varchar2(60));
drop table "BILANA"."BANK346";
create table "BILANA"."BANK346"(
	CODIMP varchar2(20) not null primary key,
	FLAGCBBANCHE varchar2(60),
	STATOANAATT varchar2(60),
	ATECO007 varchar2(60));
drop table "BILANA"."BANK347";
create table "BILANA"."BANK347"(
	CODIMP varchar2(20) not null primary key,
	NATURA varchar2(60),
	STATOTAB55 varchar2(60),
	ATECO007 varchar2(60),
	DATABIL varchar2(60),
	STATOTAB30 varchar2(60));
drop table "BILANA"."BANK348";
create table "BILANA"."BANK348"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	FORMGIU varchar2(60),
	STATOANA varchar2(60));
drop table "BILANA"."BANK349";
create table "BILANA"."BANK349"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB65 varchar2(60),
	LIREEURO varchar2(60),
	STATOANAREVIS varchar2(60));
drop table "BILANA"."BANK350";
create table "BILANA"."BANK350"(
	CODIMP varchar2(20) not null primary key,
	CABLEG varchar2(60),
	STATOTAB70 varchar2(60),
	CODBANCA varchar2(60));
drop table "BILANA"."BANK351";
create table "BILANA"."BANK351"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB62 varchar2(60),
	STATOTAB70 varchar2(60),
	STATOANA varchar2(60),
	STATOTAB05 varchar2(60));
drop table "BILANA"."BANK352";
create table "BILANA"."BANK352"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	STATOTAB16 varchar2(60),
	STATOANAPRINC varchar2(60),
	STATOTAB31 varchar2(60));
drop table "BILANA"."BANK353";
create table "BILANA"."BANK353"(
	CODIMP varchar2(20) not null primary key,
	DATAUPDT varchar2(60),
	STATOTAB40 varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK354";
create table "BILANA"."BANK354"(
	CODIMP varchar2(20) not null primary key,
	ATECO007 varchar2(60),
	STATOTAB72 varchar2(60),
	CARBIL varchar2(60),
	CODOPE varchar2(60),
	CODBANCA varchar2(60));
drop table "BILANA"."BANK355";
create table "BILANA"."BANK355"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB40 varchar2(60),
	STATOTAB20 varchar2(60),
	STATORIL varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK356";
create table "BILANA"."BANK356"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB45 varchar2(60),
	FLAGCBBANCHE varchar2(60),
	PROVLEG varchar2(60),
	ZONALEG varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK357";
create table "BILANA"."BANK357"(
	CODIMP varchar2(20) not null primary key,
	STATOCOMPCAP varchar2(60),
	SCHEMARICL varchar2(60),
	CABOPE varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK358";
create table "BILANA"."BANK358"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB15 varchar2(60),
	NATURA varchar2(60),
	STATOTAB55 varchar2(60));
drop table "BILANA"."BANK359";
create table "BILANA"."BANK359"(
	CODIMP varchar2(20) not null primary key,
	DATAUPDT varchar2(60),
	STATOALTRICRITVAL varchar2(60));
drop table "BILANA"."BANK360";
create table "BILANA"."BANK360"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB60 varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK361";
create table "BILANA"."BANK361"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	NUMPATDED varchar2(60),
	LIREEURO varchar2(60),
	STATORIL varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK362";
create table "BILANA"."BANK362"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	STATOTAB45 varchar2(60),
	CODDIP0 varchar2(60));
drop table "BILANA"."BANK363";
create table "BILANA"."BANK363"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARICL varchar2(60),
	PROVOPE varchar2(60),
	FLAGD varchar2(60),
	ZONALEG varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK364";
create table "BILANA"."BANK364"(
	CODIMP varchar2(20) not null primary key,
	ZONALEG varchar2(60),
	ATECO007 varchar2(60),
	REGOPE varchar2(60),
	STATOANAREVIS varchar2(60));
drop table "BILANA"."BANK365";
create table "BILANA"."BANK365"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	DURLEG varchar2(60),
	STATOTAB15 varchar2(60),
	SETTORE varchar2(60),
	STATOALTRICRITVAL varchar2(60));
drop table "BILANA"."BANK366";
create table "BILANA"."BANK366"(
	CODIMP varchar2(20) not null primary key,
	NUMPATDED varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK367";
create table "BILANA"."BANK367"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK160"(CODIMP),
	CODISTAT varchar2(60),
	SETTORE varchar2(60),
	SCHEMARICL varchar2(60));
drop table "BILANA"."BANK368";
create table "BILANA"."BANK368"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	DENOMSTA varchar2(60),
	SCHEMARIL varchar2(60));
drop table "BILANA"."BANK369";
create table "BILANA"."BANK369"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB62 varchar2(60),
	PROVLEG varchar2(60),
	FLAGINF varchar2(60));
drop table "BILANA"."BANK370";
create table "BILANA"."BANK370"(
	CODIMP varchar2(20) not null primary key,
	DATARIC varchar2(60),
	DATABIL varchar2(60));
drop table "BILANA"."BANK371";
create table "BILANA"."BANK371"(
	CODIMP varchar2(20) not null primary key,
	RAMO varchar2(60),
	STATOANAATT varchar2(60),
	DATABIL varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK372";
create table "BILANA"."BANK372"(
	CODIMP varchar2(20) not null primary key,
	DURLEG varchar2(60),
	STATOTAB05 varchar2(60));
drop table "BILANA"."BANK373";
create table "BILANA"."BANK373"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARICL varchar2(60),
	RAMO varchar2(60),
	STATOTAB40 varchar2(60),
	STATOTAB19 varchar2(60),
	DURLEG varchar2(60));
drop table "BILANA"."BANK374";
create table "BILANA"."BANK374"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	STRUTBIL varchar2(60),
	ATECO007 varchar2(60));
drop table "BILANA"."BANK375";
create table "BILANA"."BANK375"(
	CODIMP varchar2(20) not null primary key,
	ATECO002 varchar2(60),
	SETTORE varchar2(60));
drop table "BILANA"."BANK376";
create table "BILANA"."BANK376"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB62 varchar2(60),
	STATOTAB65 varchar2(60),
	CODOPE varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK377";
create table "BILANA"."BANK377"(
	CODIMP varchar2(20) not null primary key,
	RAMO varchar2(60),
	STATOALTRICRITVAL varchar2(60));
drop table "BILANA"."BANK378";
create table "BILANA"."BANK378"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	STATOTAB45 varchar2(60),
	STATOTAB40 varchar2(60),
	ZONALEG varchar2(60));
drop table "BILANA"."BANK379";
create table "BILANA"."BANK379"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	STATORIL varchar2(60));
drop table "BILANA"."BANK380";
create table "BILANA"."BANK380"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	SCHEMARICL varchar2(60),
	STATOTAB35 varchar2(60),
	REGOPE varchar2(60),
	STATOPATDED varchar2(60));
drop table "BILANA"."BANK381";
create table "BILANA"."BANK381"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB31 varchar2(60),
	STATOTAB72 varchar2(60),
	FLAGINF varchar2(60),
	TIPOCONT varchar2(60));
drop table "BILANA"."BANK382";
create table "BILANA"."BANK382"(
	CODIMP varchar2(20) not null primary key,
	ZONAOPE varchar2(60),
	STATOMODLAV varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK383";
create table "BILANA"."BANK383"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB16 varchar2(60),
	STATOTAB72 varchar2(60),
	STATOTAB40 varchar2(60),
	STATOTAB05 varchar2(60));
drop table "BILANA"."BANK384";
create table "BILANA"."BANK384"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	CODCCIA varchar2(60),
	STATONOR varchar2(60));
drop table "BILANA"."BANK385";
create table "BILANA"."BANK385"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB70 varchar2(60),
	FLAGCBBANCHE varchar2(60),
	ATECO007 varchar2(60),
	STATORIC varchar2(60));
drop table "BILANA"."BANK386";
create table "BILANA"."BANK386"(
	CODIMP varchar2(20) not null primary key,
	STATOCOMPCAP varchar2(60),
	RAMO varchar2(60),
	NATURA varchar2(60),
	STATOANAATT varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK387";
create table "BILANA"."BANK387"(
	CODIMP varchar2(20) not null primary key,
	ATECO002 varchar2(60),
	DENOMSTA varchar2(60),
	STATOTAB72 varchar2(60),
	STATORIC varchar2(60));
drop table "BILANA"."BANK388";
create table "BILANA"."BANK388"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	STATOTAB70 varchar2(60),
	STATOTAB05 varchar2(60),
	REGOPE varchar2(60),
	CODBANCA varchar2(60));
drop table "BILANA"."BANK389";
create table "BILANA"."BANK389"(
	CODIMP varchar2(20) not null primary key,
	STRUTBIL varchar2(60),
	STATOGENTAB varchar2(60),
	STATOANAVALSCORT varchar2(60));
drop table "BILANA"."BANK390";
create table "BILANA"."BANK390"(
	CODIMP varchar2(20) not null primary key,
	RAMO varchar2(60),
	FORMGIU varchar2(60),
	STATOANA varchar2(60));
drop table "BILANA"."BANK391";
create table "BILANA"."BANK391"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	STATOANAOCC varchar2(60),
	STATOTAB20 varchar2(60),
	STATOTAB16 varchar2(60));
drop table "BILANA"."BANK392";
create table "BILANA"."BANK392"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	DURLEG varchar2(60),
	CABOPE varchar2(60),
	STATOTAB80 varchar2(60));
drop table "BILANA"."BANK393";
create table "BILANA"."BANK393"(
	CODIMP varchar2(20) not null primary key,
	TIPOBIL varchar2(60),
	CODDIP0 varchar2(60),
	STATOTAB19 varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK394";
create table "BILANA"."BANK394"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	RAMO varchar2(60),
	CABOPE varchar2(60),
	MODRIL varchar2(60),
	FORMGIU varchar2(60));
drop table "BILANA"."BANK395";
create table "BILANA"."BANK395"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	STATOTAB71 varchar2(60),
	STATOTAB19 varchar2(60),
	CODOPE varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK396";
create table "BILANA"."BANK396"(
	CODIMP varchar2(20) not null primary key,
	STATOANAOCC varchar2(60),
	FLAGD varchar2(60),
	RAMO varchar2(60),
	STATOTAB45 varchar2(60));
drop table "BILANA"."BANK397";
create table "BILANA"."BANK397"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB45 varchar2(60),
	FLAGCBBANCHE varchar2(60),
	DATAINS varchar2(60),
	FLAGD varchar2(60));
drop table "BILANA"."BANK398";
create table "BILANA"."BANK398"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB60 varchar2(60),
	STATOANAREVIS varchar2(60));
drop table "BILANA"."BANK399";
create table "BILANA"."BANK399"(
	CODIMP varchar2(20) not null primary key,
	REGLEG varchar2(60),
	FLAGINF varchar2(60));
drop table "BILANA"."BANK400";
create table "BILANA"."BANK400"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	REGLEG varchar2(60));
drop table "BILANA"."BANK401";
create table "BILANA"."BANK401"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	STATOTAB70 varchar2(60));
drop table "BILANA"."BANK402";
create table "BILANA"."BANK402"(
	CODIMP varchar2(20) not null primary key,
	FLAGD varchar2(60),
	STATOTAB40 varchar2(60),
	STATOTAB55 varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK403";
create table "BILANA"."BANK403"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	RAMO varchar2(60),
	FLAGINV varchar2(60),
	CARBIL varchar2(60));
drop table "BILANA"."BANK404";
create table "BILANA"."BANK404"(
	CODIMP varchar2(20) not null primary key,
	FLAGD varchar2(60),
	STATOANA varchar2(60));
drop table "BILANA"."BANK405";
create table "BILANA"."BANK405"(
	CODIMP varchar2(20) not null primary key,
	DATAINS varchar2(60),
	STATOTAB75 varchar2(60),
	STATOGENTAB varchar2(60),
	STATORIL varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK406";
create table "BILANA"."BANK406"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	STATOANAATT varchar2(60),
	REGOPE varchar2(60),
	ZONALEG varchar2(60));
drop table "BILANA"."BANK407";
create table "BILANA"."BANK407"(
	CODIMP varchar2(20) not null primary key,
	STATOGENTAB varchar2(60),
	STATOTAB60 varchar2(60),
	FLAGINF varchar2(60),
	LIREEURO varchar2(60),
	ATECO007 varchar2(60));
drop table "BILANA"."BANK408";
create table "BILANA"."BANK408"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	DATAINVIO varchar2(60),
	DATAAMM varchar2(60));
drop table "BILANA"."BANK409";
create table "BILANA"."BANK409"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB16 varchar2(60),
	FLAGINF varchar2(60),
	TIPOCONT varchar2(60));
drop table "BILANA"."BANK410";
create table "BILANA"."BANK410"(
	CODIMP varchar2(20) not null primary key,
	DATAINS varchar2(60),
	PROVLEG varchar2(60),
	STATOTAB05 varchar2(60),
	STATOTAB30 varchar2(60));
drop table "BILANA"."BANK411";
create table "BILANA"."BANK411"(
	CODIMP varchar2(20) not null primary key,
	STATOANAREVIS varchar2(60),
	STATOTAB40 varchar2(60),
	CODOPE varchar2(60),
	DATABIL varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK412";
create table "BILANA"."BANK412"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	TIPOBIL varchar2(60),
	STATORIL varchar2(60));
drop table "BILANA"."BANK413";
create table "BILANA"."BANK413"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK357"(CODIMP),
	STRUTBIL varchar2(60),
	PROVLEG varchar2(60),
	STATOTAB19 varchar2(60));
drop table "BILANA"."BANK414";
create table "BILANA"."BANK414"(
	CODIMP varchar2(20) not null primary key,
	DATAINVIO varchar2(60),
	TIPOSOGG varchar2(60),
	RAMO varchar2(60),
	CODBANCA varchar2(60));
drop table "BILANA"."BANK415";
create table "BILANA"."BANK415"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB35 varchar2(60),
	DATAINVIO varchar2(60),
	STATOTAB71 varchar2(60),
	FLAGINF varchar2(60),
	STATOTAB16 varchar2(60));
drop table "BILANA"."BANK416";
create table "BILANA"."BANK416"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB45 varchar2(60),
	RAMO varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK417";
create table "BILANA"."BANK417"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB40 varchar2(60),
	CODBANCA varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK418";
create table "BILANA"."BANK418"(
	CODIMP varchar2(20) not null primary key,
	FLAGCBBANCHE varchar2(60),
	STATOPATDED varchar2(60),
	STATOANA varchar2(60));
drop table "BILANA"."BANK419";
create table "BILANA"."BANK419"(
	CODIMP varchar2(20) not null primary key,
	FLAGCBBANCHE varchar2(60),
	CABOPE varchar2(60),
	DATABIL varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK420";
create table "BILANA"."BANK420"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB62 varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK421";
create table "BILANA"."BANK421"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	STATOTAB45 varchar2(60),
	STATONOR varchar2(60));
drop table "BILANA"."BANK422";
create table "BILANA"."BANK422"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	STATOTAB45 varchar2(60),
	STATOTAB71 varchar2(60),
	TIPOBIL varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK423";
create table "BILANA"."BANK423"(
	CODIMP varchar2(20) not null primary key,
	STRUTBIL varchar2(60),
	REGLEG varchar2(60));
drop table "BILANA"."BANK424";
create table "BILANA"."BANK424"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	CABOPE varchar2(60),
	TIPOCONT varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK425";
create table "BILANA"."BANK425"(
	CODIMP varchar2(20) not null primary key,
	DURLEG varchar2(60),
	STATOTAB50 varchar2(60),
	STATOMODLAV varchar2(60),
	STATOTAB70 varchar2(60));
drop table "BILANA"."BANK426";
create table "BILANA"."BANK426"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK317"(CODIMP),
	STATOTAB62 varchar2(60),
	STATORIC varchar2(60),
	SCHEMARICL varchar2(60));
drop table "BILANA"."BANK427";
create table "BILANA"."BANK427"(
	CODIMP varchar2(20) not null primary key,
	DURLEG varchar2(60),
	STATOTAB30 varchar2(60),
	NATURA varchar2(60),
	CODBANCA varchar2(60),
	LIREEURO varchar2(60));
drop table "BILANA"."BANK428";
create table "BILANA"."BANK428"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	STATOANAPRINC varchar2(60),
	ZONALEG varchar2(60));
drop table "BILANA"."BANK429";
create table "BILANA"."BANK429"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB60 varchar2(60),
	STATOTAB50 varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK430";
create table "BILANA"."BANK430"(
	CODIMP varchar2(20) not null primary key,
	DATAINVIO varchar2(60),
	DUROPE varchar2(60),
	STATOPATDED varchar2(60),
	CODBANCA varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK431";
create table "BILANA"."BANK431"(
	CODIMP varchar2(20) not null primary key,
	FLAGD varchar2(60),
	STATOTAB19 varchar2(60));
drop table "BILANA"."BANK432";
create table "BILANA"."BANK432"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	REGLEG varchar2(60),
	CODDIP0 varchar2(60),
	REGOPE varchar2(60),
	STATOTAB70 varchar2(60));
drop table "BILANA"."BANK433";
create table "BILANA"."BANK433"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB75 varchar2(60),
	DATABIL varchar2(60));
drop table "BILANA"."BANK434";
create table "BILANA"."BANK434"(
	CODIMP varchar2(20) not null primary key,
	DATAINVIO varchar2(60),
	SETTORE varchar2(60),
	STATOPATDED varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK435";
create table "BILANA"."BANK435"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	STATOGENTAB varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK436";
create table "BILANA"."BANK436"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	CODDIP0 varchar2(60),
	LIREEURO varchar2(60));
drop table "BILANA"."BANK437";
create table "BILANA"."BANK437"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB70 varchar2(60),
	STATOTAB10 varchar2(60));
drop table "BILANA"."BANK438";
create table "BILANA"."BANK438"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	STATOTAB45 varchar2(60),
	LIREEURO varchar2(60),
	STATOANAVALSCORT varchar2(60));
drop table "BILANA"."BANK439";
create table "BILANA"."BANK439"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB16 varchar2(60),
	MODRIL varchar2(60),
	FORMGIU varchar2(60),
	CODOPE varchar2(60));
drop table "BILANA"."BANK440";
create table "BILANA"."BANK440"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB62 varchar2(60),
	STATOALTRICRITVAL varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK441";
create table "BILANA"."BANK441"(
	CODIMP varchar2(20) not null primary key,
	DATARIC varchar2(60),
	STRUTBIL varchar2(60),
	STATOALTRICRITVAL varchar2(60),
	SCHEMARICL varchar2(60));
drop table "BILANA"."BANK442";
create table "BILANA"."BANK442"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB45 varchar2(60),
	CODCCIA varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK443";
create table "BILANA"."BANK443"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	DATAINS varchar2(60),
	CODDIP0 varchar2(60),
	STATOANA varchar2(60));
drop table "BILANA"."BANK444";
create table "BILANA"."BANK444"(
	CODIMP varchar2(20) not null primary key,
	FLAGINF varchar2(60),
	STATOTAB45 varchar2(60),
	STATOTAB10 varchar2(60),
	REGLEG varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK445";
create table "BILANA"."BANK445"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK316"(CODIMP),
	DENOMSTA varchar2(60),
	STATOTAB40 varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK446";
create table "BILANA"."BANK446"(
	CODIMP varchar2(20) not null primary key,
	PROVLEG varchar2(60),
	CODCCIA varchar2(60),
	TIPOCONT varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK447";
create table "BILANA"."BANK447"(
	CODIMP varchar2(20) not null primary key,
	STATOCOMPCAP varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK448";
create table "BILANA"."BANK448"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB71 varchar2(60),
	STATOTAB45 varchar2(60),
	NATURA varchar2(60),
	STATOTAB55 varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK449";
create table "BILANA"."BANK449"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK191"(CODIMP),
	STATOANAOCC varchar2(60),
	FLAGCBBANCHE varchar2(60),
	CODBANCA varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK450";
create table "BILANA"."BANK450"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB62 varchar2(60),
	FORMGIU varchar2(60),
	FLAGD varchar2(60),
	STATOTAB40 varchar2(60),
	STATOMODLAV varchar2(60));
drop table "BILANA"."BANK451";
create table "BILANA"."BANK451"(
	CODIMP varchar2(20) not null primary key,
	ATECO002 varchar2(60),
	FLAGINF varchar2(60),
	TIPOSOGG varchar2(60),
	PROVLEG varchar2(60),
	STATOTAB20 varchar2(60));
drop table "BILANA"."BANK452";
create table "BILANA"."BANK452"(
	CODIMP varchar2(20) not null primary key,
	DATARIC varchar2(60),
	FLAGCBBANCHE varchar2(60));
drop table "BILANA"."BANK453";
create table "BILANA"."BANK453"(
	CODIMP varchar2(20) not null primary key,
	STATOANAOCC varchar2(60),
	DATAINS varchar2(60),
	MODRIL varchar2(60),
	STATOANAREVIS varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK454";
create table "BILANA"."BANK454"(
	CODIMP varchar2(20) not null primary key,
	DATAINS varchar2(60),
	NATURA varchar2(60),
	LIREEURO varchar2(60));
drop table "BILANA"."BANK455";
create table "BILANA"."BANK455"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB70 varchar2(60),
	STATOTAB15 varchar2(60),
	STATOALTRICRITVAL varchar2(60));
drop table "BILANA"."BANK456";
create table "BILANA"."BANK456"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	STATOTAB45 varchar2(60),
	STATOANAOCC varchar2(60),
	DATARIC varchar2(60));
drop table "BILANA"."BANK457";
create table "BILANA"."BANK457"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARICL varchar2(60),
	ATECO007 varchar2(60));
drop table "BILANA"."BANK458";
create table "BILANA"."BANK458"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	CODISTAT varchar2(60));
drop table "BILANA"."BANK459";
create table "BILANA"."BANK459"(
	CODIMP varchar2(20) not null primary key,
	FORMGIU varchar2(60),
	ZONAOPE varchar2(60),
	TIPOBIL varchar2(60),
	CODBANCA varchar2(60),
	STATOTAB10 varchar2(60));
drop table "BILANA"."BANK460";
create table "BILANA"."BANK460"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	STATOANAATT varchar2(60),
	STATONOR varchar2(60));
drop table "BILANA"."BANK461";
create table "BILANA"."BANK461"(
	CODIMP varchar2(20) not null primary key,
	STATOANAOCC varchar2(60),
	ZONALEG varchar2(60),
	CODCCIA varchar2(60));
drop table "BILANA"."BANK462";
create table "BILANA"."BANK462"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB60 varchar2(60),
	CARBIL varchar2(60));
drop table "BILANA"."BANK463";
create table "BILANA"."BANK463"(
	CODIMP varchar2(20) not null primary key,
	CODISTAT varchar2(60),
	RAMO varchar2(60),
	DENOMSTA varchar2(60));
drop table "BILANA"."BANK464";
create table "BILANA"."BANK464"(
	CODIMP varchar2(20) not null primary key,
	STATOMODLAV varchar2(60),
	CODBANCA varchar2(60));
drop table "BILANA"."BANK465";
create table "BILANA"."BANK465"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARICL varchar2(60),
	RAMO varchar2(60),
	REGOPE varchar2(60),
	DATARIC varchar2(60));
drop table "BILANA"."BANK466";
create table "BILANA"."BANK466"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	FLAGD varchar2(60),
	MODRIL varchar2(60),
	FLAGINF varchar2(60),
	TIPOCONT varchar2(60));
drop table "BILANA"."BANK467";
create table "BILANA"."BANK467"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK117"(CODIMP),
	REGOPE varchar2(60),
	STATOTAB18 varchar2(60));
drop table "BILANA"."BANK468";
create table "BILANA"."BANK468"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB70 varchar2(60),
	SCHEMARIL varchar2(60),
	PROVLEG varchar2(60),
	STATOANAREVIS varchar2(60));
drop table "BILANA"."BANK469";
create table "BILANA"."BANK469"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARICL varchar2(60),
	DURLEG varchar2(60),
	STRUTBIL varchar2(60),
	STATONOR varchar2(60),
	STATOTAB16 varchar2(60));
drop table "BILANA"."BANK470";
create table "BILANA"."BANK470"(
	CODIMP varchar2(20) not null primary key,
	SETTORE varchar2(60),
	FLAGINF varchar2(60),
	STATOANAATT varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK471";
create table "BILANA"."BANK471"(
	CODIMP varchar2(20) not null primary key,
	STATOPATDED varchar2(60),
	STATOTAB05 varchar2(60));
drop table "BILANA"."BANK472";
create table "BILANA"."BANK472"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK445"(CODIMP),
	STATOTAB62 varchar2(60),
	STATOTAB80 varchar2(60),
	STATOTAB15 varchar2(60),
	STATOTAB72 varchar2(60),
	LIREEURO varchar2(60));
drop table "BILANA"."BANK473";
create table "BILANA"."BANK473"(
	CODIMP varchar2(20) not null primary key,
	STATOALTRICRITVAL varchar2(60),
	TIPOCONT varchar2(60),
	ZONAOPE varchar2(60));
drop table "BILANA"."BANK474";
create table "BILANA"."BANK474"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARICL varchar2(60),
	PROVLEG varchar2(60));
drop table "BILANA"."BANK475";
create table "BILANA"."BANK475"(
	CODIMP varchar2(20) not null primary key,
	SETTORE varchar2(60),
	STATOPATDED varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK476";
create table "BILANA"."BANK476"(
	CODIMP varchar2(20) not null primary key,
	FLAGINV varchar2(60),
	STATOTAB75 varchar2(60));
drop table "BILANA"."BANK477";
create table "BILANA"."BANK477"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	DURLEG varchar2(60),
	FLAGINF varchar2(60),
	STATOTAB05 varchar2(60),
	STATOANA varchar2(60));
drop table "BILANA"."BANK478";
create table "BILANA"."BANK478"(
	CODIMP varchar2(20) not null primary key,
	DENOMSTA varchar2(60),
	RAMO varchar2(60),
	CODOPE varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK479";
create table "BILANA"."BANK479"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB80 varchar2(60),
	STATOTAB15 varchar2(60),
	RAMO varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK480";
create table "BILANA"."BANK480"(
	CODIMP varchar2(20) not null primary key,
	REGLEG varchar2(60),
	STATOTAB19 varchar2(60));
drop table "BILANA"."BANK481";
create table "BILANA"."BANK481"(
	CODIMP varchar2(20) not null primary key,
	RAMO varchar2(60),
	LIREEURO varchar2(60));
drop table "BILANA"."BANK482";
create table "BILANA"."BANK482"(
	CODIMP varchar2(20) not null primary key,
	STATOCOMPCAP varchar2(60),
	CABLEG varchar2(60),
	STATOTAB60 varchar2(60),
	ZONALEG varchar2(60),
	STATOANAVALSCORT varchar2(60));
drop table "BILANA"."BANK483";
create table "BILANA"."BANK483"(
	CODIMP varchar2(20) not null primary key,
	NUMPATDED varchar2(60),
	FLAGD varchar2(60),
	STATOALTRICRITVAL varchar2(60),
	DUROPE varchar2(60));
drop table "BILANA"."BANK484";
create table "BILANA"."BANK484"(
	CODIMP varchar2(20) not null primary key,
	DATAINVIO varchar2(60),
	NATURA varchar2(60),
	STATOTAB31 varchar2(60));
drop table "BILANA"."BANK485";
create table "BILANA"."BANK485"(
	CODIMP varchar2(20) not null primary key,
	STATORIC varchar2(60),
	DATAUPDT varchar2(60));
drop table "BILANA"."BANK486";
create table "BILANA"."BANK486"(
	CODIMP varchar2(20) not null primary key,
	SCHEMARICL varchar2(60),
	STRUTBIL varchar2(60),
	LIREEURO varchar2(60));
drop table "BILANA"."BANK487";
create table "BILANA"."BANK487"(
	CODIMP varchar2(20) not null primary key,
	STATOANAPRINC varchar2(60),
	STATOTAB60 varchar2(60),
	PROVLEG varchar2(60),
	LIREEURO varchar2(60),
	CODOPE varchar2(60));
drop table "BILANA"."BANK488";
create table "BILANA"."BANK488"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK191"(CODIMP),
	DATAAMM varchar2(60),
	FORMGIU varchar2(60));
drop table "BILANA"."BANK489";
create table "BILANA"."BANK489"(
	CODIMP varchar2(20) not null primary key,
	PROVOPE varchar2(60),
	STATOMODLAV varchar2(60),
	CARBIL varchar2(60));
drop table "BILANA"."BANK490";
create table "BILANA"."BANK490"(
	CODIMP varchar2(20) not null primary key,
	STATOGENTAB varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK491";
create table "BILANA"."BANK491"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB45 varchar2(60),
	PROVOPE varchar2(60),
	STATOGENTAB varchar2(60),
	STATOTAB19 varchar2(60),
	STATOANAATT varchar2(60));
drop table "BILANA"."BANK492";
create table "BILANA"."BANK492"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK185"(CODIMP),
	CABLEG varchar2(60),
	DATARIC varchar2(60),
	STATOTAB15 varchar2(60),
	STATOPATDED varchar2(60),
	DENOMSTA varchar2(60));
drop table "BILANA"."BANK493";
create table "BILANA"."BANK493"(
	CODIMP varchar2(20) not null primary key,
	STATOANAREVIS varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK494";
create table "BILANA"."BANK494"(
	CODIMP varchar2(20) not null primary key,
	NATURA varchar2(60),
	REGOPE varchar2(60));
drop table "BILANA"."BANK495";
create table "BILANA"."BANK495"(
	CODIMP varchar2(20) not null primary key,
	DATAAMM varchar2(60),
	STATOANAVALSCORT varchar2(60),
	STATOTAB30 varchar2(60),
	STATORIL varchar2(60),
	CODDIP varchar2(60));
drop table "BILANA"."BANK496";
create table "BILANA"."BANK496"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK159"(CODIMP),
	ATECO002 varchar2(60),
	MODRIL varchar2(60),
	STATOANA varchar2(60),
	NUMPATDED varchar2(60));
drop table "BILANA"."BANK497";
create table "BILANA"."BANK497"(
	CODIMP varchar2(20) not null primary key,
	CABOPE varchar2(60),
	FORMGIU varchar2(60),
	STATOTAB65 varchar2(60));
drop table "BILANA"."BANK498";
create table "BILANA"."BANK498"(
	CODIMP varchar2(20) not null primary key references "BILANA"."BANK161"(CODIMP),
	STATOCOMPCAP varchar2(60),
	ZONAOPE varchar2(60),
	STATOTAB65 varchar2(60),
	ZONALEG varchar2(60),
	CARBIL varchar2(60));
drop table "BILANA"."BANK499";
create table "BILANA"."BANK499"(
	CODIMP varchar2(20) not null primary key,
	STATOTAB62 varchar2(60),
	TIPOBIL varchar2(60),
	STATOTAB30 varchar2(60),
	STATOTAB20 varchar2(60));
