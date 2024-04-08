PGUSER=postgres
PGPORT=5438
PGPASSWORD=postgres
DB=rabattierung

BUILD=${CURDIR}/build.sql
SCRIPTS=${CURDIR}/scripts

CREATE=$(SCRIPTS)/create-tables.sql
INSERT=$(SCRIPTS)/insert-test-data.sql
CALC_VERTRAG=$(SCRIPTS)/calc-vertrag.sql

all: calc-vertrag
	PGPASSWORD=$(PGPASSWORD) psql -h localhost -p $(PGPORT) -U $(PGUSER) -d $(DB) -f $(BUILD)

calc-vertrag: insert-test-data
	@cat $(CALC_VERTRAG) >> $(BUILD)

insert-test-data: create
	@cat $(INSERT) >> $(BUILD)

create:
	@cat $(CREATE) >> $(BUILD)

clean:
	@rm -rf $(BUILD)
