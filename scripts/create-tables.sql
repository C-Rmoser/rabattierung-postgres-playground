create schema if not exists public;
-- Clean up here
drop materialized view if exists public.calc_vertrag;
drop materialized view if exists public.calc_vertrag_new;
drop table if exists public.vertrag;
drop table if exists public.vertrag_historie;

CREATE TABLE public.vertrag (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    created_by VARCHAR(255),
    created_date TIMESTAMP,
    last_modified_by VARCHAR(255),
    last_modified_date TIMESTAMP,
    version BIGINT NOT NULL,
    BESTAND_VOM DATE,
    VER_STATUSEV INT,
    OFK_KZ_GRUNDDECKUNG BOOLEAN,
    VER_TARIFVARIANTE INT,
    VER_TARIF_VERSION INT,
    HERKUNFT VARCHAR(255),
    VER_HAUSTARIF INT,
    GKF_DAT_ANFOR_AE DATE,
    GKF_DAT_ANFOR_ERSATZ DATE,
    GKF_DAT_ANFOR_NEU DATE,
    GKF_DAT_ANFOR_TVAR DATE,
    GKF_DAT_ANF_NEU_VERT DATE,
    VER_KZ_AUSLANDSCHUTZ BOOLEAN,
    GKF_KZ_UMS_RECHNEN BOOLEAN,
    GKF_INHALTSVERS BOOLEAN,
    GKF_INHALT_WERT_GRP INT,
    GKF_KZ_WERTMINDERUNG BOOLEAN,
    OFK_GRP_ANBAU INT,
    GKF_BEKLEIDUNGSCHUTZ BOOLEAN,
    GKF_KZ_GAP BOOLEAN,
    OFK_VERW_ZWECK INT,
    VER_SCHLVERTRAG INT,
    VER_BEITRWFEV DECIMAL,
    AGENTUR_RABATT INT,
    REGIONAL_DIREKTION_RABATT INT,
    calc_relevant_fuer_berechnung BOOLEAN,
    calc_tarifbeitrag DECIMAL,
    temp_bausteinbeitrag DECIMAL,
    temp_rabattierter_beitrag DECIMAL
);

CREATE TABLE public.vertrag_historie (
    id BIGSERIAL PRIMARY KEY, -- serial ends at 2,147,483,647, we potentially need over 10 000 000 000 rows
    bestand_vom DATE,
    agentur_rabatt INT,
    regional_direktion_rabatt INT,
    vertrag_id VARCHAR(36) NOT NULL
);

CREATE INDEX [IF NOT EXISTS] vertrag_id_index
ON public.vertrag_historie(vertrag_id);
