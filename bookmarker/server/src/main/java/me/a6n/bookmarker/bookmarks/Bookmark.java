package me.a6n.bookmarker.bookmarks;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
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
