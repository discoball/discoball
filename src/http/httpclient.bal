import ballerina/http;

type Route object {
    public string verb; 
    public string endpoint;
    public string[] arguments;

    public function __init(string verb, string endpoint, string[] arguments=[]) {
        self.verb = verb;
        self.endpoint = endpoint;
        self.arguments = arguments;
    }
};

http:Client _http = new("https://discordapp.com/api/v6");

public type HTTPClient object {
    private string token;

    public function __init(string token) {
        self.token = token;
    }

    function request(Route route_, json body="") returns @tainted json|string|error {
        http:Request req = new;
        req.setHeader("User-Agent", "DiscordBot (https://github.com/discoball/discoball, 0.0.1a)");
        string _token = string `Bot ${self.token}`;
        req.setHeader("Authorization", _token);

        http:Response|error resp = self.makeRequest(route_, req, body);

        if resp is http:Response {
            json|string|error data = self.parseResponse(resp);
            int status = resp.statusCode;

            if 300 > status && status >= 200 {
                return data;
            } else if status == 429 {
                return data; // TODO: ratelimits
            }
        }
    }

    function makeRequest(Route route_, http:Request req, json body) returns http:Response|error {
        if route_.verb == "GET" {
            return check _http->get(route_.endpoint, req);
        } else if route_.verb == "POST" {
            return check _http->post(route_.endpoint, body);
        } else if route_.verb == "PUT" {
            req.setJsonPayload(body);
            return check _http->put(route_.endpoint, req);
        } else if route_.verb == "PATCH" {
            req.setJsonPayload(body);
            return check _http->patch(route_.endpoint, req);
        } else if route_.verb == "DELETE" {
            return check _http->delete(route_.endpoint, req);
        } else { // TODO: throw exception when incorrect route
            return check _http->get(route_.endpoint);
        }
    }

    function parseResponse(http:Response resp) returns @tainted json|string|error {
        string contentType = resp.getContentType();
        if contentType.indexOf("json") is int {
            return check resp.getJsonPayload(); // TODO: check if json or text
        } else {
            return check resp.getTextPayload();
        }
    }

    public function getChannel(int channel_id) returns @tainted json|string|error {
        string endpoint = string `/channels/${channel_id}`;
        Route route_ = new("GET", endpoint);
        return self.request(route_);
    }

    public function editChannel(int channel_id, json data) returns @tainted json|string|error {
        string endpoint = string `/channels/${channel_id}`;
        Route route_ = new("PATCH", endpoint);
        return self.request(route_, data);
    }

    public function deleteChannel(int channel_id) {
        string endpoint = string `/channels/${channel_id}`;
        Route route_ = new("DELETE", endpoint);
        var r = self.request(route_);
        return;
    }

    public function getGuild(int guild_id) returns @tainted json|string|error {
        string endpoint = string `/guilds/${guild_id}`;
        Route route_ = new("GET", endpoint);
        return self.request(route_);
    }

    public function editGuild(int guild_id, json data) returns @tainted json|string|error {
        string endpoint = string `/guilds/${guild_id}`;
        Route route_ = new("PATCH", endpoint);
        return self.request(route_, data);
    }
};
