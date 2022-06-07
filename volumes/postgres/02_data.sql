INSERT INTO role (id, description, name) VALUES (1, 'Administrator role', 'ADMIN');
INSERT INTO role (id, description, name) VALUES (2, 'Staff Role', 'STAFF');
INSERT INTO role (id, description, name) VALUES (3, 'Instrument Control role', 'INSTRUMENT_CONTROL');
INSERT INTO role (id, description, name) VALUES (4, 'Instrument Scientist role', 'INSTRUMENT_SCIENTIST');
INSERT INTO role (id, description, name) VALUES (5, 'IT Support role', 'IT_SUPPORT');
INSERT INTO role (id, description, name) VALUES (6, 'Scientific Computing role', 'SCIENTIFIC_COMPUTING');

INSERT INTO users (id, email, instance_quota, last_name, first_name) VALUES
    ('1', 'user@example.com', 10, 'User', 'John'),
    ('2', 'scientist@example.com', 10, 'Scientist', 'Joe'),
    ('3', 'admin@example.com', 10, 'Admin', 'Jane'),
    ('4', 'it_support@example.com', 10, 'I.T. Support', 'Jacky');

INSERT INTO user_role (user_id, role_id) VALUES
    ('2', 2),
    ('2', 4),
    ('3', 1),
    ('3', 2),
    ('3', 5),
    ('4', 2),
    ('4', 5);

INSERT INTO instrument (id, name) VALUES (1, 'Instrument 1');
INSERT INTO cycle (id, name, start_date, end_date) VALUES (1, '2018-1', '2008-01-01', '2028-01-01');
INSERT INTO proposal (id, identifier, title) VALUES (1, 'TEST-PROP', 'Test proposal');
INSERT INTO experiment (id, cycle_id, instrument_id, proposal_id, end_date, start_date) VALUES (1, 1, 1, 1, '2024-01-01', '2021-01-01');
INSERT INTO experiment_user (experiment_id, user_id) VALUES 
    (1, '1'),
    (1, '2'),
    (1, '3'),
    (1, '4');
INSERT INTO instrument_scientist (instrument_id, user_id) VALUES (1, '2');

INSERT INTO protocol (name, port) VALUES ('RDP', 3389);
INSERT INTO protocol (name, port) VALUES ('GUACD', 4822);
INSERT INTO protocol (name, port) VALUES ('JUPYTER', 8888);

INSERT INTO flavour (id, created_at, updated_at, compute_id, cpu, deleted, memory, credits, name) VALUES
    (1, '2021-01-01', '2021-01-01', '25', 2, false, 8192, 1, 'Small');

INSERT INTO image (id, created_at, updated_at, compute_id, deleted, icon, name, visible, boot_command, autologin, description, version) VALUES
    (1,  '2021-01-01', '2021-01-01', '1a987fb2-fced-48e8-b1f1-410d7681286b', false, 'data-analysis-1.jpg', 'Data Analysis (demo)', true, '#!/bin/bash

# Get the owner login from cloud-init
owner=$(cloud-init query ds.meta_data.meta.owner)

# Create the user with a random password
useradd -m -U -p $(date +%s | sha256sum | base64 | head -c 32) -s /bin/bash ${owner}

# /etc/visa/public.pem VISA PAM public key
PAM_PUBLIC_KEY=$(cloud-init query ds.meta_data.meta.pamPublicKey)
if [ $? -eq 0 ]; then
  mkdir -p /etc/visa
  echo "$PAM_PUBLIC_KEY" > /etc/visa/public.pem
fi', 'VISA_PAM', 'Test image generated from https://github.com/ILLGrenoble/visa-image-template-example', '1.0.0');

INSERT INTO plan (id, created_at, updated_at, preset, flavour_id, image_id) VALUES
    (1, '2021-01-01', '2021-01-01', true, 1, 1);

INSERT INTO image_protocol (image_id, protocol_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3);
