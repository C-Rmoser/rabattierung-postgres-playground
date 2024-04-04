PGUSER=postgres
PGPORT=5438
PGPASSWORD=postgres
DB=rabattierung

BUILD=${CURDIR}/build.sql
SCRIPTS=${CURDIR}/scripts

IMPORT=$(SCRIPTS)/import.sql
INSERT=$(SCRIPTS)/vertrag.sql

all: insert
	PGPASSWORD=$(PGPASSWORD) psql -h localhost -p $(PGPORT) -U $(PGUSER) -d $(DB) -f $(BUILD)

insert: import
	@cat $(INSERT) >> $(BUILD)

import:
	@cat $(IMPORT) >> $(BUILD)

clean:
	@rm -rf $(BUILD)
