BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "care_member" (
    "id" bigserial PRIMARY KEY,
    "childId" bigint NOT NULL,
    "userId" uuid NOT NULL,
    "displayName" text NOT NULL,
    "role" text NOT NULL,
    "shiftStart" timestamp without time zone,
    "shiftEnd" timestamp without time zone,
    "revokedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "care_member_child_user_idx" ON "care_member" USING btree ("childId", "userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "child" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "photoUrl" text,
    "ownerId" uuid NOT NULL,
    "utcOffsetMinutes" bigint NOT NULL DEFAULT 0
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dose_event" (
    "id" bigserial PRIMARY KEY,
    "childId" bigint NOT NULL,
    "medicineId" bigint NOT NULL,
    "medicineName" text NOT NULL,
    "ingredient" text NOT NULL,
    "doseText" text NOT NULL,
    "caregiverId" uuid NOT NULL,
    "caregiverName" text NOT NULL,
    "at" timestamp without time zone NOT NULL,
    "outcome" text NOT NULL,
    "reason" text,
    "nextAllowedAt" timestamp without time zone,
    "undoneAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "dose_event_child_at_idx" ON "dose_event" USING btree ("childId", "at");
CREATE INDEX "dose_event_child_ingredient_idx" ON "dose_event" USING btree ("childId", "ingredient");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ingredient_lock" (
    "id" bigserial PRIMARY KEY,
    "childId" bigint NOT NULL,
    "ingredient" text NOT NULL,
    "lastGivenAt" timestamp without time zone,
    "lastGivenBy" text
);

-- Indexes
CREATE UNIQUE INDEX "ingredient_lock_child_ingredient_idx" ON "ingredient_lock" USING btree ("childId", "ingredient");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "invite" (
    "id" bigserial PRIMARY KEY,
    "token" text NOT NULL,
    "childId" bigint NOT NULL,
    "displayName" text NOT NULL,
    "role" text NOT NULL,
    "shiftStart" timestamp without time zone,
    "shiftEnd" timestamp without time zone,
    "usedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "invite_token_idx" ON "invite" USING btree ("token");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "medicine" (
    "id" bigserial PRIMARY KEY,
    "childId" bigint NOT NULL,
    "name" text NOT NULL,
    "ingredient" text NOT NULL,
    "doseText" text NOT NULL,
    "minHoursBetween" double precision NOT NULL,
    "maxPer24h" bigint NOT NULL,
    "fixedTimes" json NOT NULL,
    "archivedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "medicine_child_idx" ON "medicine" USING btree ("childId");


--
-- MIGRATION VERSION FOR onedose
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('onedose', '20261014223236374', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261014223236374', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
