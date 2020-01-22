import ballerina/lang.'int as ints;
import ballerina/time;

final int DISCORD_EPOCH = 1420070400000;
final time:Time UNKNOWN_TIME = { time: 0, zone: utcTimeZone };
final time:TimeZone utcTimeZone = {id: "+00:00"};

# Parses an ID from a snowflake string.
# 
# + snowflake - The snowflake string.
# + return - The snowflake as an integer.
public function parseId(string snowflake) returns int {
    int|error tryInt = ints:fromString(snowflake);
    if tryInt is int {
        return tryInt;
    }
    return 0;
}

# Parses a time from a snowflake integer.
# 
# + snowflake - The snowflake integer.
# + return - The time parsed from the integer.
public function fromSnowflake (int snowflake) returns time:Time {
    int timestamp = (snowflake >> 22) + DISCORD_EPOCH;
    return { time: timestamp, zone: utcTimeZone };
}

# Parses a time from a timestamp string.
# 
# + timestamp - An ISO8601 timestamp.
# + return - The time parsed from the timestamp.
public function fromTimestamp (string timestamp) returns time:Time {
    time:Time|error ts = time:parse(timestamp, "%Y%m$dT%H%M%S");
    if ts is time:Time {
        return ts;
    }
    return UNKNOWN_TIME;
}