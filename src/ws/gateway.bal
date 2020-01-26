import ballerina/http;
import ballerina/runtime;
import ballerina/io;

// WIP

service ClientService = @http:WebSocketServiceConfig {} service {
    resource function onText(http:WebSocketClient conn, string text, boolean finalFrame) {
        io:println(text);

        any checkManExists = conn.getAttribute("gwman");
        if checkManExists is () {
            GatewayManager _gwman = new(conn);
            conn.setAttribute("gwman", _gwman);
            checkManExists = _gwman;
        }
        GatewayManager gwman = <GatewayManager>checkManExists;

        io:StringReader sr = new(text, encoding = "UTF-8");
        json|error raw_data = sr.readJson();

        if raw_data is json {
            map<json> mapped_data = <map<json>>raw_data;
            int opcode = <int>mapped_data["op"];
            gwman.parse(opcode, mapped_data);
        }
    }
};

string _token = "";

public type GatewayManager object {
    http:WebSocketClient conn;
    string token;
    
    int seq = 0;

    public function __init(http:WebSocketClient conn) {
        self.conn = conn;
        self.token = _token;
    }

    public function parse(int opcode, map<json> data) {
        match opcode {
            HELLO => {
                self.identify();
                self.startHeartbeat(data);
            }
            DISPATCH => {
                io:println(data["t"]);
            }
            HEARTBEAT_ACK => {
                io:println("ack");
            }
        }
    }

    function send(Packet packet) {
        string dataString = packet.asJson().toJsonString();
        io:println(dataString);
        http:WebSocketError? err = self.conn->pushText(dataString);

        if err is error {
            io:println(err, packet.asJson());
        }
    }
    
    function startHeartbeat(map<json> data) {
        int interval = <int>data["d"].heartbeat_interval;
        worker heartbeater {
            while self.conn.isOpen() {
                Heartbeat packet = new(self.seq);
                self.send(packet);
                runtime:sleep(interval);
            }
        }
    }

    function identify() {
        Identify packet = new(self.token, true, 2);
        self.send(packet);
    }
};

public function startConnection(string token, string url) {
    http:WebSocketClient ws = new(url, { callbackService: ClientService, readyOnConnect: false });
    _token = token;
    http:WebSocketError? err = ws->ready();
}
