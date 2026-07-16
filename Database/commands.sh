sql
SELECT * FROM DBA_TABLES
FETCH FIRST 10 ROWS ONLY;


sql
CREATE TABLE PRODUCTS (
  PRODUCT_ID NUMBER PRIMARY KEY,
  NAME VARCHAR2(100),
  PRICE NUMBER(10,2),
  STOCK NUMBER
);


sql
CREATE TABLE ORDERS (
  ORDER_ID NUMBER PRIMARY KEY,
  ORDER_DATE DATE,
  CUSTOMER_ID NUMBER,
  TOTAL_AMOUNT NUMBER(10,2)
);

SELECT TABLE_NAME FROM USER_TABLES;

sql
INSERT ALL
  INTO products (product_id, name, price, stock) VALUES (1, 'Widget A', 19.99, 100)
  INTO products (product_id, name, price, stock) VALUES (2, 'Widget B', 29.99, 150)
  INTO products (product_id, name, price, stock) VALUES (3, 'Widget C', 9.99, 200)
  INTO products (product_id, name, price, stock) VALUES (4, 'Widget D', 39.99, 120)
  INTO products (product_id, name, price, stock) VALUES (5, 'Widget E', 49.99, 110)
  INTO products (product_id, name, price, stock) VALUES (6, 'Widget F', 59.99, 100)
SELECT * FROM dual;


sql
SELECT (SELECT database_role FROM v$database) as database_role,host_name,database_status FROM V$INSTANCE;


