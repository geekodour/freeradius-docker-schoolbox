FROM freeradius/freeradius-server:3.0.18

COPY raddb/ /etc/raddb/

RUN ln -s /etc/raddb/mods-available/sql /etc/raddb/mods-enabled/sql
