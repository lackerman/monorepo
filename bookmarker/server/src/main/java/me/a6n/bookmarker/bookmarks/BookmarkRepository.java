package me.a6n.bookmarker.bookmarks;

import io.micronaut.data.jdbc.annotation.JdbcRepository;
import io.micronaut.data.repository.CrudRepository;

@JdbcRepository
public abstract class BookmarkRepository implements CrudRepository<Bookmark, Long> {
}
