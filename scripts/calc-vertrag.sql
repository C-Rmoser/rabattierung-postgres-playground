CREATE materialized VIEW calc_vertrag AS
    SELECT v.ID, VER_STATUSEV, OFK_KZ_GRUNDDECKUNG, VER_TARIFVARIANTE, VER_TARIF_VERSION,
    VER_HAUSTARIF, v.BESTAND_VOM, vh.bestand_vom AS BESTAND_VOM_VORJAHR, vh2.bestand_vom as bestand_dezember, vh.agentur_rabatt AS agentur_rabatt_vorjahr, vh.regional_direktion_rabatt AS regional_direktion_rabatt_vorjahr,
        CASE
            -- Datensätze mit Status stillgelegt
            WHEN VER_STATUSEV = 10 THEN false
            -- Verträge mit Haustarif
            WHEN VER_HAUSTARIF = 0 THEN false
            -- Alte Tarife mit Kompaktdeckung
            WHEN OFK_KZ_GRUNDDECKUNG = true AND VER_TARIFVARIANTE::decimal < 98 THEN false
            WHEN OFK_KZ_GRUNDDECKUNG = true AND (VER_TARIFVARIANTE::decimal = 98 OR VER_TARIFVARIANTE::decimal = 99) AND VER_TARIF_VERSION < 3 THEN false
            -- Datensätze ohne Anfassung im letzten Jahr
            WHEN GKF_DAT_ANFOR_AE <= (v.BESTAND_VOM - INTERVAL '1 year') AND
                GKF_DAT_ANFOR_ERSATZ <= (v.BESTAND_VOM - INTERVAL '1 year') AND
                GKF_DAT_ANFOR_NEU <= (v.BESTAND_VOM - INTERVAL '1 year') AND
                GKF_DAT_ANFOR_TVAR <= (v.BESTAND_VOM - INTERVAL '1 year') AND
                GKF_DAT_ANF_NEU_VERT <= (v.BESTAND_VOM - INTERVAL '1 year') THEN false
            -- Rabattänderungen ohne Agenturrabatt-Änderung 
            -- Rabattaenderung ist die einzige Anfassung im letzten Jahr
             WHEN GKF_DAT_ANFOR_AE > (v.BESTAND_VOM - INTERVAL '1 year') AND
                 GKF_DAT_ANFOR_ERSATZ <= (v.BESTAND_VOM - INTERVAL '1 year') AND
                 GKF_DAT_ANFOR_NEU <= (v.BESTAND_VOM - INTERVAL '1 year') AND
                 GKF_DAT_ANFOR_TVAR <= (v.BESTAND_VOM - INTERVAL '1 year') AND
                 GKF_DAT_ANF_NEU_VERT <= (v.BESTAND_VOM - INTERVAL '1 year') THEN
                 CASE
                    WHEN v.agentur_rabatt = vh.agentur_rabatt and v.REGIONAL_DIREKTION_RABATT = vh2.regional_direktion_rabatt THEN false
                    ELSE true
                 END
            -- Rabattänderungen ohne Agenturrabatt-Änderung 
            -- (d.h. Agenturrabatt = Agenturrabatt Vorjahr (BestandVom – 1 Jahr)) und mit RD-Rabatt-Änderung im letzten Kalenderjahr aber ohne RD-Rabatt-Änderung im laufenden Kalenderjahr (d.h. RD-Rabatt = RD-Rabatt 31.12. des Vorjahres)
            -- Alle restlichen Verträge sind für die Berechnung relevant
            ELSE true
        END AS RELEVANT
FROM public.vertrag AS v
LEFT JOIN public.vertrag_historie AS vh ON vh.vertrag_id = v.id AND 
(vh.bestand_vom = v.BESTAND_VOM - INTERVAL '1 year')
LEFT JOIN public.vertrag_historie AS vh2 ON vh2.vertrag_id = v.id AND 
(vh2.bestand_vom = DATE_TRUNC('year', v.bestand_vom) - INTERVAL '1 day');
