-- ISO 8601 UTC
function add_utc(tag, timestamp, record)
    record["utc"] = os.date("!%Y-%m-%dT%H:%M:%SZ", timestamp)
    return 2, timestamp, record
end

function add_tag(tag, timestamp, record)
    if not record then
      return -1, timestamp, record
    end

    record["tag"] = os.date("!%Y%m%d%H", timestamp)
    return 2, timestamp, record
end

-- function add_tag(tag, timestamp, record)
--     if not record then
--       return -1, timestamp, record
--     end
--     local interval = tonumber(os.getenv("TAG_INTERVAL") or "3")
--     local hostname = os.getenv("HOSTNAME")
--     local seconds = math.floor(timestamp)
--     local t = os.date("*t", seconds)
--
--     local rounded_minute = math.floor(t.min/interval)*interval+interval
--     if rounded_minute > 60 then
--       rounded_minute = rounded_minute - 60
--     end
--     local new_tag = string.format("%s_%04d%02d%02d_%02d%02d.log",hostname ,t.year, t.month, t.day, t.hour, rounded_minute)
--     local new_record = record
--     new_record["tag"] = new_tag
--     return 2, timestamp, new_record
-- end