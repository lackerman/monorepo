package me.a6n.bookmarker.bookmarks;

import io.micronaut.data.jdbc.annotation.JdbcRepository;
import io.micronaut.data.model.query.builder.sql.Dialect;
import io.micronaut.data.repository.CrudRepository;

// dialect has no default in current Micronaut Data (it used to default to
// ANSI); the app's H2 datasource needs it spelled out explicitly.
@JdbcRepository(dialect = Dialect.H2)
public abstract class BookmarkRepository implements CrudRepository<Bookmark, Long> {
}
