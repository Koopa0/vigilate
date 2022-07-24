--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: trigger_set_timestamp(); Type: FUNCTION; Schema: public; Owner: koopa
--

CREATE FUNCTION public.trigger_set_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_set_timestamp() OWNER TO koopa;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: events; Type: TABLE; Schema: public; Owner: koopa
--

CREATE TABLE public.events (
    id integer NOT NULL,
    event_type character varying(255) NOT NULL,
    host_service_id integer NOT NULL,
    host_id integer NOT NULL,
    service_name character varying(255) NOT NULL,
    host_name character varying(255) NOT NULL,
    message character varying(512) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.events OWNER TO koopa;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: koopa
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO koopa;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: koopa
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: host_services; Type: TABLE; Schema: public; Owner: koopa
--

CREATE TABLE public.host_services (
    id integer NOT NULL,
    host_id integer NOT NULL,
    service_id integer NOT NULL,
    active integer DEFAULT 1 NOT NULL,
    schedule_number integer DEFAULT 3 NOT NULL,
    schedule_unit character varying(255) DEFAULT 'm'::character varying NOT NULL,
    last_check timestamp without time zone DEFAULT '0001-01-01 00:00:01'::timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    last_message character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.host_services OWNER TO koopa;

--
-- Name: host_services_id_seq; Type: SEQUENCE; Schema: public; Owner: koopa
--

CREATE SEQUENCE public.host_services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.host_services_id_seq OWNER TO koopa;

--
-- Name: host_services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: koopa
--

ALTER SEQUENCE public.host_services_id_seq OWNED BY public.host_services.id;


--
-- Name: hosts; Type: TABLE; Schema: public; Owner: koopa
--

CREATE TABLE public.hosts (
    id integer NOT NULL,
    host_name character varying(255) NOT NULL,
    canonical_name character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    ip character varying(255) NOT NULL,
    ipv6 character varying(255) NOT NULL,
    location character varying(255) NOT NULL,
    os character varying(255) NOT NULL,
    active integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.hosts OWNER TO koopa;

--
-- Name: hosts_id_seq; Type: SEQUENCE; Schema: public; Owner: koopa
--

CREATE SEQUENCE public.hosts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hosts_id_seq OWNER TO koopa;

--
-- Name: hosts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: koopa
--

ALTER SEQUENCE public.hosts_id_seq OWNED BY public.hosts.id;


--
-- Name: preferences; Type: TABLE; Schema: public; Owner: koopa
--

CREATE TABLE public.preferences (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    preference text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.preferences OWNER TO koopa;

--
-- Name: preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: koopa
--

CREATE SEQUENCE public.preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.preferences_id_seq OWNER TO koopa;

--
-- Name: preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: koopa
--

ALTER SEQUENCE public.preferences_id_seq OWNED BY public.preferences.id;


--
-- Name: remember_tokens; Type: TABLE; Schema: public; Owner: koopa
--

CREATE TABLE public.remember_tokens (
    id integer NOT NULL,
    user_id integer NOT NULL,
    remember_token character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.remember_tokens OWNER TO koopa;

--
-- Name: remember_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: koopa
--

CREATE SEQUENCE public.remember_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.remember_tokens_id_seq OWNER TO koopa;

--
-- Name: remember_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: koopa
--

ALTER SEQUENCE public.remember_tokens_id_seq OWNED BY public.remember_tokens.id;


--
-- Name: schema_migration; Type: TABLE; Schema: public; Owner: koopa
--

CREATE TABLE public.schema_migration (
    version character varying(14) NOT NULL
);


ALTER TABLE public.schema_migration OWNER TO koopa;

--
-- Name: services; Type: TABLE; Schema: public; Owner: koopa
--

CREATE TABLE public.services (
    id integer NOT NULL,
    service_name character varying(255) NOT NULL,
    active integer DEFAULT 1 NOT NULL,
    icon character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.services OWNER TO koopa;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: koopa
--

CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_id_seq OWNER TO koopa;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: koopa
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: koopa
--

CREATE TABLE public.sessions (
    token text NOT NULL,
    data bytea NOT NULL,
    expiry timestamp with time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO koopa;

--
-- Name: users; Type: TABLE; Schema: public; Owner: koopa
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    user_active integer DEFAULT 0 NOT NULL,
    access_level integer DEFAULT 3 NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(60) NOT NULL,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO koopa;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: koopa
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO koopa;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: koopa
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: host_services id; Type: DEFAULT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.host_services ALTER COLUMN id SET DEFAULT nextval('public.host_services_id_seq'::regclass);


--
-- Name: hosts id; Type: DEFAULT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.hosts ALTER COLUMN id SET DEFAULT nextval('public.hosts_id_seq'::regclass);


--
-- Name: preferences id; Type: DEFAULT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.preferences ALTER COLUMN id SET DEFAULT nextval('public.preferences_id_seq'::regclass);


--
-- Name: remember_tokens id; Type: DEFAULT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.remember_tokens ALTER COLUMN id SET DEFAULT nextval('public.remember_tokens_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: host_services host_services_pkey; Type: CONSTRAINT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.host_services
    ADD CONSTRAINT host_services_pkey PRIMARY KEY (id);


--
-- Name: hosts hosts_pkey; Type: CONSTRAINT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.hosts
    ADD CONSTRAINT hosts_pkey PRIMARY KEY (id);


--
-- Name: preferences preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.preferences
    ADD CONSTRAINT preferences_pkey PRIMARY KEY (id);


--
-- Name: remember_tokens remember_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.remember_tokens
    ADD CONSTRAINT remember_tokens_pkey PRIMARY KEY (id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (token);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: schema_migration_version_idx; Type: INDEX; Schema: public; Owner: koopa
--

CREATE UNIQUE INDEX schema_migration_version_idx ON public.schema_migration USING btree (version);


--
-- Name: sessions_expiry_idx; Type: INDEX; Schema: public; Owner: koopa
--

CREATE INDEX sessions_expiry_idx ON public.sessions USING btree (expiry);


--
-- Name: events set_timestamp; Type: TRIGGER; Schema: public; Owner: koopa
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.events FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- Name: host_services set_timestamp; Type: TRIGGER; Schema: public; Owner: koopa
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.host_services FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- Name: hosts set_timestamp; Type: TRIGGER; Schema: public; Owner: koopa
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.hosts FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- Name: preferences set_timestamp; Type: TRIGGER; Schema: public; Owner: koopa
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.preferences FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- Name: remember_tokens set_timestamp; Type: TRIGGER; Schema: public; Owner: koopa
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.remember_tokens FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- Name: services set_timestamp; Type: TRIGGER; Schema: public; Owner: koopa
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.services FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- Name: users set_timestamp; Type: TRIGGER; Schema: public; Owner: koopa
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- Name: host_services host_services_hosts_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.host_services
    ADD CONSTRAINT host_services_hosts_id_fk FOREIGN KEY (host_id) REFERENCES public.hosts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: host_services host_services_services_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.host_services
    ADD CONSTRAINT host_services_services_id_fk FOREIGN KEY (service_id) REFERENCES public.services(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: remember_tokens remember_tokens_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: koopa
--

ALTER TABLE ONLY public.remember_tokens
    ADD CONSTRAINT remember_tokens_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

