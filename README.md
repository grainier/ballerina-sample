## How to run

### With business logic tracing.

Use following .bal files.
1. APIOrder.bal
2. APIProduct.bal
3. APIStore.bal

### Only with OOTB tracing.

Use following .bal files.
1. Product.bal
2. Order.bal
3. Store.bal

## DB Queries

```sql
CREATE TABLE `testdb`.`PRODUCT` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`));

INSERT INTO `testdb`.`PRODUCT` (`name`, `price`) VALUES ("ASUS Vivo Stick PC - TS10", 25900);
INSERT INTO `testdb`.`PRODUCT` (`name`, `price`) VALUES ("DCduino Uno", 675);
INSERT INTO `testdb`.`PRODUCT` (`name`, `price`) VALUES ("Raspberry Pi 3 Model B", 8000);
INSERT INTO `testdb`.`PRODUCT` (`name`, `price`) VALUES ("Arduino Starter Kit", 3500);
INSERT INTO `testdb`.`PRODUCT` (`name`, `price`) VALUES ("HP 15-BS521TU", 61000);
INSERT INTO `testdb`.`PRODUCT` (`name`, `price`) VALUES ("Xiaomi Mi Power", 3450);

CREATE TABLE `testdb`.`ORDERS` (
  `orderId` INT NULL DEFAULT 1,
  `productId` INT NULL DEFAULT 1);

INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (1, 1);
INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (1, 2);
INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (1, 3);
INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (1, 4);
INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (2, 2);
INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (2, 5);
INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (2, 3);
INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (3, 4);
INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (3, 5);
INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (3, 6);
INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (4, 1);
INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (4, 5);
INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (4, 4);
INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (4, 5);
INSERT INTO `testdb`.`ORDERS` (`orderId`, `productId`) VALUES (4, 6);
```

## Test CURLS
0.0.0.0:9090/StoreService/processOrder?orderId=1
0.0.0.0:9091/OrderService/getOrder?orderId=1
0.0.0.0:9092/ProductService/getProduct?productId=2