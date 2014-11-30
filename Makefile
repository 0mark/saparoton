include config.mk

SRC = saparoton.c ansi.c
OBJ = ${SRC:.c=.o}

all: options saparoton

options:
	@echo build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"
	@echo

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.mk

saparoton: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f madasul saparoton ${OBJ} ${OBJ}

install:
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f saparoton ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/saparoton
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${PREFIX}/man/man1
	@sed "s/VERSION/${VERSION}/g" < saparoton.1 > ${DESTDIR}${MANPREFIX}/man1/saparoton.1

uninstall:
	rm ${DESTDIR}${PREFIX}/bin/saparoton
	rm ${DESTDIR}${MANPREFIX}/man1/saparoton.1
