--
-- PostgreSQL database dump
--

\restrict 6OBIVgOnpeiINoDRdoyxSZBGxA0iZimmcf7y8vdSrodLkc1BRZDOl9EBRt8Kmlu

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP EVENT TRIGGER pgrst_drop_watch;
DROP EVENT TRIGGER pgrst_ddl_watch;
DROP EVENT TRIGGER issue_pg_net_access;
DROP EVENT TRIGGER issue_pg_graphql_access;
DROP EVENT TRIGGER issue_pg_cron_access;
DROP EVENT TRIGGER issue_graphql_placeholder;
DROP PUBLICATION supabase_realtime_messages_publication;
DROP PUBLICATION supabase_realtime;
DROP POLICY "Users can view own redemptions" ON public.redemptions;
DROP POLICY "Users can view own notifications" ON public.notifications;
DROP POLICY "Users can view own mentors" ON public.mentors;
DROP POLICY "Users can view own ledger" ON public.points_ledger;
DROP POLICY "Users can view all profiles" ON public.profiles;
DROP POLICY "Users can update own profile" ON public.profiles;
DROP POLICY "Users can update own notifications" ON public.notifications;
DROP POLICY "Users can update own mentors" ON public.mentors;
DROP POLICY "Users can insert their own points" ON public.points_ledger;
DROP POLICY "Users can insert own redemptions" ON public.redemptions;
DROP POLICY "Users can insert own mentors" ON public.mentors;
DROP POLICY "Super admins can view all redemptions" ON public.redemptions;
DROP POLICY "Super admins can view all products" ON public.marketplace_products;
DROP POLICY "Super admins can view all mentors" ON public.mentors;
DROP POLICY "Super admins can view all ledgers" ON public.points_ledger;
DROP POLICY "Super admins can update redemptions" ON public.redemptions;
DROP POLICY "Super admins can update products" ON public.marketplace_products;
DROP POLICY "Super admins can update any profile" ON public.profiles;
DROP POLICY "Super admins can update any mentor" ON public.mentors;
DROP POLICY "Super admins can insert products" ON public.marketplace_products;
DROP POLICY "Super admins can delete products" ON public.marketplace_products;
DROP POLICY "Anyone can view active products" ON public.marketplace_products;
ALTER TABLE ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey;
ALTER TABLE ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey;
ALTER TABLE ONLY storage.s3_multipart_uploads DROP CONSTRAINT s3_multipart_uploads_bucket_id_fkey;
ALTER TABLE ONLY storage.prefixes DROP CONSTRAINT "prefixes_bucketId_fkey";
ALTER TABLE ONLY storage.objects DROP CONSTRAINT "objects_bucketId_fkey";
ALTER TABLE ONLY public.redemptions DROP CONSTRAINT redemptions_user_id_fkey;
ALTER TABLE ONLY public.redemptions DROP CONSTRAINT redemptions_product_id_fkey;
ALTER TABLE ONLY public.profiles DROP CONSTRAINT profiles_id_fkey;
ALTER TABLE ONLY public.points_ledger DROP CONSTRAINT points_ledger_user_id_fkey;
ALTER TABLE ONLY public.points_ledger DROP CONSTRAINT points_ledger_mentor_id_fkey;
ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_user_id_fkey;
ALTER TABLE ONLY public.mentors DROP CONSTRAINT mentors_edited_by_user_id_fkey;
ALTER TABLE ONLY public.mentors DROP CONSTRAINT mentors_created_by_user_id_fkey;
ALTER TABLE ONLY auth.sso_domains DROP CONSTRAINT sso_domains_sso_provider_id_fkey;
ALTER TABLE ONLY auth.sessions DROP CONSTRAINT sessions_user_id_fkey;
ALTER TABLE ONLY auth.sessions DROP CONSTRAINT sessions_oauth_client_id_fkey;
ALTER TABLE ONLY auth.saml_relay_states DROP CONSTRAINT saml_relay_states_sso_provider_id_fkey;
ALTER TABLE ONLY auth.saml_relay_states DROP CONSTRAINT saml_relay_states_flow_state_id_fkey;
ALTER TABLE ONLY auth.saml_providers DROP CONSTRAINT saml_providers_sso_provider_id_fkey;
ALTER TABLE ONLY auth.refresh_tokens DROP CONSTRAINT refresh_tokens_session_id_fkey;
ALTER TABLE ONLY auth.one_time_tokens DROP CONSTRAINT one_time_tokens_user_id_fkey;
ALTER TABLE ONLY auth.oauth_consents DROP CONSTRAINT oauth_consents_user_id_fkey;
ALTER TABLE ONLY auth.oauth_consents DROP CONSTRAINT oauth_consents_client_id_fkey;
ALTER TABLE ONLY auth.oauth_authorizations DROP CONSTRAINT oauth_authorizations_user_id_fkey;
ALTER TABLE ONLY auth.oauth_authorizations DROP CONSTRAINT oauth_authorizations_client_id_fkey;
ALTER TABLE ONLY auth.mfa_factors DROP CONSTRAINT mfa_factors_user_id_fkey;
ALTER TABLE ONLY auth.mfa_challenges DROP CONSTRAINT mfa_challenges_auth_factor_id_fkey;
ALTER TABLE ONLY auth.mfa_amr_claims DROP CONSTRAINT mfa_amr_claims_session_id_fkey;
ALTER TABLE ONLY auth.identities DROP CONSTRAINT identities_user_id_fkey;
DROP TRIGGER update_objects_updated_at ON storage.objects;
DROP TRIGGER prefixes_delete_hierarchy ON storage.prefixes;
DROP TRIGGER prefixes_create_hierarchy ON storage.prefixes;
DROP TRIGGER objects_update_create_prefix ON storage.objects;
DROP TRIGGER objects_insert_create_prefix ON storage.objects;
DROP TRIGGER objects_delete_delete_prefix ON storage.objects;
DROP TRIGGER enforce_bucket_name_length_trigger ON storage.buckets;
DROP TRIGGER tr_check_filters ON realtime.subscription;
DROP TRIGGER update_mentors_updated_at ON public.mentors;
DROP TRIGGER update_marketplace_products_updated_at ON public.marketplace_products;
DROP TRIGGER on_auth_user_created ON auth.users;
DROP INDEX storage.objects_bucket_id_level_idx;
DROP INDEX storage.name_prefix_search;
DROP INDEX storage.idx_prefixes_lower_name;
DROP INDEX storage.idx_objects_lower_name;
DROP INDEX storage.idx_objects_bucket_id_name;
DROP INDEX storage.idx_name_bucket_level_unique;
DROP INDEX storage.idx_multipart_uploads_list;
DROP INDEX storage.bucketid_objname;
DROP INDEX storage.bname;
DROP INDEX realtime.subscription_subscription_id_entity_filters_key;
DROP INDEX realtime.messages_inserted_at_topic_index;
DROP INDEX realtime.ix_realtime_subscription_entity;
DROP INDEX public.idx_redemptions_user_id;
DROP INDEX public.idx_points_ledger_user_id;
DROP INDEX public.idx_points_ledger_created_at;
DROP INDEX public.idx_notifications_user_id;
DROP INDEX public.idx_notifications_is_read;
DROP INDEX public.idx_mentors_status;
DROP INDEX public.idx_mentors_created_by;
DROP INDEX public.idx_mentors_created_at;
DROP INDEX auth.users_is_anonymous_idx;
DROP INDEX auth.users_instance_id_idx;
DROP INDEX auth.users_instance_id_email_idx;
DROP INDEX auth.users_email_partial_key;
DROP INDEX auth.user_id_created_at_idx;
DROP INDEX auth.unique_phone_factor_per_user;
DROP INDEX auth.sso_providers_resource_id_pattern_idx;
DROP INDEX auth.sso_providers_resource_id_idx;
DROP INDEX auth.sso_domains_sso_provider_id_idx;
DROP INDEX auth.sso_domains_domain_idx;
DROP INDEX auth.sessions_user_id_idx;
DROP INDEX auth.sessions_oauth_client_id_idx;
DROP INDEX auth.sessions_not_after_idx;
DROP INDEX auth.saml_relay_states_sso_provider_id_idx;
DROP INDEX auth.saml_relay_states_for_email_idx;
DROP INDEX auth.saml_relay_states_created_at_idx;
DROP INDEX auth.saml_providers_sso_provider_id_idx;
DROP INDEX auth.refresh_tokens_updated_at_idx;
DROP INDEX auth.refresh_tokens_session_id_revoked_idx;
DROP INDEX auth.refresh_tokens_parent_idx;
DROP INDEX auth.refresh_tokens_instance_id_user_id_idx;
DROP INDEX auth.refresh_tokens_instance_id_idx;
DROP INDEX auth.recovery_token_idx;
DROP INDEX auth.reauthentication_token_idx;
DROP INDEX auth.one_time_tokens_user_id_token_type_key;
DROP INDEX auth.one_time_tokens_token_hash_hash_idx;
DROP INDEX auth.one_time_tokens_relates_to_hash_idx;
DROP INDEX auth.oauth_consents_user_order_idx;
DROP INDEX auth.oauth_consents_active_user_client_idx;
DROP INDEX auth.oauth_consents_active_client_idx;
DROP INDEX auth.oauth_clients_deleted_at_idx;
DROP INDEX auth.oauth_auth_pending_exp_idx;
DROP INDEX auth.mfa_factors_user_id_idx;
DROP INDEX auth.mfa_factors_user_friendly_name_unique;
DROP INDEX auth.mfa_challenge_created_at_idx;
DROP INDEX auth.idx_user_id_auth_method;
DROP INDEX auth.idx_auth_code;
DROP INDEX auth.identities_user_id_idx;
DROP INDEX auth.identities_email_idx;
DROP INDEX auth.flow_state_created_at_idx;
DROP INDEX auth.factor_id_created_at_idx;
DROP INDEX auth.email_change_token_new_idx;
DROP INDEX auth.email_change_token_current_idx;
DROP INDEX auth.confirmation_token_idx;
DROP INDEX auth.audit_logs_instance_id_idx;
ALTER TABLE ONLY storage.s3_multipart_uploads DROP CONSTRAINT s3_multipart_uploads_pkey;
ALTER TABLE ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT s3_multipart_uploads_parts_pkey;
ALTER TABLE ONLY storage.prefixes DROP CONSTRAINT prefixes_pkey;
ALTER TABLE ONLY storage.objects DROP CONSTRAINT objects_pkey;
ALTER TABLE ONLY storage.migrations DROP CONSTRAINT migrations_pkey;
ALTER TABLE ONLY storage.migrations DROP CONSTRAINT migrations_name_key;
ALTER TABLE ONLY storage.buckets DROP CONSTRAINT buckets_pkey;
ALTER TABLE ONLY storage.buckets_analytics DROP CONSTRAINT buckets_analytics_pkey;
ALTER TABLE ONLY realtime.schema_migrations DROP CONSTRAINT schema_migrations_pkey;
ALTER TABLE ONLY realtime.subscription DROP CONSTRAINT pk_subscription;
ALTER TABLE ONLY realtime.messages_2025_11_03 DROP CONSTRAINT messages_2025_11_03_pkey;
ALTER TABLE ONLY realtime.messages_2025_11_02 DROP CONSTRAINT messages_2025_11_02_pkey;
ALTER TABLE ONLY realtime.messages_2025_11_01 DROP CONSTRAINT messages_2025_11_01_pkey;
ALTER TABLE ONLY realtime.messages_2025_10_31 DROP CONSTRAINT messages_2025_10_31_pkey;
ALTER TABLE ONLY realtime.messages_2025_10_30 DROP CONSTRAINT messages_2025_10_30_pkey;
ALTER TABLE ONLY realtime.messages_2025_10_29 DROP CONSTRAINT messages_2025_10_29_pkey;
ALTER TABLE ONLY realtime.messages_2025_10_28 DROP CONSTRAINT messages_2025_10_28_pkey;
ALTER TABLE ONLY realtime.messages DROP CONSTRAINT messages_pkey;
ALTER TABLE ONLY public.redemptions DROP CONSTRAINT redemptions_pkey;
ALTER TABLE ONLY public.profiles DROP CONSTRAINT profiles_pkey;
ALTER TABLE ONLY public.profiles DROP CONSTRAINT profiles_email_key;
ALTER TABLE ONLY public.points_ledger DROP CONSTRAINT points_ledger_pkey;
ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_pkey;
ALTER TABLE ONLY public.mentors DROP CONSTRAINT mentors_pkey;
ALTER TABLE ONLY public.mentors DROP CONSTRAINT mentors_linkedin_url_key;
ALTER TABLE ONLY public.marketplace_products DROP CONSTRAINT marketplace_products_pkey;
ALTER TABLE ONLY auth.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY auth.users DROP CONSTRAINT users_phone_key;
ALTER TABLE ONLY auth.sso_providers DROP CONSTRAINT sso_providers_pkey;
ALTER TABLE ONLY auth.sso_domains DROP CONSTRAINT sso_domains_pkey;
ALTER TABLE ONLY auth.sessions DROP CONSTRAINT sessions_pkey;
ALTER TABLE ONLY auth.schema_migrations DROP CONSTRAINT schema_migrations_pkey;
ALTER TABLE ONLY auth.saml_relay_states DROP CONSTRAINT saml_relay_states_pkey;
ALTER TABLE ONLY auth.saml_providers DROP CONSTRAINT saml_providers_pkey;
ALTER TABLE ONLY auth.saml_providers DROP CONSTRAINT saml_providers_entity_id_key;
ALTER TABLE ONLY auth.refresh_tokens DROP CONSTRAINT refresh_tokens_token_unique;
ALTER TABLE ONLY auth.refresh_tokens DROP CONSTRAINT refresh_tokens_pkey;
ALTER TABLE ONLY auth.one_time_tokens DROP CONSTRAINT one_time_tokens_pkey;
ALTER TABLE ONLY auth.oauth_consents DROP CONSTRAINT oauth_consents_user_client_unique;
ALTER TABLE ONLY auth.oauth_consents DROP CONSTRAINT oauth_consents_pkey;
ALTER TABLE ONLY auth.oauth_clients DROP CONSTRAINT oauth_clients_pkey;
ALTER TABLE ONLY auth.oauth_authorizations DROP CONSTRAINT oauth_authorizations_pkey;
ALTER TABLE ONLY auth.oauth_authorizations DROP CONSTRAINT oauth_authorizations_authorization_id_key;
ALTER TABLE ONLY auth.oauth_authorizations DROP CONSTRAINT oauth_authorizations_authorization_code_key;
ALTER TABLE ONLY auth.mfa_factors DROP CONSTRAINT mfa_factors_pkey;
ALTER TABLE ONLY auth.mfa_factors DROP CONSTRAINT mfa_factors_last_challenged_at_key;
ALTER TABLE ONLY auth.mfa_challenges DROP CONSTRAINT mfa_challenges_pkey;
ALTER TABLE ONLY auth.mfa_amr_claims DROP CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey;
ALTER TABLE ONLY auth.instances DROP CONSTRAINT instances_pkey;
ALTER TABLE ONLY auth.identities DROP CONSTRAINT identities_provider_id_provider_unique;
ALTER TABLE ONLY auth.identities DROP CONSTRAINT identities_pkey;
ALTER TABLE ONLY auth.flow_state DROP CONSTRAINT flow_state_pkey;
ALTER TABLE ONLY auth.audit_log_entries DROP CONSTRAINT audit_log_entries_pkey;
ALTER TABLE ONLY auth.mfa_amr_claims DROP CONSTRAINT amr_id_pk;
ALTER TABLE auth.refresh_tokens ALTER COLUMN id DROP DEFAULT;
DROP TABLE storage.s3_multipart_uploads_parts;
DROP TABLE storage.s3_multipart_uploads;
DROP TABLE storage.prefixes;
DROP TABLE storage.objects;
DROP TABLE storage.migrations;
DROP TABLE storage.buckets_analytics;
DROP TABLE storage.buckets;
DROP TABLE realtime.subscription;
DROP TABLE realtime.schema_migrations;
DROP TABLE realtime.messages_2025_11_03;
DROP TABLE realtime.messages_2025_11_02;
DROP TABLE realtime.messages_2025_11_01;
DROP TABLE realtime.messages_2025_10_31;
DROP TABLE realtime.messages_2025_10_30;
DROP TABLE realtime.messages_2025_10_29;
DROP TABLE realtime.messages_2025_10_28;
DROP TABLE realtime.messages;
DROP TABLE public.redemptions;
DROP TABLE public.profiles;
DROP TABLE public.points_ledger;
DROP TABLE public.notifications;
DROP TABLE public.mentors;
DROP TABLE public.marketplace_products;
DROP TABLE auth.users;
DROP TABLE auth.sso_providers;
DROP TABLE auth.sso_domains;
DROP TABLE auth.sessions;
DROP TABLE auth.schema_migrations;
DROP TABLE auth.saml_relay_states;
DROP TABLE auth.saml_providers;
DROP SEQUENCE auth.refresh_tokens_id_seq;
DROP TABLE auth.refresh_tokens;
DROP TABLE auth.one_time_tokens;
DROP TABLE auth.oauth_consents;
DROP TABLE auth.oauth_clients;
DROP TABLE auth.oauth_authorizations;
DROP TABLE auth.mfa_factors;
DROP TABLE auth.mfa_challenges;
DROP TABLE auth.mfa_amr_claims;
DROP TABLE auth.instances;
DROP TABLE auth.identities;
DROP TABLE auth.flow_state;
DROP TABLE auth.audit_log_entries;
DROP FUNCTION storage.update_updated_at_column();
DROP FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text);
DROP FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text);
DROP FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text);
DROP FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text);
DROP FUNCTION storage.prefixes_insert_trigger();
DROP FUNCTION storage.prefixes_delete_cleanup();
DROP FUNCTION storage.operation();
DROP FUNCTION storage.objects_update_prefix_trigger();
DROP FUNCTION storage.objects_update_level_trigger();
DROP FUNCTION storage.objects_update_cleanup();
DROP FUNCTION storage.objects_insert_prefix_trigger();
DROP FUNCTION storage.objects_delete_cleanup();
DROP FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]);
DROP FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text);
DROP FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text);
DROP FUNCTION storage.get_size_by_bucket();
DROP FUNCTION storage.get_prefixes(name text);
DROP FUNCTION storage.get_prefix(name text);
DROP FUNCTION storage.get_level(name text);
DROP FUNCTION storage.foldername(name text);
DROP FUNCTION storage.filename(name text);
DROP FUNCTION storage.extension(name text);
DROP FUNCTION storage.enforce_bucket_name_length();
DROP FUNCTION storage.delete_prefix_hierarchy_trigger();
DROP FUNCTION storage.delete_prefix(_bucket_id text, _name text);
DROP FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]);
DROP FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb);
DROP FUNCTION storage.add_prefixes(_bucket_id text, _name text);
DROP FUNCTION realtime.topic();
DROP FUNCTION realtime.to_regrole(role_name text);
DROP FUNCTION realtime.subscription_check_filters();
DROP FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean);
DROP FUNCTION realtime.quote_wal2json(entity regclass);
DROP FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer);
DROP FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]);
DROP FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text);
DROP FUNCTION realtime."cast"(val text, type_ regtype);
DROP FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]);
DROP FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text);
DROP FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer);
DROP FUNCTION public.update_updated_at_column();
DROP FUNCTION public.handle_new_user();
DROP FUNCTION pgbouncer.get_auth(p_usename text);
DROP FUNCTION extensions.set_graphql_placeholder();
DROP FUNCTION extensions.pgrst_drop_watch();
DROP FUNCTION extensions.pgrst_ddl_watch();
DROP FUNCTION extensions.grant_pg_net_access();
DROP FUNCTION extensions.grant_pg_graphql_access();
DROP FUNCTION extensions.grant_pg_cron_access();
DROP FUNCTION auth.uid();
DROP FUNCTION auth.role();
DROP FUNCTION auth.jwt();
DROP FUNCTION auth.email();
DROP TYPE storage.buckettype;
DROP TYPE realtime.wal_rls;
DROP TYPE realtime.wal_column;
DROP TYPE realtime.user_defined_filter;
DROP TYPE realtime.equality_op;
DROP TYPE realtime.action;
DROP TYPE public.user_role;
DROP TYPE public.redemption_status;
DROP TYPE public.points_reason;
DROP TYPE public.notification_type;
DROP TYPE public.mentor_status;
DROP TYPE auth.one_time_token_type;
DROP TYPE auth.oauth_response_type;
DROP TYPE auth.oauth_registration_type;
DROP TYPE auth.oauth_client_type;
DROP TYPE auth.oauth_authorization_status;
DROP TYPE auth.factor_type;
DROP TYPE auth.factor_status;
DROP TYPE auth.code_challenge_method;
DROP TYPE auth.aal_level;
DROP EXTENSION "uuid-ossp";
DROP EXTENSION supabase_vault;
DROP EXTENSION pgcrypto;
DROP EXTENSION pg_stat_statements;
DROP EXTENSION pg_graphql;
DROP SCHEMA vault;
DROP SCHEMA storage;
DROP SCHEMA realtime;
DROP SCHEMA pgbouncer;
DROP SCHEMA graphql_public;
DROP SCHEMA graphql;
DROP SCHEMA extensions;
DROP SCHEMA auth;
--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA auth;


