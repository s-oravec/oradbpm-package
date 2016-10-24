create or replace view blog_event as
select *
  from blog_t_message
with read only
;
