package me.a6n.bookmarker.micronaut;

import io.micronaut.http.HttpRequest;
import io.micronaut.http.annotation.Get;
import io.micronaut.http.client.HttpClient;
import io.micronaut.http.client.annotation.Client;
import jakarta.inject.Inject;
import me.a6n.bookmarker.bookmarks.Bookmark;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import java.net.MalformedURLException;
import java.net.URL;

public class BookmarkExtractor {

    private final HttpClient httpClient;

    @Inject
    public BookmarkExtractor(@Client HttpClient httpClient) {
        this.httpClient = httpClient;
    }

    @Get
    public Bookmark extract(String url) {
        var request = HttpRequest.GET(url).header("User-Agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1");
        request.getHeaders().forEach(System.out::println);
        String body = httpClient.toBlocking().retrieve(request, String.class);
        Document document = Jsoup.parse(body);
        System.out.println(body);
        var bookmark = new Bookmark();
        try {
            bookmark.setUrl(new URL(url));
        } catch (MalformedURLException e) {
            throw new IllegalArgumentException("Malformed bookmark URL: " + url, e);
        }
        bookmark.setTitle(getTitle(document));
        bookmark.setDescription(getAbstract(document));
        return bookmark;
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