--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA extensions;


--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql;


--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql_public;


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA pgbouncer;


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA realtime;


--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA storage;


--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA vault;


--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


--
-- Name: mentor_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.mentor_status AS ENUM (
    'pending',
    'onboarded',
    'declined'
);


--
-- Name: notification_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.notification_type AS ENUM (
    'onboarded',
    'info'
);


--
-- Name: points_reason; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.points_reason AS ENUM (
    'submission',
    'onboard'
);


--
-- Name: redemption_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.redemption_status AS ENUM (
    'placed',
    'delivered',
    'cancelled'
);


--
-- Name: user_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_role AS ENUM (
    'user',
    'super_admin',
    'CA',
    'CA TL',
    'TECH',
    'TECH TL'
);


--
-- Name: action; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: -
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS'
);


--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: -
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  INSERT INTO public.profiles (id, name, email, avatar_url, role)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1)),
    NEW.email,
    NEW.raw_user_meta_data->>'avatar_url',
    COALESCE((NEW.raw_user_meta_data->>'role')::user_role, 'user')
  );
  RETURN NEW;
END;
$$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


--
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


--
-- Name: delete_leaf_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_rows_deleted integer;
BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

        GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;
        EXIT WHEN v_rows_deleted = 0;
    END LOOP;
END;
$$;


--
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


--
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


--
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


--
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


--
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


--
-- Name: lock_top_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket text;
    v_top text;
BEGIN
    FOR v_bucket, v_top IN
        SELECT DISTINCT t.bucket_id,
            split_part(t.name, '/', 1) AS top
        FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        WHERE t.name <> ''
        ORDER BY 1, 2
        LOOP
            PERFORM pg_advisory_xact_lock(hashtextextended(v_bucket || '/' || v_top, 0));
        END LOOP;
END;
$$;


--
-- Name: objects_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


--
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


