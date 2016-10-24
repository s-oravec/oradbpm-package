# blog - Business Event Log

subtype message_type  is varchar2(4000);
subtype message_table is table of mesage_type;
subtype topic_type    is varchar2(255);

## log

**parameters**

topic
message

## topics

**parameters**

topic_regexp

## messages

**parameters**

topic_regexp
