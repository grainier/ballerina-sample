import ballerina.net.http;
import ballerina.observe;

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
        string parentSpanId = observe:extractSpanContext(req, "group-1");
        observe:Span span = observe:startSpan("Wallmart Store", "processOrder", {"span.kind":"server"},
                                              observe:ReferenceType.CHILDOF, parentSpanId);
        map qParams = req.getQueryParams();
        var sId, _ = (string) qParams["orderId"];
        var orderId, _ = <int> sId;
        var o, _ = <json> getOrder(orderId, span.spanId);
        http:OutResponse res = {};
        res.setJsonPayload(o);
        _ = conn.respond(res);
        span.finishSpan();
    }
}

function getOrder (int orderId, string parentSpanId) (Order) {
    endpoint<http:HttpClient> httpEndpoint {
        create http:HttpClient("http://localhost:9091", {});
    }
    observe:Span span = observe:startSpan("Wallmart Store", "getOrder", {},
                                          observe:ReferenceType.CHILDOF, parentSpanId);
    http:OutRequest req = {};
    http:InResponse resp = {};
    observe:Span childSpan = observe:startSpan("Wallmart Store", "callingOrderService", {},
                                               observe:ReferenceType.CHILDOF, span.spanId);
    req = childSpan.injectSpanContext(req, "group-1");
    resp, _ = httpEndpoint.get("/OrderService/getOrder?orderId=" + orderId, req);
    childSpan.finishSpan();
    var respJson, _ = resp.getJsonPayload();
    var order, _ = <Order> respJson;
    order["processed"] = true;
    span.finishSpan();
    return order;
}
