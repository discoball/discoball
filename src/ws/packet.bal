public type Packet abstract object {
    map<json> data;

    public function asJson() returns json;
};


public type Identify object {
    map<json> data = {};

    public function __init(string token, boolean compress, int large_threshold) {
        self.data["op"] = IDENTIFY;
        self.data["d"] = {
            "token": token,
            "properties": {
                "$os": "Windows 10",
                "$browser": "discoball",
                "$device": "discoball",
                "$referrer": "",
                "$referring_domain": ""
            },
            "compress": compress,
            "large_threshold": large_threshold,
            "v": 3
        };
    }

    public function asJson() returns json {
        return <json>self.data;
    }
};

public type Resume object {
    map<json> data = {};

    public function __init(string token, string sequence, string session_id) {
        self.data["op"] = RESUME;
        self.data["d"] = {
            "seq": sequence,
            "session_id": session_id,
            "token": token
        };
    }

    public function asJson() returns json {
        return <json>self.data;
    }
};

public type Heartbeat object {
    map<json> data = {};

    public function __init(int seq) {
        self.data["op"] = HEARTBEAT;
        self.data["d"] = seq;
    }

    public function asJson() returns json {
        return <json>self.data;
    }
};
