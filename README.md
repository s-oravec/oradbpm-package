# blog - Business Event Log

Logs Business Events - supersimple as it is just part of the example

type varchar2_table is table of varchar2(4000);

## log

log business event

**parameters**

- topic - topic in which message belongs
- message - event message

## topics

returns list of topics that match the regexp

**parameters**

- topic_regexp regexp

## messages

returns list of messages since in topic that match the regexp

**parameters**

- topic_regexp regexp
- since date since default sysdate - 1 day       
