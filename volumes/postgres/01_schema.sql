create sequence if not exists flavour_id_seq;

create sequence if not exists flavour_limit_id_seq;

create sequence if not exists image_id_seq;

create sequence if not exists instance_authentication_token_id_seq;

create sequence if not exists instance_command_id_seq;

create sequence if not exists instance_id_seq;

create sequence if not exists instance_member_id_seq;

create sequence if not exists instance_session_id_seq;

create sequence if not exists protocol_id_seq;

create sequence if not exists role_id_seq;

create sequence if not exists instance_attribute_id_seq;

create table if not exists configuration (
    id    bigserial     not null,
    key   varchar(256)  not null,
    value varchar(8192) not null,

    constraint configuration_pkey primary key (id)
);

create table if not exists cycle (
    id         bigint       not null,
    end_date   timestamp    not null,
    name       varchar(100) not null,
    start_date timestamp    not null,

    constraint cycle_pkey primary key (id)
);

create table if not exists employer (
    id           bigint not null,
    country_code varchar(10),
    name         varchar(200),
    town         varchar(100),

    constraint employer_pkey primary key (id)
);

create table if not exists flavour (
    id          bigint default nextval('flavour_id_seq'::regclass) not null,
    created_at  timestamp                                          not null,
    updated_at  timestamp                                          not null,
    compute_id  varchar(250)                                       not null,
    cpu         real                                               not null,
    deleted     boolean                                            not null,
    memory      integer                                            not null,
    name        varchar(250)                                       not null,
    credits     integer                                            default 1 not null,

    description varchar(2500),
    constraint flavour_pkey primary key (id)
);

create table if not exists flavour_limit (
    id          bigint default nextval('flavour_limit_id_seq'::regclass) not null,
    object_id   bigint                                                   not null,
    object_type varchar(255)                                             not null,
    flavour_id  bigint                                                   not null,

    constraint flavour_limit_pkey primary key (id),
    constraint fk_flavour_id foreign key (flavour_id) references flavour
);

create table if not exists image (
    id           bigint default nextval('image_id_seq'::regclass) not null,
    created_at   timestamp                                        not null,
    updated_at   timestamp                                        not null,
    boot_command text,
    compute_id   varchar(250)                                     not null,
    deleted      boolean                                          not null,
    description  varchar(2500),
    icon         varchar(100)                                     not null,
    name         varchar(250)                                     not null,
    version      varchar(100),
    visible      boolean                                          not null,
    autologin    varchar(255),

    constraint image_pkey primary key (id)
);

create table if not exists instrument (
    id   bigint       not null,
    name varchar(250) not null,

    constraint instrument_pkey primary key (id)
);

create table if not exists plan (
    id         bigserial not null,
    created_at timestamp not null,
    updated_at timestamp not null,
    preset     boolean   not null,
    flavour_id bigint,
    image_id   bigint,

    constraint plan_pkey primary key (id),
    constraint fk_flavour_id foreign key (flavour_id) references flavour,
    constraint fk_image_id foreign key (image_id) references image
);

create table if not exists instance (
    id                  bigint       default nextval('instance_id_seq'::regclass) not null,
    created_at          timestamp                                                 not null,
    updated_at          timestamp                                                 not null,
    comments            varchar(2500),
    compute_id          varchar(250),
    delete_requested    boolean                                                   not null,
    ip_address          varchar(255),
    last_interaction_at timestamp,
    last_seen_at        timestamp,
    name                varchar(250)                                              not null,
    screen_height       integer                                                   not null,
    screen_width        integer                                                   not null,
    state               varchar(50)                                               not null,
    termination_date    timestamp,
    username            varchar(100),
    plan_id             bigint,
    deleted_at          timestamp,
    keyboard_layout     varchar(100) default 'en-gb-qwerty'::character varying,
    security_groups     text,
    home_directory      varchar(250),

    constraint instance_pkey primary key (id),
    constraint fk_plan_id foreign key (plan_id) references plan
);

