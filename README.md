# blog - Business Event Log

Logs Business Events - supersimple as it is just part of the example

# package

## log

log business event

**parameters**

- topic - topic in which message belongs
- message - event message

## topics

returns list of topics that match the regexp

**parameters**

- topic_regexp regexp

## events

returns list of messages since in topic that match the regexp

**parameters**

- topic_regexp regexp
- since date since default sysdate - 1 day       

# view

## blog_topic

created topics

## blog_event
 
logged events
