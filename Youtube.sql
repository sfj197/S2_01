create database youtube;
use youtube;

create table users(
user_id int not null auto_increment primary key,
email varchar(50) not null,
password varchar(30) not null,
usuaryname varchar(40) not null,
birthdate date not null,
gender enum('M','W') not null,
country varchar(40) not null,
zipcode int not null
)
engine= InnoDB
default character set = utf8mb4;

create table users_create_playlists(
user_id int not null,
playlist_id int not null,
primary key(user_id,playlist_id),
index user_id(user_id asc),
constraint fk_ucp_users
foreign key(user_id)
references users(user_id)
on delete cascade
on update cascade,
index playlist_id(playlist_id asc),
constraint fk_ucp_playlists
foreign key(playlist_id)
references playlists(playlist_id)
on update cascade
on delete cascade
)
engine= InnoDB
default character set = utf8mb4;

create table playlists(
playlist_id int not null auto_increment primary key,
name varchar(50) not null,
date date not null
)
engine= InnoDB
default character set = utf8mb4;

create table tags(
tag_id int not null auto_increment primary key,
name varchar(50) not null,
video_id int not null,
index video_id(video_id asc),
constraint fk_tags_videos
foreign key(video_id)
references videos(video_id)
on delete no action
on update no action
)
engine= InnoDB
default character set = utf8mb4;

create table videos_has_tags(
video_id int not null,
tag_id int not null,
primary key(video_id,tag_id),
index video_id(video_id asc),
constraint fk_vht_videos
foreign key (video_id)
references videos(video_id)
on delete cascade
on update cascade,
index tag_id(tag_id),
constraint fk_vht_tags
foreign key (tag_id)
references tags(tag_id)
on delete cascade
on update cascade
)
engine= InnoDB
default character set = utf8mb4;

create table videos(
video_id int not null auto_increment primary key,
title varchar(70) not null,
description text,
size int not null,
name varchar(50) not null,
length time not null,
thumbnail blob,
reproductions int not null,
likes int not null,
dislikes int not null,
state enum('public','hidden','privat') not null,
date datetime not null,
user_id int not null,
index user_id(user_id asc),
constraint fk_videos_users
foreign key(user_id)
references users(user_id)
on delete cascade
on update cascade
)
engine= InnoDB
default character set = utf8mb4;

create table likes_dislikes(
user_id int not null,
video_id int not null,
date datetime not null,
type enum('like','dislike'),
index user_id(user_id asc),
constraint fk_ld_user
foreign key(user_id)
references users(user_id)
on update cascade
on delete cascade,
index video_id(video_id asc),
constraint fk_ld_videos
foreign key(video_id)
references videos(video_id)
on update cascade
on delete cascade
)
engine= InnoDB
default character set = utf8mb4;


create table channels(
channel_id int not null auto_increment primary key,
name varchar(50) not null,
description text,
date date not null,
user_id int  not null,
index user_id(user_id),
constraint fk_channels_users
foreign key(user_id)
references users(user_id)
on delete cascade
on update cascade
)
engine= InnoDB
default character set = utf8mb4;

create table users_subscribe_channels(
user_id int not null,
channel_id int not null,
primary key(user_id,channel_id),
index user_id(user_id asc),
constraint fk_usch_user
foreign key(user_id)
references users(user_id)
on delete cascade
on update cascade,
index channel_id(channel_id asc),
constraint fk_usch_channels
foreign key(channel_id)
references channels(channel_id)
on delete cascade
on update cascade
)
engine= InnoDB
default character set = utf8mb4;


create table playlist_has_videos(

playlist_id int not null,
video_id int not null,
index playlist_id (playlist_id asc),
constraint fk_phv_playlists
foreign key(playlist_id)
references playlists(playlist_id)
on update cascade
on delete cascade,
index video_id(video_id asc),
constraint fk_phv_videos
foreign key(video_id)
references videos(video_id)
on update cascade
on delete cascade
)
engine= InnoDB
default character set = utf8mb4;


create table comments(
comment_id int not null auto_increment primary key,
text text not null,
date datetime not null,
user_id int not null,
index user_id(user_id asc),
constraint fk_comments_users
foreign key(user_id)
references users(user_id)
on update cascade
on delete cascade
)
engine= InnoDB
default character set = utf8mb4;

create table users_like_comments(
user_id int not null,
comment_id int not null,
date datetime not null,
type enum('like','dislike'),
index user_id(user_id asc),
constraint fk_ulc_users
foreign key(user_id)
references users(user_id)
on update cascade
on delete cascade,
index comment_id(comment_id),
constraint fk_ulc_comments
foreign key(comment_id)
references comments(comment_id)
on update cascade
on delete cascade
)
engine= InnoDB
default character set = utf8mb4;



