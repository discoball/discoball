import ballerina/time;
import discoball/http;


# Represents a Discord guild.
# 
# + id - The guild ID.
# + createdAt - When the guild was created.
# + name - The guild name.
# + ownerId - The ID of the guild owner.
# + region - The name of the region.
# + afkTimeout - The timeout to get sent to the AFK voice channel.
# + preferredLocale - The preferred locale of this guild. 
public type Guild object {
    http:HTTPClient http;
    map<json> data;

    public int id;
    public time:Time createdAt;
    public string name;
    public string icon = "";
    public string splash = "";
    public int ownerId;
    // TODO: permissions
    public string region;
    public int afkChannelId = 0;
    public int afkTimeout;
    // TODO: verification_level, default_message_notifications, explicit_content_filter, mfa_level enums
    // TODO: roles, emojis, features
    public time:Time joinedAt = UNKNOWN_TIME;
    public boolean large = false;
    public boolean unavailable = false;
    public int memberCount = 0;
    // TODO: voice_states, members, channels, presences
    public int max_presences = 0;
    public int max_members = 0;
    public string vanityUrlCode = "";
    public string banner = "";
    // TODO: premium_tier
    public int premiumSubscriptionCount = 0;
    public string preferredLocale;

    public function __init(http:HTTPClient http, json data) {
        self.http = http;
        self.data = <map<json>>data;

        self.id = parseId(<string>self.data["id"]);
        self.createdAt = fromSnowflake(self.id);
        self.name = <string>self.data["name"];
        self.ownerId = parseId(<string>self.data["owner_id"]);
        self.region = <string>self.data["region"];
        self.afkTimeout = <int>self.data["afk_timeout"];
        self.preferredLocale = <string>self.data["preferred_locale"];
    }

    function _edit(json data) {
        self.__init(self.http, data);
    }

    # Edit the guild.
    # 
    # + args - The properties to change.
    #          This follows the fluent interface method.
    public function edit(GuildEditFactory args) {
        json data = args.toJson();

        json|string|error resp = self.http.editGuild(<@untainted> self.id, <@untainted> data);
        if resp is json {
            self._edit(resp);
        }
    }  
};