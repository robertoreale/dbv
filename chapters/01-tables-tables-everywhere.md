## Tables, Tables Everywhere

In the relational paradigm, the basic data structure is a table.

#### List all tables

[embedmd]:# (sql/list-all-tables.sql)

#### Display table index usage rates

[embedmd]:# (sql/table-index-usage-rates.sql)

#### Count number of relations for each order of magnitude

Relations are objects in the database such as tables and indexes. Tables which have both regular and TOAST pieces will be broken out into separate components.

Note: IEC prefixes are used.

[embedmd]:# (sql/count-relations-by-order-of-magnitude.sql)


<!-- vim: set fenc=utf-8 spell spl=en ts=4 sw=4 et filetype=markdown : -->
