create schema if not exists public;
-- Clean up here
drop materialized view if exists public.calc_vertrag;
drop table if exists public.vertrag;

create table public.vertrag(
    id varchar(36),
    created_by varchar(255),
    created_date timestamp,
    last_modified_by varchar(255),
    last_modified_date timestamp,
    version bigint,
    BESTAND_VOM date,
    VER_STATUSEV varchar(255),
    OFK_KZ_GRUNDDECKUNG boolean,
    VER_TARIFVARIANTE varchar(255),
    VER_TARIF_VERSION integer,
    VER_HAUSTARIF varchar(255),
    GKF_DAT_ANFOR_AE date,
    GKF_DAT_ANFOR_ERSATZ date,
    GKF_DAT_ANFOR_NEU date,
    GKF_DAT_ANFOR_TVAR date,
    GKF_DAT_ANF_NEU_VERT date,
    VER_KZ_AUSLANDSCHUTZ boolean,
    GKF_KZ_UMS_RECHNEN boolean,
    GKF_INHALTSVERS boolean,
    GKF_INHALT_WERT_GRP integer,
    GKF_KZ_WERTMINDERUNG boolean,
    OFK_GRP_ANBAU varchar(255),
    GKF_BEKLEIDUNGSCHUTZ boolean,
    GKF_KZ_GAP boolean,
    OFK_VERW_ZWECK varchar(255),
    VER_SCHLVERTRAG varchar(255),
    VER_BEITRWFEV decimal,
    AGENTUR_RABATT integer,
    REGIONAL_DIREKTION_RABATT integer,
    calc_relevant_fuer_berechnung boolean,
    calc_tarifbeitrag decimal,
    temp_bausteinbeitrag decimal,
    temp_rabattierter_beitrag decimal
);
