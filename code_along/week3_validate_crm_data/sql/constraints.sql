CREATE SCHEMA IF NOT EXISTS constrained;

CREATE TABLE IF NOT EXISTS constrained.crm_new(
    email STRING CHECK (email LIKE '%@%' , '%.%')
    region STRING CHECK (region IN ('EU','US'))
    status STRING CHECK (status IN ('%active%' , '%inactive%'))
);
CREATE TABLE IF NOT EXISTS constrained.crm_old(
    email STRING CHECK (email LIKE '%@%' , '%.%')
    region STRING CHECK (region IN ('EU','US'))
    status STRING CHECK (status IN ('%active%' , '%inactive%'))
);