--
-- Name: objects_update_cleanup(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_update_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    -- NEW - OLD (destinations to create prefixes for)
    v_add_bucket_ids text[];
    v_add_names      text[];

    -- OLD - NEW (sources to prune)
    v_src_bucket_ids text[];
    v_src_names      text[];
BEGIN
    IF TG_OP <> 'UPDATE' THEN
        RETURN NULL;
    END IF;

    -- 1) Compute NEW−OLD (added paths) and OLD−NEW (moved-away paths)
    WITH added AS (
        SELECT n.bucket_id, n.name
        FROM new_rows n
        WHERE n.name <> '' AND position('/' in n.name) > 0
        EXCEPT
        SELECT o.bucket_id, o.name FROM old_rows o WHERE o.name <> ''
    ),
    moved AS (
         SELECT o.bucket_id, o.name
         FROM old_rows o
         WHERE o.name <> ''
         EXCEPT
         SELECT n.bucket_id, n.name FROM new_rows n WHERE n.name <> ''
    )
    SELECT
        -- arrays for ADDED (dest) in stable order
        COALESCE( (SELECT array_agg(a.bucket_id ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        COALESCE( (SELECT array_agg(a.name      ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        -- arrays for MOVED (src) in stable order
        COALESCE( (SELECT array_agg(m.bucket_id ORDER BY m.bucket_id, m.name) FROM moved m), '{}' ),
        COALESCE( (SELECT array_agg(m.name      ORDER BY m.bucket_id, m.name) FROM moved m), '{}' )
    INTO v_add_bucket_ids, v_add_names, v_src_bucket_ids, v_src_names;

    -- Nothing to do?
    IF (array_length(v_add_bucket_ids, 1) IS NULL) AND (array_length(v_src_bucket_ids, 1) IS NULL) THEN
        RETURN NULL;
    END IF;

    -- 2) Take per-(bucket, top) locks: ALL prefixes in consistent global order to prevent deadlocks
    DECLARE
        v_all_bucket_ids text[];
        v_all_names text[];
    BEGIN
        -- Combine source and destination arrays for consistent lock ordering
        v_all_bucket_ids := COALESCE(v_src_bucket_ids, '{}') || COALESCE(v_add_bucket_ids, '{}');
        v_all_names := COALESCE(v_src_names, '{}') || COALESCE(v_add_names, '{}');

        -- Single lock call ensures consistent global ordering across all transactions
        IF array_length(v_all_bucket_ids, 1) IS NOT NULL THEN
            PERFORM storage.lock_top_prefixes(v_all_bucket_ids, v_all_names);
        END IF;
    END;

    -- 3) Create destination prefixes (NEW−OLD) BEFORE pruning sources
    IF array_length(v_add_bucket_ids, 1) IS NOT NULL THEN
        WITH candidates AS (
            SELECT DISTINCT t.bucket_id, unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(v_add_bucket_ids, v_add_names) AS t(bucket_id, name)
            WHERE name <> ''
        )
        INSERT INTO storage.prefixes (bucket_id, name)
        SELECT c.bucket_id, c.name
        FROM candidates c
        ON CONFLICT DO NOTHING;
    END IF;

    -- 4) Prune source prefixes bottom-up for OLD−NEW
    IF array_length(v_src_bucket_ids, 1) IS NOT NULL THEN
        -- re-entrancy guard so DELETE on prefixes won't recurse
        IF current_setting('storage.gc.prefixes', true) <> '1' THEN
            PERFORM set_config('storage.gc.prefixes', '1', true);
        END IF;

        PERFORM storage.delete_leaf_prefixes(v_src_bucket_ids, v_src_names);
    END IF;

    RETURN NULL;
END;
$$;


--
-- Name: objects_update_level_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_update_level_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Set the new level
        NEW."level" := "storage"."get_level"(NEW."name");
    END IF;
    RETURN NEW;
END;
$$;


--
-- Name: objects_update_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_prefixes TEXT[];
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

        -- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

        -- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    END IF;
    -- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


--
-- Name: prefixes_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.prefixes_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


--
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


--
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


--
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    sort_col text;
    sort_ord text;
    cursor_op text;
    cursor_expr text;
    sort_expr text;
BEGIN
    -- Validate sort_order
    sort_ord := lower(sort_order);
    IF sort_ord NOT IN ('asc', 'desc') THEN
        sort_ord := 'asc';
    END IF;

    -- Determine cursor comparison operator
    IF sort_ord = 'asc' THEN
        cursor_op := '>';
    ELSE
        cursor_op := '<';
    END IF;
    
    sort_col := lower(sort_column);
    -- Validate sort column  
    IF sort_col IN ('updated_at', 'created_at') THEN
        cursor_expr := format(
            '($5 = '''' OR ROW(date_trunc(''milliseconds'', %I), name COLLATE "C") %s ROW(COALESCE(NULLIF($6, '''')::timestamptz, ''epoch''::timestamptz), $5))',
            sort_col, cursor_op
        );
        sort_expr := format(
            'COALESCE(date_trunc(''milliseconds'', %I), ''epoch''::timestamptz) %s, name COLLATE "C" %s',
            sort_col, sort_ord, sort_ord
        );
    ELSE
        cursor_expr := format('($5 = '''' OR name COLLATE "C" %s $5)', cursor_op);
        sort_expr := format('name COLLATE "C" %s', sort_ord);
    END IF;

    RETURN QUERY EXECUTE format(
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    NULL::uuid AS id,
                    updated_at,
                    created_at,
                    NULL::timestamptz AS last_accessed_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
            UNION ALL
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    id,
                    updated_at,
                    created_at,
                    last_accessed_at,
                    metadata
                FROM storage.objects
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
        ) obj
        ORDER BY %s
        LIMIT $3
        $sql$,
        cursor_expr,    -- prefixes WHERE
        sort_expr,      -- prefixes ORDER BY
        cursor_expr,    -- objects WHERE
        sort_expr,      -- objects ORDER BY
        sort_expr       -- final ORDER BY
    )
    USING prefix, bucket_name, limits, levels, start_after, sort_column_after;
END;
$_$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048))
);


--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: -
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: -
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid
);


--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: marketplace_products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marketplace_products (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    image_url text,
    points_price integer NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT marketplace_products_points_price_check CHECK ((points_price > 0)),
    CONSTRAINT marketplace_products_stock_check CHECK ((stock >= 0))
);


--
-- Name: mentors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mentors (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_by_user_id uuid NOT NULL,
    mentor_name text NOT NULL,
    linkedin_url text NOT NULL,
    phone text,
    email text,
    domain text NOT NULL,
    experience_years integer NOT NULL,
    previous_domain text,
    status public.mentor_status DEFAULT 'pending'::public.mentor_status NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    edited_by_user_id uuid,
    CONSTRAINT mentors_experience_years_check CHECK ((experience_years >= 0))
);


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    type public.notification_type NOT NULL,
    title text NOT NULL,
    message text NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: points_ledger; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.points_ledger (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    mentor_id uuid NOT NULL,
    delta integer NOT NULL,
    reason public.points_reason NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    avatar_url text,
    role public.user_role DEFAULT 'user'::public.user_role NOT NULL,
    points_total integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: redemptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.redemptions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    product_id uuid NOT NULL,
    points_cost integer NOT NULL,
    status public.redemption_status DEFAULT 'placed'::public.redemption_status NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


--
-- Name: messages_2025_10_28; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_10_28 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2025_10_29; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_10_29 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2025_10_30; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_10_30 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2025_10_31; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_10_31 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2025_11_01; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_11_01 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2025_11_02; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_11_02 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2025_11_03; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_11_03 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: -
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets_analytics (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: objects; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: messages_2025_10_28; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_10_28 FOR VALUES FROM ('2025-10-28 00:00:00') TO ('2025-10-29 00:00:00');


--
-- Name: messages_2025_10_29; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_10_29 FOR VALUES FROM ('2025-10-29 00:00:00') TO ('2025-10-30 00:00:00');


--
-- Name: messages_2025_10_30; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_10_30 FOR VALUES FROM ('2025-10-30 00:00:00') TO ('2025-10-31 00:00:00');


--
-- Name: messages_2025_10_31; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_10_31 FOR VALUES FROM ('2025-10-31 00:00:00') TO ('2025-11-01 00:00:00');


--
-- Name: messages_2025_11_01; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_11_01 FOR VALUES FROM ('2025-11-01 00:00:00') TO ('2025-11-02 00:00:00');


--
-- Name: messages_2025_11_02; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_11_02 FOR VALUES FROM ('2025-11-02 00:00:00') TO ('2025-11-03 00:00:00');


--
-- Name: messages_2025_11_03; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_11_03 FOR VALUES FROM ('2025-11-03 00:00:00') TO ('2025-11-04 00:00:00');


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	5f37f660-ca1c-4a9c-8555-4d239485ed38	{"action":"user_confirmation_requested","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-25 13:47:34.93979+00	
00000000-0000-0000-0000-000000000000	ee9da303-81af-447a-93b8-b4eaffcfb935	{"action":"user_signedup","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-25 13:47:47.153054+00	
00000000-0000-0000-0000-000000000000	7c3a0792-6061-4bcb-bed6-1cef5ca24c39	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-25 13:47:55.047021+00	
00000000-0000-0000-0000-000000000000	22050b5d-bc93-4d92-adfc-c341c9281e63	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-25 14:35:33.566796+00	
00000000-0000-0000-0000-000000000000	7597830d-74f3-4ee5-be09-edb865173171	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-25 14:38:43.345556+00	
00000000-0000-0000-0000-000000000000	56916068-b276-4593-90bc-154d8b46c1a3	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-25 14:39:03.514377+00	
00000000-0000-0000-0000-000000000000	da412fc5-04ce-4a54-b41a-6e8ffc48f2f8	{"action":"user_confirmation_requested","actor_id":"9afd46bb-fc79-423e-a2da-a05c369f4b5b","actor_username":"applywizztechportfolios@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-25 14:39:39.967034+00	
00000000-0000-0000-0000-000000000000	4f6184db-eaf9-46cd-9cbf-1aa7b6a9792e	{"action":"user_signedup","actor_id":"9afd46bb-fc79-423e-a2da-a05c369f4b5b","actor_username":"applywizztechportfolios@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-25 14:39:53.160484+00	
00000000-0000-0000-0000-000000000000	4d9af1c6-00e3-4eb6-8f3d-98b186e198b6	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-25 14:40:37.037681+00	
00000000-0000-0000-0000-000000000000	417d558f-ace3-41d2-8bc5-bd9132069b53	{"action":"logout","actor_id":"9afd46bb-fc79-423e-a2da-a05c369f4b5b","actor_username":"applywizztechportfolios@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-25 14:42:30.772423+00	
00000000-0000-0000-0000-000000000000	8364b954-4b80-429e-9e5e-f30f55d2efb8	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-25 14:43:21.846006+00	
00000000-0000-0000-0000-000000000000	44a8d432-7a99-4e81-8862-0ec5e8d7b5e6	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-25 14:43:26.8383+00	
00000000-0000-0000-0000-000000000000	a6ee6b01-1b9f-4c83-b1f4-0a86242c2449	{"action":"user_confirmation_requested","actor_id":"258cd4e6-15b7-4845-83ac-0c64aca2b03b","actor_username":"nikhil@applywizz.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-25 14:44:05.754675+00	
00000000-0000-0000-0000-000000000000	d7797652-6432-47e9-bd60-f2d3795d7eb8	{"action":"user_signedup","actor_id":"258cd4e6-15b7-4845-83ac-0c64aca2b03b","actor_username":"nikhil@applywizz.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-25 14:45:11.263911+00	
00000000-0000-0000-0000-000000000000	77c6b355-aca3-432a-88af-46e4be5b140e	{"action":"login","actor_id":"258cd4e6-15b7-4845-83ac-0c64aca2b03b","actor_username":"nikhil@applywizz.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-25 14:45:28.132361+00	
00000000-0000-0000-0000-000000000000	2951b2e7-885d-4f62-aa15-7f02be003f28	{"action":"user_confirmation_requested","actor_id":"c691f7b7-a46a-4ba3-bfd4-3fcebd27d1eb","actor_username":"tunguturidineshkumar@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-27 06:29:48.837062+00	
00000000-0000-0000-0000-000000000000	7b80c9ad-a5a2-40a0-bdc9-2d640fd15568	{"action":"user_signedup","actor_id":"c691f7b7-a46a-4ba3-bfd4-3fcebd27d1eb","actor_username":"tunguturidineshkumar@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-27 06:30:07.470742+00	
00000000-0000-0000-0000-000000000000	2b90c5d2-e341-43d5-ade6-df502d9247f7	{"action":"login","actor_id":"c691f7b7-a46a-4ba3-bfd4-3fcebd27d1eb","actor_username":"tunguturidineshkumar@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 06:30:16.31867+00	
00000000-0000-0000-0000-000000000000	4966121c-f5bc-42d5-8a4f-bf5b23e1e608	{"action":"logout","actor_id":"c691f7b7-a46a-4ba3-bfd4-3fcebd27d1eb","actor_username":"tunguturidineshkumar@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-27 06:30:35.699949+00	
00000000-0000-0000-0000-000000000000	d91ff44c-5527-4612-9d30-88101ea2e1ea	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nikhil@applywizz.com","user_id":"258cd4e6-15b7-4845-83ac-0c64aca2b03b","user_phone":""}}	2025-10-27 06:35:52.582248+00	
00000000-0000-0000-0000-000000000000	1bbee72b-5223-44c1-8271-3adeca0b9c07	{"action":"user_confirmation_requested","actor_id":"e3037ffc-a058-45e2-8a74-e0602abfdc74","actor_username":"nikhilerroju1111@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-27 06:37:11.207295+00	
00000000-0000-0000-0000-000000000000	d72d54af-9aaf-4a9e-92f5-4d84625523b4	{"action":"user_signedup","actor_id":"e3037ffc-a058-45e2-8a74-e0602abfdc74","actor_username":"nikhilerroju1111@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-27 06:39:56.637238+00	
00000000-0000-0000-0000-000000000000	d1da6a49-d111-4876-b7a3-8b90da23500d	{"action":"login","actor_id":"e3037ffc-a058-45e2-8a74-e0602abfdc74","actor_username":"nikhilerroju1111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 06:40:08.486627+00	
00000000-0000-0000-0000-000000000000	7fef695d-93d5-48ca-976e-80399ee82317	{"action":"logout","actor_id":"e3037ffc-a058-45e2-8a74-e0602abfdc74","actor_username":"nikhilerroju1111@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-27 07:00:38.191275+00	
00000000-0000-0000-0000-000000000000	6a457bfc-1431-4a1f-97ae-f509cc9725b0	{"action":"user_confirmation_requested","actor_id":"0fe7b3ed-6851-42c2-a922-0fd6bec27dd1","actor_username":"nithinuuerrojuu@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-27 07:16:17.757957+00	
00000000-0000-0000-0000-000000000000	48e73c00-c21d-46da-a5af-5c276818b6f2	{"action":"user_signedup","actor_id":"0fe7b3ed-6851-42c2-a922-0fd6bec27dd1","actor_username":"nithinuuerrojuu@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-27 07:16:31.221235+00	
00000000-0000-0000-0000-000000000000	08e03506-f5be-4f62-bb87-99ee73a112a0	{"action":"user_confirmation_requested","actor_id":"eb75bcfb-dc2b-41da-8b75-c08a54d26d29","actor_username":"ganeshgummadidila8@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-27 07:30:32.936791+00	
00000000-0000-0000-0000-000000000000	06f8ba2c-1449-451c-9ecf-25a4353da540	{"action":"user_confirmation_requested","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-27 07:51:07.91357+00	
00000000-0000-0000-0000-000000000000	88fda81c-7895-42e4-bd42-2b3ad35a04d4	{"action":"user_signedup","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-27 07:51:35.024658+00	
00000000-0000-0000-0000-000000000000	97643b97-98e3-437f-a0b8-703f7a8fb997	{"action":"login","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 07:51:37.972018+00	
00000000-0000-0000-0000-000000000000	98c1fc31-4f5a-456d-8640-4576676e540d	{"action":"user_repeated_signup","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-27 08:04:57.89157+00	
00000000-0000-0000-0000-000000000000	3b59ce5f-3ffa-40be-bdec-080d43e842b0	{"action":"token_refreshed","actor_id":"0fe7b3ed-6851-42c2-a922-0fd6bec27dd1","actor_username":"nithinuuerrojuu@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 08:15:04.454831+00	
00000000-0000-0000-0000-000000000000	de627238-8790-45ff-aca7-8cb6a002d10e	{"action":"token_revoked","actor_id":"0fe7b3ed-6851-42c2-a922-0fd6bec27dd1","actor_username":"nithinuuerrojuu@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 08:15:04.45998+00	
00000000-0000-0000-0000-000000000000	90f89bad-3ff3-42c4-8567-913256d9a9db	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 08:20:54.006982+00	
00000000-0000-0000-0000-000000000000	759d2994-c4c5-473a-9955-e7d4e31acb19	{"action":"token_refreshed","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 09:12:32.944529+00	
00000000-0000-0000-0000-000000000000	1356d217-55b1-4225-b4ec-0fef0ce2bdba	{"action":"token_revoked","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 09:12:32.969599+00	
00000000-0000-0000-0000-000000000000	1c78a1de-626f-42cb-8565-34197a1a8c83	{"action":"logout","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-27 09:13:08.828107+00	
00000000-0000-0000-0000-000000000000	eebd64d1-7488-4f9d-bdfe-da11596dc70b	{"action":"token_refreshed","actor_id":"0fe7b3ed-6851-42c2-a922-0fd6bec27dd1","actor_username":"nithinuuerrojuu@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 09:13:52.652051+00	
00000000-0000-0000-0000-000000000000	73a9a2a8-62de-4afa-8892-385358e0eb29	{"action":"token_revoked","actor_id":"0fe7b3ed-6851-42c2-a922-0fd6bec27dd1","actor_username":"nithinuuerrojuu@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 09:13:52.655389+00	
00000000-0000-0000-0000-000000000000	0bddf83c-6028-4d31-892a-31da7444fcd6	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 09:14:01.153307+00	
00000000-0000-0000-0000-000000000000	26ed33ed-fd87-426c-83fe-d708cc5d1aaa	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-27 09:20:07.886123+00	
00000000-0000-0000-0000-000000000000	8c91a9bf-50ea-44f3-ac6c-20f4416846ee	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 09:20:10.508901+00	
00000000-0000-0000-0000-000000000000	95021534-6506-44ba-ab7a-9db2bfd62bd5	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 09:54:06.157299+00	
00000000-0000-0000-0000-000000000000	908b72e2-4dbb-4a7e-9cdb-2fd88a173328	{"action":"token_refreshed","actor_id":"0fe7b3ed-6851-42c2-a922-0fd6bec27dd1","actor_username":"nithinuuerrojuu@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 10:12:41.124756+00	
00000000-0000-0000-0000-000000000000	ca693d86-80b7-4d1d-bc3e-fde5f9e18348	{"action":"token_revoked","actor_id":"0fe7b3ed-6851-42c2-a922-0fd6bec27dd1","actor_username":"nithinuuerrojuu@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 10:12:41.131818+00	
00000000-0000-0000-0000-000000000000	f3b06480-eeff-4952-acb1-1a509c4bd6d8	{"action":"token_refreshed","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 10:20:42.208948+00	
00000000-0000-0000-0000-000000000000	7ed2aef6-7cd2-4e4c-aa4a-7495fab97034	{"action":"token_revoked","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 10:20:42.215835+00	
00000000-0000-0000-0000-000000000000	33df4203-9f4d-40d1-95c6-ddfc1a5ff988	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-27 10:44:35.484617+00	
00000000-0000-0000-0000-000000000000	f3f40c62-cc2a-43ab-aaab-8d6f7b5ae68b	{"action":"user_confirmation_requested","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-27 10:45:31.66891+00	
00000000-0000-0000-0000-000000000000	71ee7d66-c8f0-4201-9f36-4897cf0d4f37	{"action":"user_signedup","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-27 10:47:09.11621+00	
00000000-0000-0000-0000-000000000000	25187199-02aa-42a1-8f6b-d8e7aa76befc	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 10:47:23.089749+00	
00000000-0000-0000-0000-000000000000	c91fda01-f6fb-47a6-ace9-4e269db7702a	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-27 10:47:30.09527+00	
00000000-0000-0000-0000-000000000000	ead04c6d-c5c9-499d-97a4-45efbb830a8d	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 10:47:51.463545+00	
00000000-0000-0000-0000-000000000000	ef5c85a8-3887-438f-b722-31ef5fdb1295	{"action":"token_refreshed","actor_id":"0fe7b3ed-6851-42c2-a922-0fd6bec27dd1","actor_username":"nithinuuerrojuu@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 11:12:06.918034+00	
00000000-0000-0000-0000-000000000000	c4a7640e-ddf6-45e6-ada7-6f2c03d572c7	{"action":"token_revoked","actor_id":"0fe7b3ed-6851-42c2-a922-0fd6bec27dd1","actor_username":"nithinuuerrojuu@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 11:12:06.930435+00	
00000000-0000-0000-0000-000000000000	64d26f56-74cf-4eec-814a-0fc9d5a9769c	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-27 11:13:18.034655+00	
00000000-0000-0000-0000-000000000000	66aa20ff-6585-4ccc-8263-f14c1f1e7513	{"action":"login","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 11:14:20.128324+00	
00000000-0000-0000-0000-000000000000	edc8acb0-841c-47f3-bf86-896e7198e4a9	{"action":"logout","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-27 11:20:09.596048+00	
00000000-0000-0000-0000-000000000000	29f0c3c3-331f-42ff-887a-6177de07d701	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 11:20:59.94578+00	
00000000-0000-0000-0000-000000000000	7ddb6708-9556-415c-9022-c5ac3976d268	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-27 11:43:11.971534+00	
00000000-0000-0000-0000-000000000000	e2a13f1b-0178-4f39-a4ad-0598cc0044cf	{"action":"login","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 11:43:46.142044+00	
00000000-0000-0000-0000-000000000000	d8c37d9e-3afd-4ae2-baca-859bc20ef499	{"action":"logout","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-27 11:45:34.037853+00	
00000000-0000-0000-0000-000000000000	533c1ba8-9a2c-4975-9a90-31611a1601a4	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 11:45:55.579348+00	
00000000-0000-0000-0000-000000000000	47c84533-04fb-4a8f-844b-a851c42a63fb	{"action":"token_refreshed","actor_id":"0fe7b3ed-6851-42c2-a922-0fd6bec27dd1","actor_username":"nithinuuerrojuu@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 12:11:05.685034+00	
00000000-0000-0000-0000-000000000000	5fe4fba9-826e-4a3d-aa29-b618d4247961	{"action":"token_revoked","actor_id":"0fe7b3ed-6851-42c2-a922-0fd6bec27dd1","actor_username":"nithinuuerrojuu@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 12:11:05.704019+00	
00000000-0000-0000-0000-000000000000	53b697e1-3f4a-41ca-98ee-e24de801c68e	{"action":"token_refreshed","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 12:59:26.830264+00	
00000000-0000-0000-0000-000000000000	27192672-24ca-4048-8813-1ac0af9bbb8f	{"action":"token_revoked","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 12:59:26.849103+00	
00000000-0000-0000-0000-000000000000	277937e3-a01b-4e33-8cf3-431aa793be89	{"action":"token_refreshed","actor_id":"0fe7b3ed-6851-42c2-a922-0fd6bec27dd1","actor_username":"nithinuuerrojuu@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 13:10:06.563876+00	
00000000-0000-0000-0000-000000000000	b818eef9-0f06-45a1-9e5d-4b02b5393ef8	{"action":"token_revoked","actor_id":"0fe7b3ed-6851-42c2-a922-0fd6bec27dd1","actor_username":"nithinuuerrojuu@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 13:10:06.573402+00	
00000000-0000-0000-0000-000000000000	93afeafc-cb77-4a02-9cd5-9983da5e634c	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 13:23:45.322638+00	
00000000-0000-0000-0000-000000000000	d0518d89-4f38-40c6-9b76-75dbd897342f	{"action":"token_refreshed","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 14:22:16.561338+00	
00000000-0000-0000-0000-000000000000	34e9b316-2715-4770-ba03-c7bef479f0ea	{"action":"token_revoked","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-27 14:22:16.576032+00	
00000000-0000-0000-0000-000000000000	280aa81d-17b2-493f-ad3e-056c8d621042	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-27 14:24:02.828701+00	
00000000-0000-0000-0000-000000000000	0bebd866-e192-4dad-a4c4-4e047fab568b	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 14:25:55.50403+00	
00000000-0000-0000-0000-000000000000	afee8cd7-81ce-45a3-877a-612c60a57fcc	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-27 14:32:54.331416+00	
00000000-0000-0000-0000-000000000000	1c35b28d-90fe-4287-8e4a-f2a6a91a85de	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-27 14:33:18.998051+00	
00000000-0000-0000-0000-000000000000	cbe7eeaa-b022-4897-b33e-2549f543c85c	{"action":"token_refreshed","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 05:06:58.221358+00	
00000000-0000-0000-0000-000000000000	7a6a7dd4-781e-4c95-885f-ec7296521af7	{"action":"token_revoked","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 05:06:58.248323+00	
00000000-0000-0000-0000-000000000000	b27620f9-5804-41c6-908b-dda324cb8f03	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-28 05:17:43.745557+00	
00000000-0000-0000-0000-000000000000	f3ae89d9-9546-44e7-8aaa-ec5b42ac40bf	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-28 11:35:15.434476+00	
00000000-0000-0000-0000-000000000000	bc1c40ef-41f4-454a-b8ea-a129ab671249	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-28 11:39:38.699953+00	
00000000-0000-0000-0000-000000000000	6cf89113-e60f-464b-875b-263770dc021e	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-28 11:39:51.88268+00	
00000000-0000-0000-0000-000000000000	a235d3aa-ae2b-421a-b926-8cd98197c700	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-28 11:47:07.426339+00	
00000000-0000-0000-0000-000000000000	1221ccce-a0e5-4156-8c1f-29993cc01a5c	{"action":"login","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-28 11:47:18.279366+00	
00000000-0000-0000-0000-000000000000	b8c7ae6f-29f4-414e-96f8-ae969956b72f	{"action":"logout","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-28 11:49:35.655976+00	
00000000-0000-0000-0000-000000000000	c961468c-b75d-40dd-b46e-d191772b89b6	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-28 11:49:53.190422+00	
00000000-0000-0000-0000-000000000000	85d00c14-c18a-41f8-84f8-8dadc03c768f	{"action":"token_refreshed","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 12:58:38.525522+00	
00000000-0000-0000-0000-000000000000	943476e1-1b78-47cf-8352-79b4477cf063	{"action":"token_revoked","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-28 12:58:38.548936+00	
00000000-0000-0000-0000-000000000000	ab854c9f-596b-4656-8e26-c8fd5a47c037	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-28 13:26:54.210955+00	
00000000-0000-0000-0000-000000000000	803c0214-3ca9-425f-877d-2b851d379c0d	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-28 13:28:27.528659+00	
00000000-0000-0000-0000-000000000000	40cc279e-8341-4863-9b6a-b7f3b0b20ae2	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-28 14:01:14.326894+00	
00000000-0000-0000-0000-000000000000	27c8d55b-aedd-4bd4-9dac-250450dd3e6e	{"action":"login","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-28 14:01:31.222647+00	
00000000-0000-0000-0000-000000000000	07ebad68-3304-4bc8-b31f-96c9fb072d04	{"action":"logout","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-28 14:08:26.873601+00	
00000000-0000-0000-0000-000000000000	8223bcc8-db97-4c28-9557-508329c5d7e6	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-28 14:08:44.866546+00	
00000000-0000-0000-0000-000000000000	5681a0f3-fd44-4c44-a6a6-aa16900c0303	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-28 14:10:53.603284+00	
00000000-0000-0000-0000-000000000000	b64822dc-3263-4fbf-941e-ca4ac3894479	{"action":"login","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-28 14:11:08.162556+00	
00000000-0000-0000-0000-000000000000	33e580f1-a5b2-435b-94c8-e46337fa83e8	{"action":"logout","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-28 14:32:13.680876+00	
00000000-0000-0000-0000-000000000000	effd4340-df4c-4e51-9be0-2b1631d9c0ee	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-28 14:32:26.301909+00	
00000000-0000-0000-0000-000000000000	1ae7691e-6880-4de1-80a0-71dbadae04f4	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-28 14:42:29.468553+00	
00000000-0000-0000-0000-000000000000	4811eb28-0671-4af9-931f-3d903528e6c4	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-28 14:42:49.019644+00	
00000000-0000-0000-0000-000000000000	7f795b2f-215d-4ad0-956c-b0f0cc91fbd1	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-28 14:44:33.405227+00	
00000000-0000-0000-0000-000000000000	b110047f-8ca6-4cf8-9897-ca1d71cb191a	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-28 14:44:53.732986+00	
00000000-0000-0000-0000-000000000000	5a600c6f-cfad-4ddd-8f83-77b649fb436e	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-28 14:46:27.423588+00	
00000000-0000-0000-0000-000000000000	0d780b4b-dc10-47a7-a87b-4ed93f6d995a	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-28 14:46:33.109835+00	
00000000-0000-0000-0000-000000000000	be935448-37ea-461c-bdd9-fb836eb4a55a	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-28 14:48:21.387165+00	
00000000-0000-0000-0000-000000000000	40a4947d-ad99-4bb5-80aa-30c6ceb041a0	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-28 14:48:35.828635+00	
00000000-0000-0000-0000-000000000000	8c696869-8a66-4068-bb16-06ce83cbb5be	{"action":"token_refreshed","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 15:19:16.192174+00	
00000000-0000-0000-0000-000000000000	1e9040bc-b49b-49a5-9b2b-fa03857234fe	{"action":"token_revoked","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-29 15:19:16.215504+00	
00000000-0000-0000-0000-000000000000	2212b848-d63b-4fb7-a39b-181081781c8c	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-29 15:21:33.958532+00	
00000000-0000-0000-0000-000000000000	bc00e4b9-230c-48b3-9793-bcbb655e0915	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-29 15:21:38.075758+00	
00000000-0000-0000-0000-000000000000	e1ef3f51-6f32-4717-a8d2-e4eb2a9a13ed	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-29 15:27:29.680207+00	
00000000-0000-0000-0000-000000000000	1a7b1607-076b-441b-b5cd-0d05e89a7441	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-29 15:27:43.379205+00	
00000000-0000-0000-0000-000000000000	e9527a7e-cb5a-4881-a3ec-2347a7016848	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-29 15:29:27.249412+00	
00000000-0000-0000-0000-000000000000	d2cb1ebe-5cf5-4b4a-8ea4-6c37a7370a9e	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-29 15:29:32.195023+00	
00000000-0000-0000-0000-000000000000	27771e9f-5e18-44cd-ac40-dfa93a4e5dd0	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-29 15:38:01.47934+00	
00000000-0000-0000-0000-000000000000	3cf9b009-972d-4271-ab82-8c9c7fbca108	{"action":"login","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-29 15:38:19.678222+00	
00000000-0000-0000-0000-000000000000	a3e88ad0-51e7-4bf9-a6b8-9c2e006fb436	{"action":"logout","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-29 15:39:03.667404+00	
00000000-0000-0000-0000-000000000000	eda6e35a-448e-420b-9124-d05148cdb426	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-29 15:39:25.678441+00	
00000000-0000-0000-0000-000000000000	a90d97a7-b174-4fe6-9967-c210467baa43	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 06:32:44.005334+00	
00000000-0000-0000-0000-000000000000	45aedb5e-62ad-47e0-a652-e5b0248aaa03	{"action":"token_refreshed","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 07:31:38.541171+00	
00000000-0000-0000-0000-000000000000	9b225bcc-1434-4e49-acb3-520e50387f2f	{"action":"token_revoked","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 07:31:38.559404+00	
00000000-0000-0000-0000-000000000000	770a42a5-0275-4a26-9c08-0df7b44b4408	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 08:00:00.223865+00	
00000000-0000-0000-0000-000000000000	29e2392b-d536-4cba-8911-9752d129601c	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 08:00:09.091358+00	
00000000-0000-0000-0000-000000000000	4ae7b919-151a-494b-8266-0442f2405773	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 08:02:55.928818+00	
00000000-0000-0000-0000-000000000000	bc345492-4f21-42e8-8f26-14507f568a0c	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 08:03:02.706703+00	
00000000-0000-0000-0000-000000000000	413b8de6-e3a6-4038-b31c-2319396ae8d7	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 08:19:20.316604+00	
00000000-0000-0000-0000-000000000000	effad6ba-3185-4388-b104-b0fda3fb9d9c	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 08:19:28.076632+00	
00000000-0000-0000-0000-000000000000	98ff92e5-9d6b-4da7-a4b2-cf98e61c29e3	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 08:24:23.387978+00	
00000000-0000-0000-0000-000000000000	63302320-7e56-4182-9c50-019fc94084bd	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 08:24:30.637811+00	
00000000-0000-0000-0000-000000000000	3997601d-9b57-4952-b651-b6ccde39449a	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 09:01:24.518478+00	
00000000-0000-0000-0000-000000000000	3f88a6d1-c05a-4995-b761-71c45d96af32	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 09:01:31.51054+00	
00000000-0000-0000-0000-000000000000	7b8d17a5-cd9f-4d16-957f-572f5b16f8b3	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 09:02:23.181283+00	
00000000-0000-0000-0000-000000000000	58c6a7cc-b490-4e16-b76e-ed0a58e398bb	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 09:02:30.523751+00	
00000000-0000-0000-0000-000000000000	eee9e4ca-d847-4194-b07e-263594c10813	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 09:02:56.096801+00	
00000000-0000-0000-0000-000000000000	8082b00c-4380-4218-9ede-a189bc903a2d	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 09:03:03.377113+00	
00000000-0000-0000-0000-000000000000	e145acba-b513-4117-84e6-b103cb198248	{"action":"token_refreshed","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 10:01:45.560347+00	
00000000-0000-0000-0000-000000000000	82974b09-c30d-44f8-9f95-05da7d680731	{"action":"token_revoked","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 10:01:45.578131+00	
00000000-0000-0000-0000-000000000000	f612702e-74ca-497a-bdc4-89a078f57161	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 10:03:50.376905+00	
00000000-0000-0000-0000-000000000000	674279f5-6b87-4bba-ae6b-0da47249a2e4	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 10:03:59.414697+00	
00000000-0000-0000-0000-000000000000	464258d6-6351-4794-bc3e-a7055eaded60	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 10:08:20.826028+00	
00000000-0000-0000-0000-000000000000	51611082-4c92-42b5-bd51-3f96e7e2d5d8	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 10:08:26.307299+00	
00000000-0000-0000-0000-000000000000	9a66e9ce-c434-4eb3-ab5a-76eb2b3ddd6c	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 10:10:09.341141+00	
00000000-0000-0000-0000-000000000000	969000b0-e0f2-48b8-b94e-f0c5a5156b6d	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 10:10:17.360115+00	
00000000-0000-0000-0000-000000000000	7cd592eb-760f-4b56-a37d-3335e6cf9543	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 10:11:03.009338+00	
00000000-0000-0000-0000-000000000000	e03f5b81-3001-4ab7-a75b-bf22e0a0eb2d	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 10:11:09.627242+00	
00000000-0000-0000-0000-000000000000	c57b23cd-2349-46db-a753-8973c97f3bbb	{"action":"token_refreshed","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 11:53:10.125929+00	
00000000-0000-0000-0000-000000000000	020bae08-d283-423c-99cd-fc96119ac501	{"action":"token_revoked","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 11:53:10.152776+00	
00000000-0000-0000-0000-000000000000	2a89a267-e58c-462d-8e22-aa0cb17f6016	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 11:53:55.297511+00	
00000000-0000-0000-0000-000000000000	e5eba888-2553-4cc0-b046-d73aa8595e37	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 11:54:12.952845+00	
00000000-0000-0000-0000-000000000000	1ea9a9b6-7062-4aec-be0b-2d4434e0b1e2	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 11:59:59.087035+00	
00000000-0000-0000-0000-000000000000	16a19d99-af22-4493-a1f3-b6b637a4f71a	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 12:00:04.362956+00	
00000000-0000-0000-0000-000000000000	efa2ac81-3142-42d1-be9d-8e3d16ca5a05	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 12:07:57.090426+00	
00000000-0000-0000-0000-000000000000	ef2ae66b-8eae-4bd2-b144-f80e8c53fe71	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 12:08:04.625496+00	
00000000-0000-0000-0000-000000000000	9fad02b2-9af5-4028-8dcf-8cf9e3352f07	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 12:11:10.826048+00	
00000000-0000-0000-0000-000000000000	92df5a79-ce90-4217-a24d-0a084ff51b30	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 12:11:18.702348+00	
00000000-0000-0000-0000-000000000000	37c31c82-de37-420c-8c01-46e672d2e834	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 12:13:10.564897+00	
00000000-0000-0000-0000-000000000000	9a83dd02-4000-4bbd-a831-f542c0e1e75d	{"action":"login","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 12:13:18.368028+00	
00000000-0000-0000-0000-000000000000	9ae4cd57-ad2d-4e88-8797-ed75811d9401	{"action":"logout","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 12:15:59.516188+00	
00000000-0000-0000-0000-000000000000	9340e33f-0064-461c-ab56-c0ae99c6341f	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 12:16:04.466475+00	
00000000-0000-0000-0000-000000000000	af6c60e3-9c50-40e2-a317-54fb8688eee5	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 12:33:50.603673+00	
00000000-0000-0000-0000-000000000000	3bf43b57-770e-48fd-b419-9f748e4e7e34	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 12:36:04.712654+00	
00000000-0000-0000-0000-000000000000	e7da4dd2-576d-45f1-8919-c25be27b1615	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 12:37:02.407592+00	
00000000-0000-0000-0000-000000000000	d7d45993-de59-4da9-9258-dd9e563353fd	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 12:37:08.107159+00	
00000000-0000-0000-0000-000000000000	6aad9108-8c21-4ea5-aaf6-c4e43eb50cdb	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 13:05:50.509832+00	
00000000-0000-0000-0000-000000000000	8beefb8a-4a85-4fed-beff-d64d7cbfdf73	{"action":"login","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 13:05:58.881617+00	
00000000-0000-0000-0000-000000000000	d02da0fb-336e-4e03-bfc5-aa49e65a0eaa	{"action":"logout","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-30 13:29:09.649117+00	
00000000-0000-0000-0000-000000000000	92d6ae4a-00cc-4c1a-af2e-6f666433eb57	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-30 13:29:14.402362+00	
00000000-0000-0000-0000-000000000000	659c262e-2403-4629-8e12-c507d7c6c0f8	{"action":"token_refreshed","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 14:27:57.896567+00	
00000000-0000-0000-0000-000000000000	35ae532c-b04f-4f45-85bf-dad145e7e373	{"action":"token_revoked","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-30 14:27:57.918965+00	
00000000-0000-0000-0000-000000000000	e596a74d-ec33-4572-8e2c-8f2bca4051b6	{"action":"token_refreshed","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-31 05:59:56.525324+00	
00000000-0000-0000-0000-000000000000	f0ea2ba6-e266-4c7f-a15f-0fc2f5601d23	{"action":"token_revoked","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-31 05:59:56.550685+00	
00000000-0000-0000-0000-000000000000	17b92dd5-9b06-4258-9065-5aace3867756	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 06:00:01.906451+00	
00000000-0000-0000-0000-000000000000	6ed830a3-c7e4-4187-9959-9759b75d3df8	{"action":"user_confirmation_requested","actor_id":"833225b9-e71f-4255-ab42-a3f4515e7038","actor_username":"nikhil@applywizz.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-31 06:01:03.35603+00	
00000000-0000-0000-0000-000000000000	53ac965d-92b7-45f9-9a40-6c68c1c5e917	{"action":"user_signedup","actor_id":"833225b9-e71f-4255-ab42-a3f4515e7038","actor_username":"nikhil@applywizz.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-31 06:02:31.618571+00	
00000000-0000-0000-0000-000000000000	35804195-47b9-471d-8b02-b0d90fecd4bf	{"action":"user_repeated_signup","actor_id":"833225b9-e71f-4255-ab42-a3f4515e7038","actor_username":"nikhil@applywizz.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-31 06:15:27.35611+00	
00000000-0000-0000-0000-000000000000	53c241ac-08ec-4334-a4ac-63aa8befcdc8	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"nikhil@applywizz.com","user_id":"833225b9-e71f-4255-ab42-a3f4515e7038","user_phone":""}}	2025-10-31 06:17:18.861546+00	
00000000-0000-0000-0000-000000000000	2a8f23ae-754d-4c05-b623-343d2146a2f9	{"action":"user_confirmation_requested","actor_id":"0243cf1c-0067-4a31-bb9a-6d0d8e1929cb","actor_username":"nikhil@applywizz.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-10-31 06:17:29.48069+00	
00000000-0000-0000-0000-000000000000	8b248af1-6843-484e-a389-252d1646fe98	{"action":"user_signedup","actor_id":"0243cf1c-0067-4a31-bb9a-6d0d8e1929cb","actor_username":"nikhil@applywizz.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-10-31 06:17:45.227573+00	
00000000-0000-0000-0000-000000000000	3def69db-cd0e-42d7-996d-8885a11bda54	{"action":"login","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 06:24:48.675441+00	
00000000-0000-0000-0000-000000000000	e0066943-1ed9-4ef6-b319-a0bcd71dbc0b	{"action":"logout","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 06:25:03.972035+00	
00000000-0000-0000-0000-000000000000	2ac17803-3316-44c6-9834-c729e4e39007	{"action":"login","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 07:16:36.217128+00	
00000000-0000-0000-0000-000000000000	9a1fe8db-c355-4752-9e99-ffb2e7b9939f	{"action":"logout","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 07:16:55.126844+00	
00000000-0000-0000-0000-000000000000	193f3ed8-13ee-4be0-a50b-8a12e4a7c4e3	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 07:17:02.793344+00	
00000000-0000-0000-0000-000000000000	6c7c3264-72bf-4612-81ec-4a17f6a58000	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 07:17:58.901602+00	
00000000-0000-0000-0000-000000000000	cb40e02e-98e0-46a3-bc94-057811efece8	{"action":"login","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 07:18:06.191069+00	
00000000-0000-0000-0000-000000000000	79eff875-02a8-4900-bc29-5c9eaa6e1e83	{"action":"logout","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 07:19:00.879871+00	
00000000-0000-0000-0000-000000000000	c3268de8-d74c-4a88-bc1e-0eb883ff984f	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 07:19:07.134228+00	
00000000-0000-0000-0000-000000000000	db77ab94-55ce-44d8-bcc2-debd55055ef1	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 07:23:30.389227+00	
00000000-0000-0000-0000-000000000000	8014bfb0-3910-4830-b6dc-7090715cbb0e	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 07:23:38.1733+00	
00000000-0000-0000-0000-000000000000	5b3007f8-39f2-4c75-bcdf-b4cfaf7ccee8	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 07:23:57.066609+00	
00000000-0000-0000-0000-000000000000	adb3904f-1957-4e9d-8d05-ca281d47fadc	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 07:24:24.684464+00	
00000000-0000-0000-0000-000000000000	d08caf02-b012-4575-b5fa-3f161d34f652	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 07:27:28.742454+00	
00000000-0000-0000-0000-000000000000	9e5132a2-0cb6-48e2-86aa-3489fa56d0e0	{"action":"login","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 07:27:39.920238+00	
00000000-0000-0000-0000-000000000000	55680dd3-b938-41ae-9c36-355f3474b267	{"action":"logout","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 07:40:43.899959+00	
00000000-0000-0000-0000-000000000000	5fd6477e-6d96-4b07-ba58-dd410de5a10f	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 07:42:42.561621+00	
00000000-0000-0000-0000-000000000000	a7835fb7-41ef-4f84-b857-becd3068a65c	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 07:55:27.803372+00	
00000000-0000-0000-0000-000000000000	31690c2c-b2d4-4fe2-ad04-3c34bfd33cdc	{"action":"login","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 07:58:13.012177+00	
00000000-0000-0000-0000-000000000000	2fdc0b36-9016-44db-8020-5de5bedf6f33	{"action":"token_refreshed","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-31 09:14:37.396731+00	
00000000-0000-0000-0000-000000000000	3ddd9e64-a4d5-4124-9c87-7cf3ce2493a6	{"action":"token_revoked","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-31 09:14:37.417953+00	
00000000-0000-0000-0000-000000000000	c6bc821f-88c6-4fb8-be78-98a9ee2cdc06	{"action":"logout","actor_id":"ca5ead87-e40d-4203-bf88-c2a4e146b1c6","actor_username":"ganeshgummadidala8@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 09:17:26.711082+00	
00000000-0000-0000-0000-000000000000	f2806e60-fa4c-4697-a954-9ef60fa55abc	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 09:17:29.831673+00	
00000000-0000-0000-0000-000000000000	8825e374-235a-4461-82a7-5f46b0c5a753	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 09:17:34.947243+00	
00000000-0000-0000-0000-000000000000	f1f5946d-1226-4322-a4c5-cd92d59b3a96	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 09:17:36.928705+00	
00000000-0000-0000-0000-000000000000	a0e0a6c8-7f90-4925-9aa0-38f2e0b24bb7	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 09:19:48.042369+00	
00000000-0000-0000-0000-000000000000	91608860-20a1-4f01-9f87-f80291f9be7b	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 10:58:14.193358+00	
00000000-0000-0000-0000-000000000000	02252ee9-3efd-42e5-a45c-6195f5bee0d3	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 10:59:51.409126+00	
00000000-0000-0000-0000-000000000000	6eaa77e1-cd63-498f-8d53-1ff43cb020ab	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 10:59:56.833242+00	
00000000-0000-0000-0000-000000000000	1a517ed8-abcb-4d54-88f8-ab17132980a9	{"action":"logout","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 11:02:01.956828+00	
00000000-0000-0000-0000-000000000000	30a002af-7b14-4295-8033-69c41f2ef632	{"action":"login","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 11:02:06.769957+00	
00000000-0000-0000-0000-000000000000	24d59493-07f9-4898-8761-9d5b7e40d1a2	{"action":"token_refreshed","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-31 12:50:35.88816+00	
00000000-0000-0000-0000-000000000000	56d0f2c7-318a-4d12-b4ef-42603d3b0412	{"action":"token_revoked","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-10-31 12:50:35.903582+00	
00000000-0000-0000-0000-000000000000	5961dd47-74e9-490e-883f-21babecc0bf9	{"action":"logout","actor_id":"7d15d734-6b37-43ac-8877-9a0be1e30879","actor_username":"pavankankati51@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-10-31 12:51:16.957906+00	
00000000-0000-0000-0000-000000000000	e0220452-fde4-40c1-88eb-5d423c24a394	{"action":"login","actor_id":"40cad0bc-8e02-4aad-9e6b-d4ea91de6d24","actor_username":"nithinerroju21120@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-10-31 12:51:21.377445+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
40cad0bc-8e02-4aad-9e6b-d4ea91de6d24	40cad0bc-8e02-4aad-9e6b-d4ea91de6d24	{"sub": "40cad0bc-8e02-4aad-9e6b-d4ea91de6d24", "name": "nithin", "email": "nithinerroju21120@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-10-25 13:47:34.93324+00	2025-10-25 13:47:34.933297+00	2025-10-25 13:47:34.933297+00	c6863768-e791-4127-b034-d826cb244782
9afd46bb-fc79-423e-a2da-a05c369f4b5b	9afd46bb-fc79-423e-a2da-a05c369f4b5b	{"sub": "9afd46bb-fc79-423e-a2da-a05c369f4b5b", "name": "NITHIIN", "email": "applywizztechportfolios@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-10-25 14:39:39.958466+00	2025-10-25 14:39:39.959658+00	2025-10-25 14:39:39.959658+00	46786748-54a5-48c5-af54-d730239064b2
c691f7b7-a46a-4ba3-bfd4-3fcebd27d1eb	c691f7b7-a46a-4ba3-bfd4-3fcebd27d1eb	{"sub": "c691f7b7-a46a-4ba3-bfd4-3fcebd27d1eb", "name": "dinesh", "role": "super_admin", "email": "tunguturidineshkumar@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-10-27 06:29:48.818+00	2025-10-27 06:29:48.81806+00	2025-10-27 06:29:48.81806+00	88979355-fef5-4727-87a3-cfd5bf610500
e3037ffc-a058-45e2-8a74-e0602abfdc74	e3037ffc-a058-45e2-8a74-e0602abfdc74	{"sub": "e3037ffc-a058-45e2-8a74-e0602abfdc74", "name": "nikhil2", "role": "user", "email": "nikhilerroju1111@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-10-27 06:37:11.197535+00	2025-10-27 06:37:11.197593+00	2025-10-27 06:37:11.197593+00	b10d3b2e-72fe-47f8-8efc-0f1e479d68de
0fe7b3ed-6851-42c2-a922-0fd6bec27dd1	0fe7b3ed-6851-42c2-a922-0fd6bec27dd1	{"sub": "0fe7b3ed-6851-42c2-a922-0fd6bec27dd1", "name": "nithinuuu", "role": "TECH TL", "email": "nithinuuerrojuu@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-10-27 07:16:17.751812+00	2025-10-27 07:16:17.751873+00	2025-10-27 07:16:17.751873+00	e7dec578-72e5-4f56-aa21-ab422e99811a
eb75bcfb-dc2b-41da-8b75-c08a54d26d29	eb75bcfb-dc2b-41da-8b75-c08a54d26d29	{"sub": "eb75bcfb-dc2b-41da-8b75-c08a54d26d29", "name": "ganesh ", "role": "TECH TL", "email": "ganeshgummadidila8@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-10-27 07:30:32.931014+00	2025-10-27 07:30:32.931082+00	2025-10-27 07:30:32.931082+00	4ebf4c43-585f-40d8-a4df-b1427d1bf68d
ca5ead87-e40d-4203-bf88-c2a4e146b1c6	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	{"sub": "ca5ead87-e40d-4203-bf88-c2a4e146b1c6", "name": "ganesh ", "role": "TECH TL", "email": "ganeshgummadidala8@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-10-27 07:51:07.902671+00	2025-10-27 07:51:07.902745+00	2025-10-27 07:51:07.902745+00	90bbf036-e2ed-434a-a9de-117ac96a5343
7d15d734-6b37-43ac-8877-9a0be1e30879	7d15d734-6b37-43ac-8877-9a0be1e30879	{"sub": "7d15d734-6b37-43ac-8877-9a0be1e30879", "name": "pavan", "role": "CA", "email": "pavankankati51@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-10-27 10:45:31.656909+00	2025-10-27 10:45:31.657595+00	2025-10-27 10:45:31.657595+00	fd4dcd67-dc63-46ae-9562-d56c49aed825
0243cf1c-0067-4a31-bb9a-6d0d8e1929cb	0243cf1c-0067-4a31-bb9a-6d0d8e1929cb	{"sub": "0243cf1c-0067-4a31-bb9a-6d0d8e1929cb", "name": "Nikhil", "role": "TECH TL", "email": "nikhil@applywizz.com", "email_verified": true, "phone_verified": false}	email	2025-10-31 06:17:29.476067+00	2025-10-31 06:17:29.476672+00	2025-10-31 06:17:29.476672+00	13b43a96-fc14-482b-865c-9171105e648a
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
139cca29-48cc-43d2-a665-1347d9b89bcd	2025-10-27 07:16:31.247871+00	2025-10-27 07:16:31.247871+00	otp	77934b7b-8e4a-46cc-a2c2-743e7f62cc2f
2623b9c7-62bb-4748-a156-e6921f1170be	2025-10-31 06:17:45.246183+00	2025-10-31 06:17:45.246183+00	otp	8ea440c1-884f-4bc5-8b6a-17002c606f04
0cff7747-695c-4fa6-8c6c-cfa2afcaf737	2025-10-31 12:51:21.388815+00	2025-10-31 12:51:21.388815+00	password	ebb45449-c741-461b-957b-a9a1ed4a82d9
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
ed6138bc-ad4c-4fa4-9efd-c362bbdb1c98	eb75bcfb-dc2b-41da-8b75-c08a54d26d29	confirmation_token	1a6acb03ee64f79b34383165fa1f304111541c842138c1b12f67dec3	ganeshgummadidila8@gmail.com	2025-10-27 07:30:35.668534	2025-10-27 07:30:35.668534
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	13	n2fzeujjdnni	0fe7b3ed-6851-42c2-a922-0fd6bec27dd1	t	2025-10-27 07:16:31.23416+00	2025-10-27 08:15:04.46324+00	\N	139cca29-48cc-43d2-a665-1347d9b89bcd
00000000-0000-0000-0000-000000000000	108	g5wb6pdv2muw	40cad0bc-8e02-4aad-9e6b-d4ea91de6d24	f	2025-10-31 12:51:21.385641+00	2025-10-31 12:51:21.385641+00	\N	0cff7747-695c-4fa6-8c6c-cfa2afcaf737
00000000-0000-0000-0000-000000000000	16	3jmiuiv7n4rq	0fe7b3ed-6851-42c2-a922-0fd6bec27dd1	t	2025-10-27 08:15:04.473775+00	2025-10-27 09:13:52.657071+00	n2fzeujjdnni	139cca29-48cc-43d2-a665-1347d9b89bcd
00000000-0000-0000-0000-000000000000	19	cwkmbzf3kkb3	0fe7b3ed-6851-42c2-a922-0fd6bec27dd1	t	2025-10-27 09:13:52.657454+00	2025-10-27 10:12:41.133748+00	3jmiuiv7n4rq	139cca29-48cc-43d2-a665-1347d9b89bcd
00000000-0000-0000-0000-000000000000	23	c6nqidwed23s	0fe7b3ed-6851-42c2-a922-0fd6bec27dd1	t	2025-10-27 10:12:41.138146+00	2025-10-27 11:12:06.931222+00	cwkmbzf3kkb3	139cca29-48cc-43d2-a665-1347d9b89bcd
00000000-0000-0000-0000-000000000000	28	plwreollolxj	0fe7b3ed-6851-42c2-a922-0fd6bec27dd1	t	2025-10-27 11:12:06.941545+00	2025-10-27 12:11:05.704975+00	c6nqidwed23s	139cca29-48cc-43d2-a665-1347d9b89bcd
00000000-0000-0000-0000-000000000000	33	auyowhtfmj6f	0fe7b3ed-6851-42c2-a922-0fd6bec27dd1	t	2025-10-27 12:11:05.724753+00	2025-10-27 13:10:06.574341+00	plwreollolxj	139cca29-48cc-43d2-a665-1347d9b89bcd
00000000-0000-0000-0000-000000000000	35	mncnyfdtqow4	0fe7b3ed-6851-42c2-a922-0fd6bec27dd1	f	2025-10-27 13:10:06.581928+00	2025-10-27 13:10:06.581928+00	auyowhtfmj6f	139cca29-48cc-43d2-a665-1347d9b89bcd
00000000-0000-0000-0000-000000000000	89	zosdvfwhg3ms	0243cf1c-0067-4a31-bb9a-6d0d8e1929cb	f	2025-10-31 06:17:45.243053+00	2025-10-31 06:17:45.243053+00	\N	2623b9c7-62bb-4748-a156-e6921f1170be
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id) FROM stdin;
139cca29-48cc-43d2-a665-1347d9b89bcd	0fe7b3ed-6851-42c2-a922-0fd6bec27dd1	2025-10-27 07:16:31.228687+00	2025-10-27 13:10:06.596572+00	\N	aal1	\N	2025-10-27 13:10:06.595802	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	152.59.200.53	\N	\N
2623b9c7-62bb-4748-a156-e6921f1170be	0243cf1c-0067-4a31-bb9a-6d0d8e1929cb	2025-10-31 06:17:45.234266+00	2025-10-31 06:17:45.234266+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36	14.194.147.114	\N	\N
0cff7747-695c-4fa6-8c6c-cfa2afcaf737	40cad0bc-8e02-4aad-9e6b-d4ea91de6d24	2025-10-31 12:51:21.380636+00	2025-10-31 12:51:21.380636+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0	106.200.29.249	\N	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	9afd46bb-fc79-423e-a2da-a05c369f4b5b	authenticated	authenticated	applywizztechportfolios@gmail.com	$2a$10$8xh8cwyQPnONcsjD1pxXQei1/frMxmt/Fz33cIGVAjuvx9Rw/TheO	2025-10-25 14:39:53.162183+00	\N		2025-10-25 14:39:39.970365+00		\N			\N	2025-10-25 14:39:53.167183+00	{"provider": "email", "providers": ["email"]}	{"sub": "9afd46bb-fc79-423e-a2da-a05c369f4b5b", "name": "NITHIIN", "email": "applywizztechportfolios@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-10-25 14:39:39.942645+00	2025-10-25 14:39:53.169764+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	c691f7b7-a46a-4ba3-bfd4-3fcebd27d1eb	authenticated	authenticated	tunguturidineshkumar@gmail.com	$2a$10$gg6t9UZJp6BwGO.lrt8lF.W0k9yr3HySgjIG65RgLG2cm19wtQA2u	2025-10-27 06:30:07.471658+00	\N		2025-10-27 06:29:48.849995+00		\N			\N	2025-10-27 06:30:16.32183+00	{"provider": "email", "providers": ["email"]}	{"sub": "c691f7b7-a46a-4ba3-bfd4-3fcebd27d1eb", "name": "dinesh", "role": "super_admin", "email": "tunguturidineshkumar@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-10-27 06:29:48.698113+00	2025-10-27 06:30:16.325978+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e3037ffc-a058-45e2-8a74-e0602abfdc74	authenticated	authenticated	nikhilerroju1111@gmail.com	$2a$10$6vQOK7WkXwY3G6fT8J2QKeVSxubQ2NEMT5M41dREPvzUJDOdesWgC	2025-10-27 06:39:56.63821+00	\N		2025-10-27 06:37:11.207883+00		\N			\N	2025-10-27 06:40:08.487424+00	{"provider": "email", "providers": ["email"]}	{"sub": "e3037ffc-a058-45e2-8a74-e0602abfdc74", "name": "nikhil2", "role": "user", "email": "nikhilerroju1111@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-10-27 06:37:11.185931+00	2025-10-27 06:40:08.489379+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	0243cf1c-0067-4a31-bb9a-6d0d8e1929cb	authenticated	authenticated	nikhil@applywizz.com	$2a$10$jb03N8DQYiCTVlbZXcCZB.RPZ9G7A0iRgUXJgbqCzsJ3QkxQUu0QW	2025-10-31 06:17:45.229644+00	\N		2025-10-31 06:17:29.481347+00		\N			\N	2025-10-31 06:17:45.23418+00	{"provider": "email", "providers": ["email"]}	{"sub": "0243cf1c-0067-4a31-bb9a-6d0d8e1929cb", "name": "Nikhil", "role": "TECH TL", "email": "nikhil@applywizz.com", "email_verified": true, "phone_verified": false}	\N	2025-10-31 06:17:29.467916+00	2025-10-31 06:17:45.245668+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	eb75bcfb-dc2b-41da-8b75-c08a54d26d29	authenticated	authenticated	ganeshgummadidila8@gmail.com	$2a$10$KPoOiy1syk3o9n2XVyLSXem8QsESw9f3Q6vMoY3KdraNsGu7keYg.	\N	\N	1a6acb03ee64f79b34383165fa1f304111541c842138c1b12f67dec3	2025-10-27 07:30:32.941305+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "eb75bcfb-dc2b-41da-8b75-c08a54d26d29", "name": "ganesh ", "role": "TECH TL", "email": "ganeshgummadidila8@gmail.com", "email_verified": false, "phone_verified": false}	\N	2025-10-27 07:30:32.907786+00	2025-10-27 07:30:35.664408+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	0fe7b3ed-6851-42c2-a922-0fd6bec27dd1	authenticated	authenticated	nithinuuerrojuu@gmail.com	$2a$10$rHYNU5XxAWbYcO.g9R7sVevnarHZYbnVJuwrFLJ5DmpH4TKI2qKOS	2025-10-27 07:16:31.223085+00	\N		2025-10-27 07:16:17.762655+00		\N			\N	2025-10-27 07:16:31.227865+00	{"provider": "email", "providers": ["email"]}	{"sub": "0fe7b3ed-6851-42c2-a922-0fd6bec27dd1", "name": "nithinuuu", "role": "TECH TL", "email": "nithinuuerrojuu@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-10-27 07:16:17.739139+00	2025-10-27 13:10:06.5888+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	7d15d734-6b37-43ac-8877-9a0be1e30879	authenticated	authenticated	pavankankati51@gmail.com	$2a$10$EVnQgaDhnmaZsateywTU6eTCQ7/ZL6LX1MsHb.yGnWMqiQkD25iLK	2025-10-27 10:47:09.118078+00	\N		2025-10-27 10:45:31.670616+00		\N			\N	2025-10-31 11:02:06.778804+00	{"provider": "email", "providers": ["email"]}	{"sub": "7d15d734-6b37-43ac-8877-9a0be1e30879", "name": "pavan", "role": "CA", "email": "pavankankati51@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-10-27 10:45:31.610706+00	2025-10-31 12:50:35.931968+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	authenticated	authenticated	ganeshgummadidala8@gmail.com	$2a$10$ygip7gkrRa7ZOs1DFNjRiOK7VNNgYo1gm2xOiCr8UkU2P7/JAL/SO	2025-10-27 07:51:35.026103+00	\N		2025-10-27 07:51:07.921928+00		\N			\N	2025-10-31 07:58:13.020984+00	{"provider": "email", "providers": ["email"]}	{"sub": "ca5ead87-e40d-4203-bf88-c2a4e146b1c6", "name": "ganesh ", "role": "TECH TL", "email": "ganeshgummadidala8@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-10-27 07:51:07.869654+00	2025-10-31 09:14:37.445762+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	40cad0bc-8e02-4aad-9e6b-d4ea91de6d24	authenticated	authenticated	nithinerroju21120@gmail.com	$2a$10$DWLEU3WR37QWozi6yGqskOjw.I311PJhCgpANA3216B08VYx9DPQ2	2025-10-25 13:47:47.15482+00	\N		2025-10-25 13:47:34.945108+00		\N			\N	2025-10-31 12:51:21.379929+00	{"provider": "email", "providers": ["email"]}	{"sub": "40cad0bc-8e02-4aad-9e6b-d4ea91de6d24", "name": "nithin", "email": "nithinerroju21120@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-10-25 13:47:34.90002+00	2025-10-31 12:51:21.38833+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: marketplace_products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.marketplace_products (id, name, image_url, points_price, stock, active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mentors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.mentors (id, created_by_user_id, mentor_name, linkedin_url, phone, email, domain, experience_years, previous_domain, status, created_at, updated_at, edited_by_user_id) FROM stdin;
6f940406-4159-4dfc-8fb6-962f7b4027fb	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	sarika	https://www.linkedin.com/in/mareddy-sagar-reddy-ba071a0/	789632541	sarika@gmail.com	mernstack	8	mern	onboarded	2025-10-27 11:16:35.881898+00	2025-10-27 13:52:41.680431+00	\N
97b9be17-dd8f-416f-a76a-a34bc5117349	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	pooja	https://www.linkedin.com/in/mareddy-sagar-reddy-ba0b871a0/	589632147	pooja@gmail.com	full stack	5	full stack	onboarded	2025-10-27 11:15:37.950148+00	2025-10-27 13:52:56.283198+00	\N
30ce9d2d-c477-4acd-8be5-c73f3170f7a3	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	nithinuuuuu	https://www.linkedin.com/in/ruthvik-?lipi=urn%3ali%3apage%3ad_flagshp3_profile_view_base_contact_details%3b1nsha3tmtkeaxztmgrl%2bja%3d%3d	6304338274	nikhiluuuu414141@gmail.com	sde	1423223	java	onboarded	2025-10-27 08:06:16.695118+00	2025-10-30 07:48:34.225827+00	ca5ead87-e40d-4203-bf88-c2a4e146b1c6
514a028f-0001-4c3d-a91f-c60572fcbd4b	7d15d734-6b37-43ac-8877-9a0be1e30879	krishna	https://www.linkedin.com/in/hesh-gannebo/	78945613	krish@gmail.com	fs	89	fs	onboarded	2025-10-27 14:32:09.349953+00	2025-10-27 14:33:40.482861+00	\N
0636e839-dc65-49df-8168-33b183d13158	7d15d734-6b37-43ac-8877-9a0be1e30879	prashnath	https://www.linkedin.com/in/mesh-gannebo/	78946613	prash@gmail.com	sde	789	sde	onboarded	2025-10-27 14:30:47.297905+00	2025-10-27 14:33:44.094797+00	\N
d91195ae-24c6-4f46-9b7b-77e1cf0c2597	7d15d734-6b37-43ac-8877-9a0be1e30879	vyshnavi	https://www.linkedin.com/in/mahesh-ganbo/	78945613	vysh@gmail.com	dfs	1000	dfd	onboarded	2025-10-27 14:31:32.035105+00	2025-10-27 14:33:46.380332+00	\N
977f1bd3-e515-4289-9c90-66e6ba4dac6f	7d15d734-6b37-43ac-8877-9a0be1e30879	amreen	https://www.linkedin.com/in/maheh-gannebo/	78945623	amreen@1092	puthon	78	pythoh	onboarded	2025-10-27 14:30:06.570906+00	2025-10-27 14:33:48.434037+00	\N
92375628-5005-464e-b88d-f82f760a53a7	7d15d734-6b37-43ac-8877-9a0be1e30879	varshini	https://www.linkedin.com/in/mahesh-gannebo/	7894562	varshini@gmail.com	java	45	java	onboarded	2025-10-27 14:29:31.623659+00	2025-10-27 14:33:50.635221+00	\N
0250c916-ad9e-4756-80c7-b6bef4c558a7	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	jyothika	https://www.linkedin.com/in/satish-rey-pulla/	6304338275	jy0@gmail.com	data analyst	2	aml	onboarded	2025-10-28 11:48:54.538046+00	2025-10-28 11:50:41.908545+00	\N
60df4a90-c8b7-407d-b3de-3bfb5a73f65f	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	dinesh	https://www.linkedin.com/in/nandini-mangla-96b485381/	5555555555	diensh@gmail.com	pythoh	4	pythoh	onboarded	2025-10-27 08:13:22.937131+00	2025-10-28 11:51:18.290945+00	\N
df8ed9d3-4acb-458b-8e6e-f4676eaceac7	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	nithinuuuuu	https://www.linkedin.com/in/ruthvik-?lipi=urn%3ali%3apage%3d_flagshp3_profile_view_base_contact_details%3b1nsha3mtkeaxztmgrl%2bja%3d%3d	6304338274	nikhiluuuu414141@gmail.com	sde	1	java	onboarded	2025-10-27 08:12:11.630242+00	2025-10-28 13:29:37.737282+00	\N
503bb23c-1e4b-4d33-acce-eeb04c9baf7e	7d15d734-6b37-43ac-8877-9a0be1e30879	vamsi	https://www.linkedin.com/in/varsha-elnino-erri-275692227/	751545621522	vamsi@gmail.com	docker	3	docker	onboarded	2025-10-30 10:06:21.029284+00	2025-10-30 10:07:12.837038+00	\N
8e3c9966-a0df-453e-a984-d128b938cae0	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	nithinuuuuu	https://www.linkedin.com/in/ruthvik-?lipi=urn%3ali%3apage%3ad_flagship3_profile_view_base_contact_details%3b1nsha3tmtkeaxztmgrl%2bja%3d%3d	6304338274	nikhiluuuu414141@gmail.com	sde	1	java	onboarded	2025-10-27 08:00:26.41489+00	2025-10-30 07:48:36.78439+00	\N
9cdeaf08-a772-4a26-9217-b69f13e0d5b5	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	hjl	https://www.linkedin.com/rk=bf&trkinfo=aqfntik2azov2g6opjprfodkocmcg4mgwsgrhgy9u2xndabzzsxklbfn3vpbon4hoj82-xl04xnfllyjtxnugp0lw_lc0-m6jfvwyfk8mfa4j9xxyptzqvta8fostm0=&original_referer=&sessionredirect=https%3a%2f%2fwww.linkedin.com%2fin%2fvamshikrishna-challa-98b306292	\N	nithin@gmail.com	sde	1	java	onboarded	2025-10-27 07:52:40.640997+00	2025-10-29 15:38:44.248679+00	\N
7e5c7126-fb9f-46ec-8350-b440007dfc89	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	nithinuuuuu	https://www.linkedin.com/rk=bf&trkinfo=aqfntik2azov2g6opjprfodkocmcg4mgwsgrhgy9u2xndabzzsxklbfn3vpbon4hoj82-xl04xnfllyjtxnugp0lw_lc0-m6jfvwyfk8mfa4j9xxyptzqvta8fostm0=&original_referer=&sessionredirect=https%3a%2f%2fwww.linkedin.com%2fin%2fvamshikrishna-challa-b306292	6304338274	nikhiluuuu414141@gmail.com	sde	1	java	onboarded	2025-10-27 07:54:15.044803+00	2025-10-29 15:38:48.317026+00	\N
9a4c0f7b-8918-4403-aeb9-3103fca933bf	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	vamshi	https://www.linkedin.com/in/satish-reddy-pulla/	4563217899	vamshi@gmail.com	hgkk	4	data analyst	onboarded	2025-10-28 11:48:05.180936+00	2025-10-30 06:33:10.163979+00	\N
9a81f006-6b8d-4b83-8d41-132871f7ff85	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	hjl	https://www.linkedin.com/aul?trk=bf&trkinfo=aqfntik2azov2g6opjprfodkocmcg4mgwsgrhgy9u2xndabzzsxklbfn3vpbon4hoj82-xl04xnfllyjtxnugp0lw_lc0-m6jfvwyfk8mfa4j9xxyptzqvta8fostm0=&original_referer=&sessionredirect=https%3a%2f%2fwww.linkedin.com%2fin%2fvamshikrishna-challa-98b306292	\N	nithin@gmail.com	sde	1	java	onboarded	2025-10-27 07:52:23.888931+00	2025-10-30 07:48:39.027662+00	\N
26bbf3af-a83c-403d-9f63-6344055f9d2c	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	nithinuuuuu	https://www.linkedin.com/in/ruthvik-?lipi=urn%3ali%3apage%3ad_flagshp3_profile_view_base_contact_details%3b1nsha3mtkeaxztmgrl%2bja%3d%3d	6304338274	nikhiluuuu414141@gmail.com	sde	1	java	declined	2025-10-27 08:07:28.29621+00	2025-10-30 07:52:49.523674+00	\N
efff9655-d6df-4503-af55-36fb1c52f89f	7d15d734-6b37-43ac-8877-9a0be1e30879	ghjk	https://www.linkedin.com/in/gururaja-kg-aa0827251/	4231596202	ghk@gmail.com	full stack	2	cor	declined	2025-10-28 14:43:55.95097+00	2025-10-30 10:08:16.219189+00	7d15d734-6b37-43ac-8877-9a0be1e30879
92f1242c-437d-4731-a62d-736d74370f1c	7d15d734-6b37-43ac-8877-9a0be1e30879	nainika 	https://www.linkedin.com/in/sai-sanjana-das-t/	6954789623	nainika@gmail.com	aws	2	aws	onboarded	2025-10-30 08:02:43.926928+00	2025-10-30 08:18:37.088802+00	\N
0bb08255-ec74-4843-bdbd-e50de7662c66	7d15d734-6b37-43ac-8877-9a0be1e30879	nithinnithin	https://www.linkedin.com/in/gulapalyamathamgopiganesh/	25489632	nithin22@gmail.com	docker	3	docker	onboarded	2025-10-30 09:19:24.454051+00	2025-10-30 09:20:01.216484+00	\N
114e1e7f-00c5-44f3-9b49-6e76144b28b7	7d15d734-6b37-43ac-8877-9a0be1e30879	vamshika	https://www.linkedin.com/in/vara-elnino-erri-275692227/	789654123	vamshika@gmail.com	sde	3	sde	onboarded	2025-10-30 10:10:59.542316+00	2025-10-30 10:11:42.961173+00	\N
825551ee-55f8-41eb-89ea-237a0f491648	7d15d734-6b37-43ac-8877-9a0be1e30879	santhoshi	https://www.linkedin.com/in/wajahathullah-mohammad-70a859285/	5214489622	santoshi@gmail.com	sde	4	se	declined	2025-10-30 11:59:49.859033+00	2025-10-30 12:07:55.258986+00	\N
65a0d7fa-b274-4e17-8f8f-76d6cfda99e1	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	zubair 	https://www.linkedin.com/in/akshay-pendam-138b2b2ab/	45452055620	zubair@gmail.com	de	6	ds	onboarded	2025-10-30 12:15:43.951878+00	2025-10-31 11:00:56.096128+00	\N
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notifications (id, user_id, type, title, message, is_read, created_at) FROM stdin;
\.


--
-- Data for Name: points_ledger; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.points_ledger (id, user_id, mentor_id, delta, reason, created_at) FROM stdin;
fb335282-c955-4a1c-8317-1e90641936d3	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	df8ed9d3-4acb-458b-8e6e-f4676eaceac7	10	submission	2025-10-27 08:12:12.6698+00
ce29ba33-ecaa-414a-99fd-b41dd5767062	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	60df4a90-c8b7-407d-b3de-3bfb5a73f65f	10	submission	2025-10-27 08:13:23.823622+00
eb023845-d1de-4ae3-b33c-80593ec7c20b	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	97b9be17-dd8f-416f-a76a-a34bc5117349	10	submission	2025-10-27 11:15:38.921056+00
fab103f4-9bbe-486f-8ba9-0b50d93ce4c7	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	6f940406-4159-4dfc-8fb6-962f7b4027fb	10	submission	2025-10-27 11:16:36.971943+00
b0a91cd1-5751-4ade-a50c-3ef6d7fa5803	7d15d734-6b37-43ac-8877-9a0be1e30879	92375628-5005-464e-b88d-f82f760a53a7	10	submission	2025-10-27 14:29:32.052905+00
3e32e2db-cb5d-42c6-a3b6-2b02a86e2aa2	7d15d734-6b37-43ac-8877-9a0be1e30879	977f1bd3-e515-4289-9c90-66e6ba4dac6f	10	submission	2025-10-27 14:30:06.857533+00
e6e6494d-17bb-4e75-8f7a-bbbe72566177	7d15d734-6b37-43ac-8877-9a0be1e30879	0636e839-dc65-49df-8168-33b183d13158	10	submission	2025-10-27 14:30:48.581284+00
e2767435-877f-4ca4-ab08-92e796d79033	7d15d734-6b37-43ac-8877-9a0be1e30879	d91195ae-24c6-4f46-9b7b-77e1cf0c2597	10	submission	2025-10-27 14:31:32.356045+00
4d63d25e-7c36-45d7-8a2b-d2a2a8d22ec1	7d15d734-6b37-43ac-8877-9a0be1e30879	514a028f-0001-4c3d-a91f-c60572fcbd4b	10	submission	2025-10-27 14:32:09.711463+00
c2df6104-35d3-46d1-b92e-e1229bd4c24d	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	9a4c0f7b-8918-4403-aeb9-3103fca933bf	10	submission	2025-10-28 11:48:05.540385+00
0e394e3e-637f-4ed2-a7e7-78fa4bf392ba	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	0250c916-ad9e-4756-80c7-b6bef4c558a7	10	submission	2025-10-28 11:48:54.702499+00
27620733-750a-433a-abc3-7ebd5273659f	7d15d734-6b37-43ac-8877-9a0be1e30879	efff9655-d6df-4503-af55-36fb1c52f89f	10	submission	2025-10-28 14:43:56.361547+00
9a876c4b-19e9-4ce8-8ada-66858714f5a9	7d15d734-6b37-43ac-8877-9a0be1e30879	92f1242c-437d-4731-a62d-736d74370f1c	10	submission	2025-10-30 08:02:44.270207+00
bb9ff32b-6fb9-4b3b-8cae-9bf1e26625ac	7d15d734-6b37-43ac-8877-9a0be1e30879	0bb08255-ec74-4843-bdbd-e50de7662c66	10	submission	2025-10-30 09:19:24.735202+00
9e7e963b-6d60-4f30-8863-09d17e3142ea	7d15d734-6b37-43ac-8877-9a0be1e30879	503bb23c-1e4b-4d33-acce-eeb04c9baf7e	10	submission	2025-10-30 10:06:21.140218+00
b757c1a1-5a58-4c7e-b121-dbdab0110585	7d15d734-6b37-43ac-8877-9a0be1e30879	114e1e7f-00c5-44f3-9b49-6e76144b28b7	10	submission	2025-10-30 10:10:59.628204+00
edaf494d-1e27-4db3-ad7f-93f1cbbacc4f	7d15d734-6b37-43ac-8877-9a0be1e30879	825551ee-55f8-41eb-89ea-237a0f491648	10	submission	2025-10-30 11:59:50.052274+00
5def66b4-ec04-4fb3-8136-ef3b6beca3e2	ca5ead87-e40d-4203-bf88-c2a4e146b1c6	65a0d7fa-b274-4e17-8f8f-76d6cfda99e1	10	submission	2025-10-30 12:15:44.13784+00
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.profiles (id, name, email, avatar_url, role, points_total, created_at) FROM stdin;
40cad0bc-8e02-4aad-9e6b-d4ea91de6d24	nithin	nithinerroju21120@gmail.com	\N	super_admin	0	2025-10-25 13:47:34.898568+00
9afd46bb-fc79-423e-a2da-a05c369f4b5b	NITHIIN	applywizztechportfolios@gmail.com	\N	user	0	2025-10-25 14:39:39.940983+00
c691f7b7-a46a-4ba3-bfd4-3fcebd27d1eb	dinesh	tunguturidineshkumar@gmail.com	\N	super_admin	0	2025-10-27 06:29:48.695294+00
e3037ffc-a058-45e2-8a74-e0602abfdc74	nikhil2	nikhilerroju1111@gmail.com	\N	user	0	2025-10-27 06:37:11.184834+00
0fe7b3ed-6851-42c2-a922-0fd6bec27dd1	nithinuuu	nithinuuerrojuu@gmail.com	\N	TECH TL	0	2025-10-27 07:16:17.738123+00
eb75bcfb-dc2b-41da-8b75-c08a54d26d29	ganesh 	ganeshgummadidila8@gmail.com	\N	TECH TL	0	2025-10-27 07:30:32.907376+00
ca5ead87-e40d-4203-bf88-c2a4e146b1c6	ganesh 	ganeshgummadidala8@gmail.com	\N	CA TL	50	2025-10-27 07:51:07.863777+00
7d15d734-6b37-43ac-8877-9a0be1e30879	pavan	pavankankati51@gmail.com	\N	CA	70	2025-10-27 10:45:31.60977+00
0243cf1c-0067-4a31-bb9a-6d0d8e1929cb	Nikhil	nikhil@applywizz.com	\N	TECH TL	0	2025-10-31 06:17:29.467599+00
\.


--
-- Data for Name: redemptions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.redemptions (id, user_id, product_id, points_cost, status, created_at) FROM stdin;
\.


--
-- Data for Name: messages_2025_10_28; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2025_10_28 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_10_29; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2025_10_29 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_10_30; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2025_10_30 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_10_31; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2025_10_31 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_11_01; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2025_11_01 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_11_02; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2025_11_02 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_11_03; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2025_11_03 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-10-25 10:14:55
20211116045059	2025-10-25 10:14:55
20211116050929	2025-10-25 10:14:56
20211116051442	2025-10-25 10:14:57
20211116212300	2025-10-25 10:14:58
20211116213355	2025-10-25 10:14:58
20211116213934	2025-10-25 10:14:59
20211116214523	2025-10-25 10:15:00
20211122062447	2025-10-25 10:15:00
20211124070109	2025-10-25 10:15:01
20211202204204	2025-10-25 10:15:02
20211202204605	2025-10-25 10:15:02
20211210212804	2025-10-25 10:15:04
20211228014915	2025-10-25 10:15:05
20220107221237	2025-10-25 10:15:06
20220228202821	2025-10-25 10:15:06
20220312004840	2025-10-25 10:15:07
20220603231003	2025-10-25 10:15:08
20220603232444	2025-10-25 10:15:09
20220615214548	2025-10-25 10:15:09
20220712093339	2025-10-25 10:15:10
20220908172859	2025-10-25 10:15:11
20220916233421	2025-10-25 10:15:11
20230119133233	2025-10-25 10:15:12
20230128025114	2025-10-25 10:15:13
20230128025212	2025-10-25 10:15:13
20230227211149	2025-10-25 10:15:14
20230228184745	2025-10-25 10:15:15
20230308225145	2025-10-25 10:15:15
20230328144023	2025-10-25 10:15:16
20231018144023	2025-10-25 10:15:17
20231204144023	2025-10-25 10:15:18
20231204144024	2025-10-25 10:15:18
20231204144025	2025-10-25 10:15:19
20240108234812	2025-10-25 10:15:20
20240109165339	2025-10-25 10:15:20
20240227174441	2025-10-25 10:15:21
20240311171622	2025-10-25 10:15:22
20240321100241	2025-10-25 10:15:24
20240401105812	2025-10-25 10:15:26
20240418121054	2025-10-25 10:15:26
20240523004032	2025-10-25 10:15:29
20240618124746	2025-10-25 10:15:29
20240801235015	2025-10-25 10:15:30
20240805133720	2025-10-25 10:15:31
20240827160934	2025-10-25 10:15:31
20240919163303	2025-10-25 10:15:32
20240919163305	2025-10-25 10:15:33
20241019105805	2025-10-25 10:15:33
20241030150047	2025-10-25 10:15:36
20241108114728	2025-10-25 10:15:37
20241121104152	2025-10-25 10:15:37
20241130184212	2025-10-25 10:15:38
20241220035512	2025-10-25 10:15:39
20241220123912	2025-10-25 10:15:39
20241224161212	2025-10-25 10:15:40
20250107150512	2025-10-25 10:15:41
20250110162412	2025-10-25 10:15:41
20250123174212	2025-10-25 10:15:42
20250128220012	2025-10-25 10:15:43
20250506224012	2025-10-25 10:15:43
20250523164012	2025-10-25 10:15:44
20250714121412	2025-10-25 10:15:44
20250905041441	2025-10-25 10:15:45
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets_analytics (id, type, format, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-10-25 10:14:55.343593
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-10-25 10:14:55.35082
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-10-25 10:14:55.35688
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-10-25 10:14:55.378932
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-10-25 10:14:55.431456
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-10-25 10:14:55.435753
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-10-25 10:14:55.441385
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-10-25 10:14:55.446349
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-10-25 10:14:55.450585
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-10-25 10:14:55.454781
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-10-25 10:14:55.459508
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-10-25 10:14:55.465453
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-10-25 10:14:55.472585
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-10-25 10:14:55.477257
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-10-25 10:14:55.481706
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-10-25 10:14:55.526291
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-10-25 10:14:55.530693
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-10-25 10:14:55.535187
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-10-25 10:14:55.539949
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-10-25 10:14:55.545389
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-10-25 10:14:55.551433
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-10-25 10:14:55.558648
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-10-25 10:14:55.595503
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-10-25 10:14:55.625805
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-10-25 10:14:55.630324
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-10-25 10:14:55.634744
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2025-10-25 10:14:55.639339
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2025-10-25 10:14:55.653139
28	object-bucket-name-sorting	ba85ec41b62c6a30a3f136788227ee47f311c436	2025-10-25 10:14:56.17286
29	create-prefixes	a7b1a22c0dc3ab630e3055bfec7ce7d2045c5b7b	2025-10-25 10:14:56.179444
30	update-object-levels	6c6f6cc9430d570f26284a24cf7b210599032db7	2025-10-25 10:14:56.18642
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2025-10-25 10:14:56.197265
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2025-10-25 10:14:57.702581
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2025-10-25 10:14:58.327895
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2025-10-25 10:14:58.358182
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2025-10-25 10:14:58.423331
36	optimise-existing-functions	81cf92eb0c36612865a18016a38496c530443899	2025-10-25 10:14:58.507579
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-10-25 10:14:58.809979
38	iceberg-catalog-flag-on-buckets	19a8bd89d5dfa69af7f222a46c726b7c41e462c5	2025-10-25 10:14:58.832547
39	add-search-v2-sort-support	39cf7d1e6bf515f4b02e41237aba845a7b492853	2025-10-25 10:14:58.882663
40	fix-prefix-race-conditions-optimized	fd02297e1c67df25a9fc110bf8c8a9af7fb06d1f	2025-10-25 10:14:58.887454
41	add-object-level-update-trigger	44c22478bf01744b2129efc480cd2edc9a7d60e9	2025-10-25 10:14:58.896777
42	rollback-prefix-triggers	f2ab4f526ab7f979541082992593938c05ee4b47	2025-10-25 10:14:58.903046
43	fix-object-level	ab837ad8f1c7d00cc0b7310e989a23388ff29fc6	2025-10-25 10:14:58.91023
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
\.


--
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: -
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: -
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 108, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: -
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: marketplace_products marketplace_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marketplace_products
    ADD CONSTRAINT marketplace_products_pkey PRIMARY KEY (id);


--
-- Name: mentors mentors_linkedin_url_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mentors
    ADD CONSTRAINT mentors_linkedin_url_key UNIQUE (linkedin_url);


--
-- Name: mentors mentors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mentors
    ADD CONSTRAINT mentors_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: points_ledger points_ledger_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.points_ledger
    ADD CONSTRAINT points_ledger_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_email_key UNIQUE (email);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: redemptions redemptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redemptions
    ADD CONSTRAINT redemptions_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_10_28 messages_2025_10_28_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_10_28
    ADD CONSTRAINT messages_2025_10_28_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_10_29 messages_2025_10_29_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_10_29
    ADD CONSTRAINT messages_2025_10_29_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_10_30 messages_2025_10_30_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_10_30
    ADD CONSTRAINT messages_2025_10_30_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_10_31 messages_2025_10_31_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_10_31
    ADD CONSTRAINT messages_2025_10_31_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_11_01 messages_2025_11_01_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_11_01
    ADD CONSTRAINT messages_2025_11_01_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_11_02 messages_2025_11_02_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_11_02
    ADD CONSTRAINT messages_2025_11_02_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_11_03 messages_2025_11_03_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_11_03
    ADD CONSTRAINT messages_2025_11_03_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: idx_mentors_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_mentors_created_at ON public.mentors USING btree (created_at);


--
-- Name: idx_mentors_created_by; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_mentors_created_by ON public.mentors USING btree (created_by_user_id);


--
-- Name: idx_mentors_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_mentors_status ON public.mentors USING btree (status);


--
-- Name: idx_notifications_is_read; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notifications_is_read ON public.notifications USING btree (is_read);


--
-- Name: idx_notifications_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notifications_user_id ON public.notifications USING btree (user_id);


--
-- Name: idx_points_ledger_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_points_ledger_created_at ON public.points_ledger USING btree (created_at);


--
-- Name: idx_points_ledger_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_points_ledger_user_id ON public.points_ledger USING btree (user_id);


--
-- Name: idx_redemptions_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_redemptions_user_id ON public.redemptions USING btree (user_id);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2025_10_28_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2025_10_28_inserted_at_topic_idx ON realtime.messages_2025_10_28 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2025_10_29_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2025_10_29_inserted_at_topic_idx ON realtime.messages_2025_10_29 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2025_10_30_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2025_10_30_inserted_at_topic_idx ON realtime.messages_2025_10_30 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2025_10_31_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2025_10_31_inserted_at_topic_idx ON realtime.messages_2025_10_31 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2025_11_01_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2025_11_01_inserted_at_topic_idx ON realtime.messages_2025_11_01 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2025_11_02_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2025_11_02_inserted_at_topic_idx ON realtime.messages_2025_11_02 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2025_11_03_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2025_11_03_inserted_at_topic_idx ON realtime.messages_2025_11_03 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: -
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_name_bucket_level_unique; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- Name: messages_2025_10_28_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_10_28_inserted_at_topic_idx;


--
-- Name: messages_2025_10_28_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_10_28_pkey;


--
-- Name: messages_2025_10_29_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_10_29_inserted_at_topic_idx;


--
-- Name: messages_2025_10_29_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_10_29_pkey;


--
-- Name: messages_2025_10_30_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_10_30_inserted_at_topic_idx;


--
-- Name: messages_2025_10_30_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_10_30_pkey;


--
-- Name: messages_2025_10_31_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_10_31_inserted_at_topic_idx;


--
-- Name: messages_2025_10_31_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_10_31_pkey;


--
-- Name: messages_2025_11_01_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_11_01_inserted_at_topic_idx;


--
-- Name: messages_2025_11_01_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_11_01_pkey;


--
-- Name: messages_2025_11_02_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_11_02_inserted_at_topic_idx;


--
-- Name: messages_2025_11_02_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_11_02_pkey;


--
-- Name: messages_2025_11_03_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_11_03_inserted_at_topic_idx;


--
-- Name: messages_2025_11_03_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_11_03_pkey;


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: -
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- Name: marketplace_products update_marketplace_products_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_marketplace_products_updated_at BEFORE UPDATE ON public.marketplace_products FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: mentors update_mentors_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_mentors_updated_at BEFORE UPDATE ON public.mentors FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: -
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();


--
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: mentors mentors_created_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mentors
    ADD CONSTRAINT mentors_created_by_user_id_fkey FOREIGN KEY (created_by_user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- Name: mentors mentors_edited_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mentors
    ADD CONSTRAINT mentors_edited_by_user_id_fkey FOREIGN KEY (edited_by_user_id) REFERENCES public.profiles(id);


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- Name: points_ledger points_ledger_mentor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.points_ledger
    ADD CONSTRAINT points_ledger_mentor_id_fkey FOREIGN KEY (mentor_id) REFERENCES public.mentors(id) ON DELETE CASCADE;


--
-- Name: points_ledger points_ledger_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.points_ledger
    ADD CONSTRAINT points_ledger_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: redemptions redemptions_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redemptions
    ADD CONSTRAINT redemptions_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.marketplace_products(id) ON DELETE CASCADE;


--
-- Name: redemptions redemptions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redemptions
    ADD CONSTRAINT redemptions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: marketplace_products Anyone can view active products; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Anyone can view active products" ON public.marketplace_products FOR SELECT USING ((active = true));


--
-- Name: marketplace_products Super admins can delete products; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Super admins can delete products" ON public.marketplace_products FOR DELETE USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::public.user_role)))));


--
-- Name: marketplace_products Super admins can insert products; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Super admins can insert products" ON public.marketplace_products FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::public.user_role)))));


--
-- Name: mentors Super admins can update any mentor; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Super admins can update any mentor" ON public.mentors FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::public.user_role)))));


--
-- Name: profiles Super admins can update any profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Super admins can update any profile" ON public.profiles FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM public.profiles profiles_1
  WHERE ((profiles_1.id = auth.uid()) AND (profiles_1.role = 'super_admin'::public.user_role)))));


--
-- Name: marketplace_products Super admins can update products; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Super admins can update products" ON public.marketplace_products FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::public.user_role)))));


--
-- Name: redemptions Super admins can update redemptions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Super admins can update redemptions" ON public.redemptions FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::public.user_role)))));


--
-- Name: points_ledger Super admins can view all ledgers; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Super admins can view all ledgers" ON public.points_ledger FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::public.user_role)))));


--
-- Name: mentors Super admins can view all mentors; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Super admins can view all mentors" ON public.mentors FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::public.user_role)))));


--
-- Name: marketplace_products Super admins can view all products; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Super admins can view all products" ON public.marketplace_products FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::public.user_role)))));


--
-- Name: redemptions Super admins can view all redemptions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Super admins can view all redemptions" ON public.redemptions FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'super_admin'::public.user_role)))));


--
-- Name: mentors Users can insert own mentors; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can insert own mentors" ON public.mentors FOR INSERT WITH CHECK ((created_by_user_id = auth.uid()));


--
-- Name: redemptions Users can insert own redemptions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can insert own redemptions" ON public.redemptions FOR INSERT WITH CHECK ((user_id = auth.uid()));


--
-- Name: points_ledger Users can insert their own points; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can insert their own points" ON public.points_ledger FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: mentors Users can update own mentors; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update own mentors" ON public.mentors FOR UPDATE USING ((created_by_user_id = auth.uid())) WITH CHECK ((created_by_user_id = auth.uid()));


--
-- Name: notifications Users can update own notifications; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update own notifications" ON public.notifications FOR UPDATE USING ((user_id = auth.uid()));


--
-- Name: profiles Users can update own profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update own profile" ON public.profiles FOR UPDATE USING ((auth.uid() = id));


--
-- Name: profiles Users can view all profiles; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view all profiles" ON public.profiles FOR SELECT USING (true);


--
-- Name: points_ledger Users can view own ledger; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view own ledger" ON public.points_ledger FOR SELECT USING ((user_id = auth.uid()));


--
-- Name: mentors Users can view own mentors; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view own mentors" ON public.mentors FOR SELECT USING ((created_by_user_id = auth.uid()));


--
-- Name: notifications Users can view own notifications; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view own notifications" ON public.notifications FOR SELECT USING ((user_id = auth.uid()));


--
-- Name: redemptions Users can view own redemptions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view own redemptions" ON public.redemptions FOR SELECT USING ((user_id = auth.uid()));


--
-- Name: marketplace_products; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.marketplace_products ENABLE ROW LEVEL SECURITY;

--
-- Name: mentors; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.mentors ENABLE ROW LEVEL SECURITY;

--
-- Name: notifications; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

--
-- Name: points_ledger; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.points_ledger ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- Name: redemptions; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.redemptions ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: -
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: -
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


--
-- Name: supabase_realtime_messages_publication; Type: PUBLICATION; Schema: -; Owner: -
--

CREATE PUBLICATION supabase_realtime_messages_publication WITH (publish = 'insert, update, delete, truncate');


--
-- Name: supabase_realtime_messages_publication messages; Type: PUBLICATION TABLE; Schema: realtime; Owner: -
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY realtime.messages;


--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: -
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: -
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.update_updated_at_column() TO anon;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO authenticated;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: -
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: -
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: -
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: -
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE marketplace_products; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.marketplace_products TO anon;
GRANT ALL ON TABLE public.marketplace_products TO authenticated;
GRANT ALL ON TABLE public.marketplace_products TO service_role;


--
-- Name: TABLE mentors; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.mentors TO anon;
GRANT ALL ON TABLE public.mentors TO authenticated;
GRANT ALL ON TABLE public.mentors TO service_role;


--
-- Name: TABLE notifications; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.notifications TO anon;
GRANT ALL ON TABLE public.notifications TO authenticated;
GRANT ALL ON TABLE public.notifications TO service_role;


--
-- Name: TABLE points_ledger; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.points_ledger TO anon;
GRANT ALL ON TABLE public.points_ledger TO authenticated;
GRANT ALL ON TABLE public.points_ledger TO service_role;


--
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- Name: TABLE redemptions; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.redemptions TO anon;
GRANT ALL ON TABLE public.redemptions TO authenticated;
GRANT ALL ON TABLE public.redemptions TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE messages_2025_10_28; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages_2025_10_28 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_10_28 TO dashboard_user;


--
-- Name: TABLE messages_2025_10_29; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages_2025_10_29 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_10_29 TO dashboard_user;


--
-- Name: TABLE messages_2025_10_30; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages_2025_10_30 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_10_30 TO dashboard_user;


--
-- Name: TABLE messages_2025_10_31; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages_2025_10_31 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_10_31 TO dashboard_user;


--
-- Name: TABLE messages_2025_11_01; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages_2025_11_01 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_11_01 TO dashboard_user;


--
-- Name: TABLE messages_2025_11_02; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages_2025_11_02 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_11_02 TO dashboard_user;


--
-- Name: TABLE messages_2025_11_03; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages_2025_11_03 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_11_03 TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE prefixes; Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON TABLE storage.prefixes TO service_role;
GRANT ALL ON TABLE storage.prefixes TO authenticated;
GRANT ALL ON TABLE storage.prefixes TO anon;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: -
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: -
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


--
-- PostgreSQL database dump complete
--

\unrestrict 6OBIVgOnpeiINoDRdoyxSZBGxA0iZimmcf7y8vdSrodLkc1BRZDOl9EBRt8Kmlu

