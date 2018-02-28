--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.11
-- Dumped by pg_dump version 9.5.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: affiliates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE affiliates (
    id integer NOT NULL,
    name character varying NOT NULL,
    address character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: affiliates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE affiliates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: affiliates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE affiliates_id_seq OWNED BY affiliates.id;


--
-- Name: cars; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cars (
    id integer NOT NULL,
    brand character varying NOT NULL,
    car_model character varying NOT NULL,
    reg_number character varying NOT NULL,
    color character varying NOT NULL,
    style character varying NOT NULL,
    affiliate_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    car_status text DEFAULT 'Free'::text NOT NULL,
    CONSTRAINT check_brand_length CHECK ((char_length((brand)::text) <= 25)),
    CONSTRAINT check_car_model_length CHECK ((char_length((car_model)::text) <= 25)),
    CONSTRAINT check_color_length CHECK ((char_length((color)::text) <= 25)),
    CONSTRAINT check_style_length CHECK ((char_length((style)::text) <= 25)),
    CONSTRAINT reg_number_regex CHECK (((reg_number)::text ~ '[A-Z]{2}-[0-9]{4}-[1-7]'::text))
);


--
-- Name: cars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cars_id_seq OWNED BY cars.id;


--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE feedbacks (
    id integer NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    message character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT check_message_length CHECK ((char_length((message)::text) >= 10)),
    CONSTRAINT email_regex CHECK (((email)::text ~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'::text))
);


--
-- Name: feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE feedbacks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE feedbacks_id_seq OWNED BY feedbacks.id;


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE invoices (
    id integer NOT NULL,
    distance numeric DEFAULT 0 NOT NULL,
    total_price numeric DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    order_id integer NOT NULL,
    payed_amount numeric DEFAULT 0.0 NOT NULL,
    invoice_status text DEFAULT 'Unpaid'::text NOT NULL,
    indebtedness numeric DEFAULT 0.0 NOT NULL,
    CONSTRAINT check_distance_value CHECK ((distance >= (0)::numeric)),
    CONSTRAINT check_payed_amount_value CHECK ((payed_amount >= (0)::numeric)),
    CONSTRAINT check_total_price_value CHECK ((total_price >= (0)::numeric))
);


--
-- Name: invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE invoices_id_seq OWNED BY invoices.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE orders (
    id integer NOT NULL,
    car_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    end_point character varying NOT NULL,
    client_name character varying NOT NULL,
    client_phone character varying NOT NULL,
    user_id integer,
    tax_id integer NOT NULL,
    start_point character varying NOT NULL,
    order_status text DEFAULT 'New'::text NOT NULL,
    CONSTRAINT check_client_phone_length CHECK ((char_length((client_phone)::text) = 9))
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    filename text NOT NULL
);


--
-- Name: taxes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE taxes (
    id integer NOT NULL,
    cost_per_km numeric NOT NULL,
    basic_cost numeric NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    by_default boolean DEFAULT false NOT NULL,
    CONSTRAINT check_basic_cost_value CHECK ((basic_cost >= (0)::numeric)),
    CONSTRAINT check_cast_per_km_value CHECK ((cost_per_km >= (0)::numeric))
);


--
-- Name: taxes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taxes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taxes_id_seq OWNED BY taxes.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    phone character varying NOT NULL,
    affiliate_id integer,
    role text DEFAULT 'Client'::text NOT NULL,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    language text DEFAULT 'Russian'::text NOT NULL,
    unconfirmed_email text,
    CONSTRAINT check_phone_length CHECK ((char_length((phone)::text) = 9))
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY affiliates ALTER COLUMN id SET DEFAULT nextval('affiliates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cars ALTER COLUMN id SET DEFAULT nextval('cars_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY feedbacks ALTER COLUMN id SET DEFAULT nextval('feedbacks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY invoices ALTER COLUMN id SET DEFAULT nextval('invoices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxes ALTER COLUMN id SET DEFAULT nextval('taxes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: affiliates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY affiliates
    ADD CONSTRAINT affiliates_pkey PRIMARY KEY (id);


--
-- Name: cars_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (id);


--
-- Name: feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- Name: invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (filename);


--
-- Name: taxes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxes
    ADD CONSTRAINT taxes_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: affiliates_lower__name___index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX affiliates_lower__name___index ON affiliates USING btree (lower((name)::text));


--
-- Name: cars_reg_number_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX cars_reg_number_index ON cars USING btree (reg_number);


--
-- Name: index_cars_on_affiliate_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cars_on_affiliate_id ON cars USING btree (affiliate_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: taxes_lower__name___index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX taxes_lower__name___index ON taxes USING btree (lower((name)::text));


--
-- Name: fk_rails_880a1f8e56; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT fk_rails_880a1f8e56 FOREIGN KEY (car_id) REFERENCES cars(id);


--
-- Name: fk_rails_9524a0365f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cars
    ADD CONSTRAINT fk_rails_9524a0365f FOREIGN KEY (affiliate_id) REFERENCES affiliates(id);


--
-- Name: fk_rails_bfc01f48d8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT fk_rails_bfc01f48d8 FOREIGN KEY (tax_id) REFERENCES taxes(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;
INSERT INTO "schema_migrations" ("filename") VALUES ('20180207091406_null_migration.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180209150737_remove_enum_from_cars.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180209150747_remove_enum_from_invoices.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180209150807_remove_enum_from_orders.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180209150817_remove_enum_from_users.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180212072635_affiliates_refactoring.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180213102240_cars_refactoring.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180213113300_invoices_refactoring.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180213124827_orders_refactoring.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180213150546_taxes_refactoring.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180213152314_feedbacks_refactoring.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180214080807_users_refactoring.rb');