import ballerina/time;
import discoball/http;

type BaseChannel abstract object {
    // Base Channel Properties
    http:HTTPClient http;
    map<json> data;
    public int id;
    public int channelType;
    public time:Time createdAt;
};

public type GuildChannel abstract object {
    // Base Channel Properties
    http:HTTPClient http;
    map<json> data;
    public int id;
    int channelType;
    public time:Time createdAt;

    // Guild Channel Properties
    public int guildId;
    public int position;
    public string name;
    // TODO: add permission overwrites
    // TODO: add state (for guild and category)

    public function edit(any args);
};

# Represents a category channel in a guild.
# 
# + id - The channel ID.
# + createdAt - When the channel was created.
# + name - The name of the channel.
# + guildId - The guild ID of the channel.
# + position - The position of the channel.
public type CategoryChannel object {
    // Base Channel Properties
    http:HTTPClient http;
    map<json> data;
    public int id;
    int channelType;
    public time:Time createdAt;

    // Guild Channel Properties
    public string name;
    public int guildId;
    public int position;

    public function __init(http:HTTPClient http, json data) {
        self.http = http;
        self.data = <map<json>>data;

        self.id = parseId(<string>self.data["id"]);
        self.createdAt = fromSnowflake(self.id);

        self.channelType = <int>self.data["type"];

        self.guildId = parseId(<string>self.data["guild_id"]);
        self.position = <int>self.data["position"];
        self.name = <string>self.data["name"];
    }

    public function toString() returns string {
        return string `[CategoryChannel id=${self.id.toString()} channelType=${self.channelType} guildId=${self.guildId.toString()} position=${self.position} name="${self.name}"]`;
    }
};

# Represents a text channel in a guild.
# 
# + id - The channel ID.
# + createdAt - When the channel was created.
# + name - The name of the channel.
# + guildId - The guild ID of the channel.
# + position - The position of the channel.
# + parentId - The parent channel's ID.
# + topic - The channel topic.
# + nsfw - Whether the channel is marked as NSFW.
# + lastMessageId - The ID of last message sent in the channel.
# + rateLimitPerUser - The amount of seconds a user has to wait before sending another message.
# + lastPinTimestamp - The timestamp of the last pinned message in the channel.
public type TextChannel object {
    // Base Channel Properties
    http:HTTPClient http;
    map<json> data;
    public int id;
    int channelType;
    public time:Time createdAt;

    // Guild Channel Properties
    public string name;
    public int guildId;
    public int position;
    public int parentId;

    // Text Channel properties
    public string topic = "";
    public boolean nsfw;
    public int lastMessageId;
    public int rateLimitPerUser;
    public time:Time lastPinTimestamp = UNKNOWN_TIME;

    public function __init(http:HTTPClient http, json data) {
        self.http = http;
        self.data = <map<json>>data;

        self.id = parseId(<string>self.data["id"]);
        self.createdAt = fromSnowflake(self.id);
        
        self.channelType = <int>self.data["type"];

        self.guildId = parseId(<string>self.data["guild_id"]);
        self.position = <int>self.data["position"];
        self.name = <string>self.data["name"];
        self.parentId = parseId(<string>self.data["parent_id"]);
        
        self.nsfw = <boolean>self.data["nsfw"];
        self.lastMessageId = parseId(<string>self.data["last_message_id"]);
        self.rateLimitPerUser = <int>self.data["rate_limit_per_user"];

        // Explicit field checking
        if self.data.hasKey("last_pin_timestamp") {
            self.lastPinTimestamp = fromTimestamp(<string>self.data["last_pin_timestamp"]);
        }

        json topic = self.data["topic"];
        if topic != () {
            self.topic = <string>topic;
        }
    }

    function _edit(json data) {
        self.__init(self.http, data);
    }

    public function toString() returns string {
        return string `[TextChannel id=${self.id.toString()} channelType=${self.channelType} guildId=${self.guildId.toString()} position=${self.position} name="${self.name}" nsfw=${self.nsfw} lastMessageId=${self.lastMessageId.toString()} topic="${self.topic}"]`;
    }

    # Edit the text channel.
    # 
    # + args - The properties to change.
    #          This follows the fluent interface method.
    public function edit(TextChannelEditFactory args) {
        json data = args.toJson();

        json|string|error resp = self.http.editChannel(<@untainted> self.id, <@untainted> data);
        if resp is json {
            self._edit(resp);
        }
    }

    # Delete the text channel.
    public function delete() {
        json|string|error resp = self.http.deleteChannel(<@untainted> self.id);
    }
};

# Represents a voice channel in a guild.
# 
# + id - The channel ID.
# + createdAt - When the channel was created.
# + name - The name of the channel.
# + guildId - The guild ID of the channel.
# + position - The position of the channel.
# + parentId - The parent channel's ID.
# + bitrate - The bitrate (in bits) of the channel.
# + userLimit - The maximum users that can join the channel.
public type VoiceChannel object {
    // Base Properties
    http:HTTPClient http;
    map<json> data;
    public int id;
    int channelType;
    public time:Time createdAt;

    // Guild Channel Properties
    public string name;
    public int guildId;
    public int position;
    public int parentId;

    // Voice Channel Properties
    public int bitrate;
    public int userLimit;

    public function __init(http:HTTPClient http, json data) {
        self.http = http;
        self.data = <map<json>>data;

        self.id = parseId(<string>self.data["id"]);
        self.createdAt = fromSnowflake(self.id);
        
        self.channelType = <int>self.data["type"];

        self.guildId = parseId(<string>self.data["guild_id"]);
        self.position = <int>self.data["position"];
        self.name = <string>self.data["name"];
        self.parentId = parseId(<string>self.data["parent_id"]);

        self.bitrate = <int>self.data["bitrate"];
        self.userLimit = <int>self.data["user_limit"];
    }

    function _edit(json data) {
        self.__init(self.http, data);
    }

    # Edit the voice channel.
    # 
    # + args - The properties to change.
    #          This follows the fluent interface method.
    public function edit(VoiceChannelEditFactory args) {
        json data = args.toJson();

        json|string|error resp = self.http.editChannel(<@untainted> self.id, <@untainted> data);
        if resp is json {
            self._edit(resp);
        }
    }
};
