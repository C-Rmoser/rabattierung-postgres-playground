PGUSER=postgres
PGPORT=5438
PGPASSWORD=postgres
DB=rabattierung

BUILD=${CURDIR}/build.sql
SCRIPTS=${CURDIR}/scripts

IMPORT=$(SCRIPTS)/import.sql
INSERT=$(SCRIPTS)/vertrag.sql
CALC_VERTRAG=$(SCRIPTS)/calc-vertrag.sql

all: calc-vertrag
	PGPASSWORD=$(PGPASSWORD) psql -h localhost -p $(PGPORT) -U $(PGUSER) -d $(DB) -f $(BUILD)

calc-vertrag: insert
	@cat $(CALC_VERTRAG) >> $(BUILD)

insert: import
	@cat $(INSERT) >> $(BUILD)

import:
	@cat $(IMPORT) >> $(BUILD)

clean:
	@rm -rf $(BUILD)
