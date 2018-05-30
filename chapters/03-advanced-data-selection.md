## Advanced Data Selection

In this chapter we will discuss analytical and aggregate functions.

#### Display cache hit rates

[embedmd]:# (sql/cache-hit-rates.sql)

#### Count index blocks in cache

[embedmd]:# (sql/index-blocks-in-cache.sql)

#### Sort the object types by their average name length

By sorting the object types by the average name length of their instances, we find a metric about how *exoteric* a given object type is.

[embedmd]:# (sql/sort-object-types-by-avg-name-length.sql)

#### Rank tables based on their cardinality

We partition the result set by tablespace.

[embedmd]:# (sql/rank-tables-by-cardinality.sql)


<!-- vim: set fenc=utf-8 spell spl=en ts=4 sw=4 et filetype=markdown : -->