create table if not exists instance_expiration (
    id              bigserial not null,
    created_at      timestamp not null,
    updated_at      timestamp not null,
    expiration_date timestamp not null,
    instance_id     bigint    not null,

    constraint instance_expiration_pkey primary key (id),
    constraint uk_instance_expiration_instance_id unique (instance_id),
    constraint fk_instance_id foreign key (instance_id) references instance
);

create table if not exists instance_session (
    id            bigint default nextval('instance_session_id_seq'::regclass) not null,
    created_at    timestamp                                                   not null,
    updated_at    timestamp                                                   not null,
    connection_id varchar(150)                                                not null,
    current       boolean                                                     not null,
    instance_id   bigint                                                      not null,

    constraint instance_session_pkey primary key (id),
    constraint fk_instance_id foreign key (instance_id) references instance
);

create table if not exists instance_thumbnail (
    id          bigserial not null,
    created_at  timestamp not null,
    updated_at  timestamp not null,
    data        text      not null,
    instance_id bigint    not null,

    constraint instance_thumbnail_pkey primary key (id),
    constraint uk_instance_thumbnail_instance_id unique (instance_id),
    constraint fk_instance_id foreign key (instance_id) references instance
);

create table if not exists proposal (
    id         bigint       not null,
    identifier varchar(100) not null,
    title      varchar(2000),
    public_at  timestamp,
    summary    varchar(5000),

    constraint proposal_pkey primary key (id)
);

create table if not exists experiment (
    id            varchar(32) not null,
    cycle_id      bigint      not null,
    instrument_id bigint      not null,
    proposal_id   bigint      not null,
    end_date      timestamp,
    start_date    timestamp,

    constraint experiment_pkey primary key (id),
    constraint fk_cycle_id foreign key (cycle_id) references cycle,
    constraint fk_instrument_id foreign key (instrument_id) references instrument,
    constraint fk_proposal_id foreign key (proposal_id) references proposal
);

create table if not exists instance_experiment (
    instance_id   bigint      not null,
    experiment_id varchar(32) not null,

    constraint instance_experiment_pkey primary key (experiment_id, instance_id),
    constraint fk_experiment_id foreign key (experiment_id) references experiment,
    constraint fk_instance_id foreign key (instance_id) references instance
);

create table if not exists protocol (
    id   bigint default nextval('protocol_id_seq'::regclass) not null,
    name varchar(100)                                        not null,
    port integer                                             not null,

    constraint protocol_pkey primary key (id)
);

create table if not exists image_protocol (
    image_id    bigint not null,
    protocol_id bigint not null,
    constraint fk_protocol_id foreign key (protocol_id) references protocol,

    constraint fk_image_id foreign key (image_id) references image
);

create table if not exists role (
    id          bigint default nextval('role_id_seq'::regclass) not null,
    description varchar(250),
    name        varchar(100)                                    not null,

    constraint role_pkey primary key (id),
    constraint uk_role_name unique (name)
);

create table if not exists security_group (
    id   bigserial    not null,
    name varchar(250) not null,

    constraint security_group_pkey primary key (id)
);

create table if not exists security_group_filter (
    id                bigserial    not null,
    object_id         bigint       not null,
    object_type       varchar(255) not null,
    security_group_id bigint       not null,

    constraint security_group_filter_pkey primary key (id),
    constraint fk_security_group_id foreign key (security_group_id) references security_group
);

create table if not exists system_notification (
    id         bigserial     not null,
    created_at timestamp     not null,
    updated_at timestamp     not null,
    level      varchar(50)   not null,
    message    varchar(4096) not null,

    constraint system_notification_pkey primary key (id)
);

create table if not exists users (
    id             varchar(250) not null,
    email          varchar(100),
    first_name     varchar(100),
    instance_quota integer      not null,
    last_name      varchar(100) not null,
    last_seen_at   timestamp,
    affiliation_id bigint,
    activated_at   timestamp,
    activated      timestamp,

    constraint users_pkey primary key (id),
    constraint fk_employer_id foreign key (affiliation_id) references employer
);

