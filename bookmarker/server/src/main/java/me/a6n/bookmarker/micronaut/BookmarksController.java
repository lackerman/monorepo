package me.a6n.bookmarker.micronaut;

import io.micronaut.core.annotation.Introspected;
import io.micronaut.http.HttpResponse;
import io.micronaut.http.annotation.*;
import me.a6n.bookmarker.bookmarks.Bookmark;
import me.a6n.bookmarker.bookmarks.BookmarkRepository;

import javax.inject.Inject;
import java.net.MalformedURLException;

@Controller("/bookmarks")
public class BookmarksController {
    private final BookmarkRepository repository;
    private final BookmarkExtractor extractor;

    @Inject
    public BookmarksController(BookmarkRepository repository, BookmarkExtractor extractor) {
        this.repository = repository;
        this.extractor = extractor;
    }

    @Get(produces = "application/json")
    public Iterable<Bookmark> all() {
        return repository.findAll();
    }

    @Post(consumes = "application/json", produces = "application/json")
    public HttpResponse<Bookmark> add(AddBookmark addBookmark) {
        Bookmark bookmark = extractor.extract(addBookmark.url).blockingSingle();
        repository.save(bookmark);
        return HttpResponse.created(bookmark);
    }

    @Delete("/{bookmarkId}")
    public HttpResponse<Void> delete(@PathVariable Long bookmarkId) {
        repository.deleteById(bookmarkId);
        return HttpResponse.ok();
    }

    @Introspected
    public static class AddBookmark {
        private String url;

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }
    }
}
