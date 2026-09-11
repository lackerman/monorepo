package me.a6n.bookmarker.bookmarks;

import lombok.Data;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import java.net.URL;

@Data
@Entity
public class Bookmark {
    @Id
    @GeneratedValue
    private Long id;
    private URL url;
    private String title;
    private String description;
}
