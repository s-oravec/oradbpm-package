create or replace view blog_topic as
select distinct topic
  from blog_t_message
 order by 1
with read only
;