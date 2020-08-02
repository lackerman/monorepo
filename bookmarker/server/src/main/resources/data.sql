DROP TABLE IF EXISTS bookmark;

CREATE TABLE bookmark (
  id INT AUTO_INCREMENT  PRIMARY KEY,
  url VARCHAR(250) NOT NULL,
  title VARCHAR(250) NOT NULL,
  description VARCHAR(250) DEFAULT NULL
);

INSERT INTO bookmark (url, title, description) VALUES
  ('example.com', 'An Example', 'A long description about example');
