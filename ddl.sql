create table match
(
    user_id       CHAR(16) FOR BIT DATA not null,
    code_length   integer,
    criterion     integer               not null,
    deadline      timestamp             not null,
    game_count    integer,
    pool          varchar(255)          not null,
    started       timestamp             not null,
    originator_id CHAR(16) FOR BIT DATA not null,
    winner_id     CHAR(16) FOR BIT DATA,
    primary key (user_id)
);
create table match_players
(
    match_id CHAR(16) FOR BIT DATA not null,
    user_id  CHAR(16) FOR BIT DATA not null
);
create table user
(
    user_id      CHAR(16) FOR BIT DATA not null,
    connected    timestamp             not null,
    created      timestamp             not null,
    display_name varchar(255)          not null,
    oauth_key    varchar(255)          not null,
    primary key (user_id)
);
create index IDXloyix2kr5uwndqrblb242x3gk on match (code_length);
create index IDXtjinb4htqg29y0b0ujxg1rnli on match (game_count);
create index IDXs836wyhyo3rv6hrin679fgoy3 on match (started, deadline);
create index IDX3vj50ndbmwmpkmprgo7neleaw on user (created);
create index IDX4wi1c3krx22gugfvq0k302o11 on user (connected);
alter table user
    add constraint UK_pnrrew2o71m330w38p0ypwjvn unique (display_name);
alter table user
    add constraint UK_rw9u8m4te7vpjhe2wuvh9imsr unique (oauth_key);
alter table match
    add constraint FK8j6dnctelbkwidc1t6hw09e4f foreign key (originator_id) references user;
alter table match
    add constraint FKcr1c1f7t61ssrl016w77sf8t4 foreign key (winner_id) references user;
alter table match_players
    add constraint FK13l9h9a688fnkc41p71jvwh9f foreign key (user_id) references user;
alter table match_players
    add constraint FK6dt8lhwlydo06x5aky9glyrva foreign key (match_id) references match;
