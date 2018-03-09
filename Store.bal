import ballerina.net.http;

struct Product {
    int id;
    string name;
    float price;
}

struct Order {
    int id;
    float total;
    boolean processed = false;
    Product[] products;
}

@http:configuration {
    port:9090
}
service<http> StoreService {
    resource processOrder (http:Connection conn, http:InRequest req) {
        map qParams = req.getQueryParams();
        var sId, _ = (string) qParams["orderId"];
        var orderId, _ = <int> sId;
        var o, _ = <json> getOrder(orderId);
        http:OutResponse res = {};
        res.setJsonPayload(o);
        _ = conn.respond(res);
    }
}

function getOrder (int orderId) (Order) {
    endpoint<http:HttpClient> httpEndpoint {
        create http:HttpClient("http://localhost:9091", {});
    }
    http:OutRequest req = {};
    http:InResponse resp = {};
    resp, _ = httpEndpoint.get("/OrderService/getOrder?orderId=" + orderId, req);
    var respJson, _ = resp.getJsonPayload();
    var order, _ = <Order> respJson;
    order["processed"] = true;

    return order;
}
