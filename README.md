# OneDose

**Every dose, once.** A shared dose log for everyone who looks after one
child: parents, co-parents, sitters and grandparents. The server refuses a
second dose before anyone can give it.

> OneDose is a coordination log, not a medical device. It never suggests a
> dose or an interval: the parent copies them from the label or the doctor.

## The problem

About 1 in 4 out-of-hospital medication errors in children under 6 is the same
dose given twice (27.0%, ~63,000 errors a year in the US, 2002–2012; Smith et
al., *Pediatrics*, summarised by Healthcare Packaging and Clifford Law). It
happens at handoffs: parent to sitter, two parents at night, grandparents with
a fridge note, or two products that both contain paracetamol.

## What it does

1. A parent sets up a child and their medicines (name, active ingredient,
   dose, minimum hours between doses, maximum per 24 h, optional fixed times).
2. The parent invites a sitter for one shift, or a co-parent.
3. Anyone taps **Give**. The server accepts it or refuses it:
   *"Already given by Mum at 6:02pm. Next allowed 10:02pm."*
4. Every phone in the circle updates live.
5. A fixed-time dose nobody logs alerts the on-shift caregiver at +15 min,
   then the parent at +30 min.
6. At the end of a sitter's shift the server revokes access and closes their
   stream.

## Architecture (Serverpod 4)

```
 Flutter app ──logDose──▶ DoseEndpoint ──▶ Postgres transaction
     ▲                         │            SELECT … FOR UPDATE on
     │                         │            ingredient_lock(child, ingredient)
     │                         ▼
     └──── circle.watch ◀── server event "child:<id>"
              (stream)          ▲
                                │
                 Future calls (stored in Postgres, survive restarts)
                 slotDue → missedDoseCheck(stage 1, 2) · shiftExpiry
```

All safety logic lives on the server; the app only shows what the server
decides, so a stale phone can never approve a dose.

| Piece | Where |
| --- | --- |
| Row-locked dose check | `onedose_server/lib/src/onedose/logic/dose_service.dart` (`logDose`) |
| Pure decision rules (interval, rolling 24 h max, strictest limits per ingredient) | `logic/dose_rules.dart` |
| Live stream + server events | `endpoints/circle_endpoint.dart`, `logic/circle_events.dart` |
| Escalation and shift expiry future calls | `future_calls/escalation_future_call.dart`, `logic/escalation.dart` |
| Role and shift checks on every call | `logic/access.dart` |
| Models | `lib/src/onedose/models/*.spy.yaml` |

Endpoints: `child.mine/create/update`, `medicine.list/add/update/archive`
(owner only), `dose.logDose/overrideDose/undo/status`, `circle.watch/members/revoke`,
`invite.create/accept`, `history.list` (sitters see their shift only).

Lockouts are keyed on the **active ingredient**, and the strictest limits of
every medicine sharing it apply, so a second product can never loosen them.
Traffic lights: green = OK now; amber = allowed within the hour; red = daily
maximum reached or locked for more than an hour; grey = "Can't check — ask
the parent before giving" when the server can't be reached.

## Run locally

Requires Flutter (3.44+) and the Serverpod CLI 4.0.4
(`dart pub global activate serverpod_cli 4.0.4`).

```sh
cp onedose_server/config/passwords.yaml.example onedose_server/config/passwords.yaml
cd onedose_server
serverpod start        # embedded Postgres, applies migrations, launches the app
```

Sign-up verification codes are printed in the server log in development.

## Tests

```sh
cd onedose_server && dart test
```

21 tests (9 unit, 12 integration against a real Postgres), covering the PRD
requirements:

| Req | Test |
| --- | --- |
| R1 race | two concurrent `logDose` calls → exactly one accepted, the other names the first caregiver |
| R2 ingredient lockout | cold remedy refused after Calpol, "Contains paracetamol…", next allowed +4 h |
| R3 daily maximum | 5th dose in a rolling 24 h refused, names the oldest dose |
| R4 live status | a dose on one phone reaches the other's open stream with fresh statuses |
| R5 escalation | stage 1 alerts the on-shift sitter, stage 2 the parent; silent once logged |
| R7 shift scope | can't log before the shift; at expiry the stream closes and calls fail |
| R8 sitter view | sitter's history shows only their shift |
| R10 no advice | sitters can't change limits; strangers can't read anything |
| extras | owner override with reason, undo within 2 minutes |

R6 (escalation survives a restart) relies on Serverpod future calls being
stored in Postgres; check it by hand: add a medicine with a fixed time a
minute ahead, stop the server after it is due, start it again, and the alert
still arrives.

## Production

### Serverpod Cloud (recommended, used for the demo)

```sh
dart pub global activate serverpod_cloud_cli
scloud auth login
./scripts/build_web.sh          # bundle the Flutter web app into the server
scloud launch                   # first time: creates the project and database
scloud deploy                   # later deploys
scloud env set ONEDOSE_DEMO true   # optional: 1/2 minute escalation stages
```

Serverpod Cloud provides Postgres, the passwords and sign-up email.

### Self-hosted (Docker)

```sh
cp .env.production.example .env.production   # fill in secrets and hosts
./scripts/build_web.sh
docker compose -f docker-compose.production.yaml --env-file .env.production up -d --build
```

This runs Postgres 16 and the server (`--mode=production --apply-migrations`)
on ports 8080 (API and streams), 8081 (Insights) and 8082 (web app). Put a
TLS proxy in front. Production config is in
`onedose_server/config/production.yaml`; every value can be overridden with
`SERVERPOD_*` environment variables, and secrets are passed as
`SERVERPOD_PASSWORD_<key>`. Self-hosted sign-up emails need either a Serverpod
Cloud email key (`SCLOUD_EMAIL_KEY`) or a switch to
`EmailIdpConfigFromPasswords` in `lib/server.dart`.

Point the Flutter app at the server with
`flutter run --dart-define=SERVER_URL=https://api.onedose.example.com/`.

## Known limits

- Alerts arrive in-app over the live stream; there are no OS push notifications.
- Demo timings (`ONEDOSE_DEMO=true`) shorten escalation stages to 1 and 2
  minutes; the app labels them.
- One child per account.
- Safety depends on everyone logging in the app; a dose given without logging
  is invisible.
- With more than one server instance, enable Redis so server events reach
  every instance's streams.
