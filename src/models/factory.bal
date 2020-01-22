# The fluent interface to provide the necessary arguments for
# TextChannel.edit.
public type TextChannelEditFactory object {
    map<json> data = {};

    public function setName(string name) returns TextChannelEditFactory {
        self.data["name"] = name;
        return self;
    }

    public function setPosition(int position) returns TextChannelEditFactory {
        self.data["position"] = position;
        return self;
    }

    public function setTopic(string topic) returns TextChannelEditFactory {
        self.data["topic"] = topic;
        return self;
    }

    public function setNSFW(boolean nsfw) returns TextChannelEditFactory {
        self.data["nsfw"] = nsfw;
        return self;
    }

    public function setRateLimitPerUser(int rateLimitPerUser) returns TextChannelEditFactory {
        self.data["rate_limit_per_user"] = rateLimitPerUser;
        return self;
    }

    public function setParentId(int parentId) returns TextChannelEditFactory {
        self.data["parent_id"] = parentId;
        return self;
    }

    public function toJson() returns json {
        return <json>self.data;
    }
};

# The fluent interface to provide the necessary arguments for
# VoiceChannel.edit.
public type VoiceChannelEditFactory object {
    map<json> data = {};

    public function setName(string name) returns VoiceChannelEditFactory {
        self.data[""] = name;        
        return self;
    }

    public function setPosition(int position) returns VoiceChannelEditFactory {
        self.data[""] = position;
        return self;
    }

    public function setBitrate(int bitrate) returns VoiceChannelEditFactory {
        self.data[""] = bitrate;
        return self;
    }

    public function setUserLimit(int userLimit) returns VoiceChannelEditFactory {        
        self.data["Limit"] = userLimit;
        return self;
    }

    public function setParentId(int parentId) returns VoiceChannelEditFactory {
        self.data["Id"] = parentId;
        return self;
    }

    public function toJson() returns json {
        return <json>self.data;
    }
};

# The fluent interface to provide the necessary arguments for
# Guild.edit.
public type GuildEditFactory object {
    map<json> data = {};

    public function setName(string name) returns GuildEditFactory {
        self.data["name"] = name;
        return self;
    }

    public function setRegion(string region) returns GuildEditFactory {
        self.data["region"] = region;
        return self;
    }

    public function setVerificationLevel(int verificationLevel) returns GuildEditFactory {
        self.data["verification_level"] = verificationLevel;
        return self;
    }

    public function setDefaultMessageNotifications(int defaultMessageNotifications) returns GuildEditFactory {
        self.data["default_message_notifications"] = defaultMessageNotifications;
        return self;
    }

    public function setExplicitContentFilter(int explicitContentFilter) returns GuildEditFactory {
        self.data["explicit_content_filter"] = explicitContentFilter;
        return self;
    }

    public function setAfkChannelId(int afkChannelId) returns GuildEditFactory {
        self.data["afk_channel_id"] = afkChannelId;
        return self;
    }

    public function setAfkTimeout(int afkTimeout) returns GuildEditFactory {
        self.data["afk_timeout"] = afkTimeout;
        return self;
    }

    public function setIcon(string icon) returns GuildEditFactory {
        self.data["icon"] = icon;
        return self;
    }

    public function setOwnerId(int ownerId) returns GuildEditFactory {
        self.data["owner_id"] = ownerId;
        return self;
    }

    public function setSplash(string splash) returns GuildEditFactory {
        self.data["splash"] = splash;
        return self;
    }

    public function setBanner(string banner) returns GuildEditFactory {
        self.data["banner"] = banner;
        return self;
    }

    public function setSystemChannelId(int systemChannelId) returns GuildEditFactory {
        self.data["system_channel_id"] = systemChannelId;
        return self;
    }

    public function toJson() returns json {
        return <json>self.data;
    }
};