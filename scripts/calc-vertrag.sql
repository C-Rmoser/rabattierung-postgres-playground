drop materialized view if exists calc_vertrag;
create materialized view calc_vertrag as
    SELECT VER_STATUSEV, OFK_KZ_GRUNDDECKUNG, VER_TARIFVARIANTE, VER_TARIF_VERSION,
    VER_HAUSTARIF,
        CASE
            WHEN VER_STATUSEV = '10' THEN false
            WHEN OFK_KZ_GRUNDDECKUNG = true AND VER_TARIFVARIANTE::decimal < 98 THEN false
            WHEN OFK_KZ_GRUNDDECKUNG = true AND (VER_TARIFVARIANTE::decimal = 98 OR VER_TARIFVARIANTE::decimal = 99) AND VER_TARIF_VERSION < 3 THEN false
            WHEN VER_HAUSTARIF = '0' THEN false
            ELSE true
        END AS RELEVANT
FROM public.vertrag;
