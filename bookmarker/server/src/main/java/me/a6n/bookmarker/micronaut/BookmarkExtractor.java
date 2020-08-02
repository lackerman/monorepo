package me.a6n.bookmarker.micronaut;

import io.micronaut.core.type.Argument;
import io.micronaut.http.HttpRequest;
import io.micronaut.http.annotation.Get;
import io.micronaut.http.client.RxHttpClient;
import io.micronaut.http.client.annotation.Client;
import io.reactivex.Flowable;
import me.a6n.bookmarker.bookmarks.Bookmark;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import javax.inject.Inject;
import java.net.URL;

public class BookmarkExtractor {

    private final RxHttpClient httpClient;

    @Inject
    public BookmarkExtractor(@Client RxHttpClient httpClient) {
        this.httpClient = httpClient;
    }

    @Get
    public Flowable<Bookmark> extract(String url) {
        var request = HttpRequest.GET(url).header("User-Agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1");
        request.getHeaders().forEach(System.out::println);
        return httpClient
                .retrieve(request, Argument.of(String.class))
                .map((something) -> {
                    Document document = Jsoup.parse(something);
                    System.out.println(something);
                    var bookmark = new Bookmark();
                    bookmark.setUrl(new URL(url));
                    bookmark.setTitle(getTitle(document));
                    bookmark.setDescription(getAbstract(document));
                    return bookmark;
                });

    }

    private String getTitle(Document document) {
        return document.title();
    }

    private String getAbstract(Document document) {
        if (document.body().selectFirst("h1") == null) {
            return document.body().selectFirst("h1").text();
        }
        return "Not found";
    }

    private String getImage(Document document) {
        return null;
    }
}
