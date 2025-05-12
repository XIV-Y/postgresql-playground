CREATE DOMAIN japanese_postal_code AS CHAR(7)
  CHECK (VALUE ~ '^[0-9]{7}$');

CREATE TABLE pg_domains (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  postal_code japanese_postal_code 
);

/**
 * 半角数値7桁の郵便番号を格納するドメイン
 */