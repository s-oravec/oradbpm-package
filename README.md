# Simple Logger

Logs to `DBMS_OUTPUT` only.

## Log levels

```sql
LOG_LEVEL_DEBUG constant varchar2 := 'D';
LOG_LEVEL_ERROR constant varchar2 := 'E';
LOG_LEVEL_INFO  constant varchar2 := 'I';
```

# log

**description:** logs message with log level

**parameters:**

- **message** - log message, with $n placeholders
- **value_1, ...** - placeholder n value - $n in message is replacede by value_n
- **log_level** - message log level - default is `LOG_LEVEL_DEBUG`

# log_debug

**description:** logs with `log_level = LOG_LEVEL_DEBUG`

# log_error

**description:** logs with `log_level = LOG_LEVEL_ERROR`

# log_info

**description:** logs with `log_level = LOG_LEVEL_INFO`