create table if not exists experiment_user (
    experiment_id varchar(32)  not null,
    user_id       varchar(250) not null,

    constraint experiment_user_pkey primary key (experiment_id, user_id),
    constraint fk_experiment_id foreign key (experiment_id) references experiment,
    constraint fk_users_id foreign key (user_id) references users
);

create table if not exists instance_authentication_token (
    id          bigint default nextval('instance_authentication_token_id_seq'::regclass) not null,
    created_at  timestamp                                                                not null,
    updated_at  timestamp                                                                not null,
    token       varchar(250)                                                             not null,
    instance_id bigint                                                                   not null,
    user_id     varchar(250)                                                             not null,

    constraint instance_authentication_token_pkey primary key (id),
    constraint fk_instance_id foreign key (instance_id) references instance,
    constraint fk_users_id foreign key (user_id) references users
);

create table if not exists instance_command (
    id          bigint default nextval('instance_command_id_seq'::regclass) not null,
    created_at  timestamp                                                   not null,
    updated_at  timestamp                                                   not null,
    action_type varchar(50)                                                 not null,
    message     varchar(255),
    state       varchar(50)                                                 not null,
    instance_id bigint                                                      not null,
    user_id     varchar(250),

    constraint instance_command_pkey primary key (id),
    constraint fk_instance_id foreign key (instance_id) references instance,
    constraint fk_users_id foreign key (user_id) references users
);

create table if not exists instance_jupyter_session (
    id          bigserial    not null,
    created_at  timestamp    not null,
    updated_at  timestamp    not null,
    active      boolean      not null,
    kernel_id   varchar(150) not null,
    session_id  varchar(150) not null,
    instance_id bigint       not null,
    user_id     varchar(250) not null,

    constraint instance_jupyter_session_pkey primary key (id),
    constraint fk_instance_id foreign key (instance_id) references instance,
    constraint fk_users_id foreign key (user_id) references users
);

create table if not exists instance_member (
    id          bigint default nextval('instance_member_id_seq'::regclass) not null,
    created_at  timestamp                                                  not null,
    updated_at  timestamp                                                  not null,
    role        varchar(255)                                               not null,
    user_id     varchar(250)                                               not null,
    instance_id bigint                                                     not null,

    constraint instance_member_pkey primary key (id),
    constraint fk_instance_id foreign key (instance_id) references instance,
    constraint fk_users_id foreign key (user_id) references users
);

create table if not exists instance_session_member (
    id                  bigserial    not null,
    created_at          timestamp    not null,
    updated_at          timestamp    not null,
    active              boolean      not null,
    last_interaction_at timestamp,
    last_seen_at        timestamp,
    role                varchar(150) not null,
    session_id          varchar(150) not null,
    instance_session_id bigint       not null,
    user_id             varchar(250) not null,

    constraint instance_session_member_pkey primary key (id),
    constraint fk_instance_session_id foreign key (instance_session_id) references instance_session,
    constraint fk_users_id foreign key (user_id) references users
);

create table if not exists instrument_scientist (
    instrument_id bigint       not null,
    user_id       varchar(250) not null,

    constraint instrument_responsible_pkey primary key (instrument_id, user_id),
    constraint fk_instrument_id foreign key (instrument_id) references instrument,
    constraint fk_users_id foreign key (user_id) references users
);

create table if not exists user_role (
    user_id varchar(250) not null,
    role_id bigint       not null,

    constraint fk_role_id foreign key (role_id) references role,
    constraint fk_users_id foreign key (user_id) references users
);

create table if not exists instance_attribute (
    id          bigint default nextval('instance_attribute_id_seq'::regclass) not null,
    created_at  timestamp                                                     not null,
    updated_at  timestamp                                                     not null,
    name        varchar(255)                                                  not null,
    value       varchar(255)                                                  not null,
    instance_id bigint                                                        not null,

    constraint instance_attribute_pkey primary key (id),
    constraint fk_instance_id foreign key (instance_id) references instance
);
