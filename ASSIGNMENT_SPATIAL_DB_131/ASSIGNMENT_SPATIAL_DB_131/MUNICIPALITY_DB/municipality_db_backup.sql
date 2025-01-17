PGDMP                         {           MUNICIPALITY_DB    13.9    15.2 H    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16407    MUNICIPALITY_DB    DATABASE     �   CREATE DATABASE "MUNICIPALITY_DB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Greek_Greece.1252';
 !   DROP DATABASE "MUNICIPALITY_DB";
                postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false            �           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    5                        3079    18895    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false    5            �           0    0    EXTENSION postgis    COMMENT     ^   COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';
                        false    2            �            1259    19968    athletic_facility    TABLE     �   CREATE TABLE public.athletic_facility (
    af_id integer NOT NULL,
    name_af character varying(15) DEFAULT NULL::character varying,
    boundary public.geometry,
    number_of_courts integer
);
 %   DROP TABLE public.athletic_facility;
       public         heap    postgres    false    2    2    5    2    5    2    5    2    5    5    2    5    2    5    2    5    5            �            1259    19927    building    TABLE     �  CREATE TABLE public.building (
    code_b character varying(10) NOT NULL,
    location_name character varying(15) DEFAULT NULL::character varying,
    name_b character varying(15) DEFAULT NULL::character varying,
    adress character varying(15) DEFAULT NULL::character varying,
    adress_num integer,
    tk integer,
    location_b public.geometry,
    structured_wiring boolean
);
    DROP TABLE public.building;
       public         heap    postgres    false    2    2    5    2    5    2    5    2    5    5    2    5    2    5    2    5    5            �            1259    24709    building_area_view    VIEW     �   CREATE VIEW public.building_area_view AS
 SELECT building.code_b,
    building.name_b,
    public.st_area(building.location_b) AS building_area
   FROM public.building;
 %   DROP VIEW public.building_area_view;
       public          postgres    false    213    2    5    2    2    5    2    5    2    5    2    5    5    2    5    2    5    2    5    213    213    5            �            1259    16498    employee    TABLE     �  CREATE TABLE public.employee (
    am integer NOT NULL,
    position_emp character varying(15) DEFAULT NULL::character varying,
    emp_number integer,
    first_name character varying(50) DEFAULT NULL::character varying,
    last_name character varying(50) DEFAULT NULL::character varying,
    sex character varying(10) DEFAULT NULL::character varying,
    degree_emp character varying(50) DEFAULT NULL::character varying,
    education character varying(50) DEFAULT NULL::character varying,
    email character varying(50) DEFAULT NULL::character varying,
    mob_number bigint,
    off_number bigint,
    code_group character varying,
    building character varying(50) DEFAULT NULL::character varying
);
    DROP TABLE public.employee;
       public         heap    postgres    false    5            �            1259    19980    employee_af    TABLE     Y   CREATE TABLE public.employee_af (
    am integer NOT NULL,
    af_id integer NOT NULL
);
    DROP TABLE public.employee_af;
       public         heap    postgres    false    5            �            1259    19977    employee_lake    TABLE     ]   CREATE TABLE public.employee_lake (
    am integer NOT NULL,
    lake_id integer NOT NULL
);
 !   DROP TABLE public.employee_lake;
       public         heap    postgres    false    5            �            1259    16532    personal_computer    TABLE     �  CREATE TABLE public.personal_computer (
    computer_id character varying(35) NOT NULL,
    ip character varying(15) DEFAULT NULL::character varying,
    model character varying(35) DEFAULT NULL::character varying,
    monitor character varying(35) DEFAULT NULL::character varying,
    type_pc character varying(35) DEFAULT NULL::character varying,
    cpu character varying(35) DEFAULT NULL::character varying,
    hard_disc character varying(35) DEFAULT NULL::character varying,
    ram character varying(35) DEFAULT NULL::character varying,
    os character varying(15) DEFAULT NULL::character varying,
    am_employee integer,
    building character varying(15) DEFAULT NULL::character varying
);
 %   DROP TABLE public.personal_computer;
       public         heap    postgres    false    5            �            1259    24705    employee_pc    VIEW        CREATE VIEW public.employee_pc AS
 SELECT employee.am,
    employee.first_name,
    personal_computer.computer_id,
    personal_computer.model
   FROM (public.employee
     JOIN public.personal_computer ON ((employee.am = personal_computer.am_employee)));
    DROP VIEW public.employee_pc;
       public          postgres    false    201    203    203    203    201    5            �            1259    19983    employee_road    TABLE     ]   CREATE TABLE public.employee_road (
    am integer NOT NULL,
    road_id integer NOT NULL
);
 !   DROP TABLE public.employee_road;
       public         heap    postgres    false    5            �            1259    24713    employees_view    VIEW     >  CREATE VIEW public.employees_view AS
 SELECT e.am,
    e.first_name,
    b.code_b,
    a.name_af
   FROM (((public.employee e
     JOIN public.building b ON (((e.building)::text = (b.code_b)::text)))
     JOIN public.employee_af ea ON ((e.am = ea.am)))
     JOIN public.athletic_facility a ON ((ea.af_id = a.af_id)));
 !   DROP VIEW public.employees_view;
       public          postgres    false    201    201    201    217    217    215    215    213    5            �            1259    16573 	   it_system    TABLE     �  CREATE TABLE public.it_system (
    name_it character varying(30) NOT NULL,
    operating_system character varying(30) DEFAULT NULL::character varying,
    maintenance_company character varying(20) DEFAULT NULL::character varying,
    end_of_contract_maintenance character varying(20) DEFAULT NULL::character varying,
    manufacturer character varying(20) DEFAULT NULL::character varying,
    database_it character varying(20) DEFAULT NULL::character varying,
    server_code integer
);
    DROP TABLE public.it_system;
       public         heap    postgres    false    5            �            1259    19946    lake    TABLE     �   CREATE TABLE public.lake (
    lake_id integer NOT NULL,
    name_l character varying(15) DEFAULT NULL::character varying,
    lake_boundary public.geometry,
    suitable_for_fishing boolean
);
    DROP TABLE public.lake;
       public         heap    postgres    false    5    2    2    5    2    5    2    5    2    5    5    2    5    2    5    2    5            �            1259    16514 	   ota_group    TABLE     *  CREATE TABLE public.ota_group (
    codeg character varying(10) NOT NULL,
    kind_g character varying(15) DEFAULT NULL::character varying,
    name_og character varying(15) DEFAULT NULL::character varying,
    am_boss integer,
    building character varying(10) DEFAULT NULL::character varying
);
    DROP TABLE public.ota_group;
       public         heap    postgres    false    5            �            1259    24679    road    TABLE     p  CREATE TABLE public.road (
    road_id integer NOT NULL,
    name_r character varying(50) DEFAULT NULL::character varying,
    type_r character varying(50) DEFAULT NULL::character varying,
    route public.geometry,
    af_id integer,
    lake_id integer NOT NULL,
    two_directions boolean,
    code_building character varying(50) DEFAULT NULL::character varying
);
    DROP TABLE public.road;
       public         heap    postgres    false    2    2    5    2    5    2    5    2    5    5    2    5    2    5    2    5    5            �            1259    16568    servers    TABLE     '  CREATE TABLE public.servers (
    code integer NOT NULL,
    model character varying(25),
    ip character varying(50),
    hard_disk character varying(50),
    os character varying(50),
    cores integer,
    cpu character varying(50),
    ram_gb integer,
    building character varying(50)
);
    DROP TABLE public.servers;
       public         heap    postgres    false    5            �            1259    16551 	   telephony    TABLE     �  CREATE TABLE public.telephony (
    telephon_number bigint NOT NULL,
    blocked_mobile character(1),
    voip character(1),
    speed_mbs integer,
    connection_type character varying(15),
    router_model character varying(20),
    telephony_center character varying(15),
    provider character varying(10),
    building character varying(15),
    device_model character varying(15)
);
    DROP TABLE public.telephony;
       public         heap    postgres    false    5            �            1259    16556    ups    TABLE     �   CREATE TABLE public.ups (
    code_ups integer NOT NULL,
    model character varying(35) DEFAULT NULL::character varying,
    kva integer,
    ac_socket integer,
    pc_code character varying(35) DEFAULT NULL::character varying
);
    DROP TABLE public.ups;
       public         heap    postgres    false    5            �          0    19968    athletic_facility 
   TABLE DATA           W   COPY public.athletic_facility (af_id, name_af, boundary, number_of_courts) FROM stdin;
    public          postgres    false    215   yd       �          0    19927    building 
   TABLE DATA           x   COPY public.building (code_b, location_name, name_b, adress, adress_num, tk, location_b, structured_wiring) FROM stdin;
    public          postgres    false    213   �d       �          0    16498    employee 
   TABLE DATA           �   COPY public.employee (am, position_emp, emp_number, first_name, last_name, sex, degree_emp, education, email, mob_number, off_number, code_group, building) FROM stdin;
    public          postgres    false    201   Pf       �          0    19980    employee_af 
   TABLE DATA           0   COPY public.employee_af (am, af_id) FROM stdin;
    public          postgres    false    217   �l       �          0    19977    employee_lake 
   TABLE DATA           4   COPY public.employee_lake (am, lake_id) FROM stdin;
    public          postgres    false    216   em       �          0    19983    employee_road 
   TABLE DATA           4   COPY public.employee_road (am, road_id) FROM stdin;
    public          postgres    false    218    n       �          0    16573 	   it_system 
   TABLE DATA           �   COPY public.it_system (name_it, operating_system, maintenance_company, end_of_contract_maintenance, manufacturer, database_it, server_code) FROM stdin;
    public          postgres    false    207   �n       �          0    19946    lake 
   TABLE DATA           T   COPY public.lake (lake_id, name_l, lake_boundary, suitable_for_fishing) FROM stdin;
    public          postgres    false    214   %p       �          0    16514 	   ota_group 
   TABLE DATA           N   COPY public.ota_group (codeg, kind_g, name_og, am_boss, building) FROM stdin;
    public          postgres    false    202   �p       �          0    16532    personal_computer 
   TABLE DATA           �   COPY public.personal_computer (computer_id, ip, model, monitor, type_pc, cpu, hard_disc, ram, os, am_employee, building) FROM stdin;
    public          postgres    false    203   �q       �          0    24679    road 
   TABLE DATA           m   COPY public.road (road_id, name_r, type_r, route, af_id, lake_id, two_directions, code_building) FROM stdin;
    public          postgres    false    219   �v       �          0    16568    servers 
   TABLE DATA           _   COPY public.servers (code, model, ip, hard_disk, os, cores, cpu, ram_gb, building) FROM stdin;
    public          postgres    false    206   *x       �          0    19205    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          postgres    false    209   �y       �          0    16551 	   telephony 
   TABLE DATA           �   COPY public.telephony (telephon_number, blocked_mobile, voip, speed_mbs, connection_type, router_model, telephony_center, provider, building, device_model) FROM stdin;
    public          postgres    false    204   �y       �          0    16556    ups 
   TABLE DATA           G   COPY public.ups (code_ups, model, kva, ac_socket, pc_code) FROM stdin;
    public          postgres    false    205   �z                  2606    19976 (   athletic_facility athletic_facility_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.athletic_facility
    ADD CONSTRAINT athletic_facility_pkey PRIMARY KEY (af_id);
 R   ALTER TABLE ONLY public.athletic_facility DROP CONSTRAINT athletic_facility_pkey;
       public            postgres    false    215                       2606    19938    building building_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.building
    ADD CONSTRAINT building_pkey PRIMARY KEY (code_b);
 @   ALTER TABLE ONLY public.building DROP CONSTRAINT building_pkey;
       public            postgres    false    213                       2606    20055    employee_af employee_af_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.employee_af
    ADD CONSTRAINT employee_af_pkey PRIMARY KEY (am, af_id);
 F   ALTER TABLE ONLY public.employee_af DROP CONSTRAINT employee_af_pkey;
       public            postgres    false    217    217                       2606    20053     employee_lake employee_lake_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.employee_lake
    ADD CONSTRAINT employee_lake_pkey PRIMARY KEY (am, lake_id);
 J   ALTER TABLE ONLY public.employee_lake DROP CONSTRAINT employee_lake_pkey;
       public            postgres    false    216    216            �           2606    16513    employee employee_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (am);
 @   ALTER TABLE ONLY public.employee DROP CONSTRAINT employee_pkey;
       public            postgres    false    201                       2606    20057     employee_road employee_road_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.employee_road
    ADD CONSTRAINT employee_road_pkey PRIMARY KEY (am, road_id);
 J   ALTER TABLE ONLY public.employee_road DROP CONSTRAINT employee_road_pkey;
       public            postgres    false    218    218                       2606    16582    it_system it_system_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.it_system
    ADD CONSTRAINT it_system_pkey PRIMARY KEY (name_it);
 B   ALTER TABLE ONLY public.it_system DROP CONSTRAINT it_system_pkey;
       public            postgres    false    207                       2606    19955    lake lake_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.lake
    ADD CONSTRAINT lake_pkey PRIMARY KEY (lake_id);
 8   ALTER TABLE ONLY public.lake DROP CONSTRAINT lake_pkey;
       public            postgres    false    214            �           2606    16521    ota_group ota_group_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.ota_group
    ADD CONSTRAINT ota_group_pkey PRIMARY KEY (codeg);
 B   ALTER TABLE ONLY public.ota_group DROP CONSTRAINT ota_group_pkey;
       public            postgres    false    202            �           2606    16545 (   personal_computer personal_computer_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.personal_computer
    ADD CONSTRAINT personal_computer_pkey PRIMARY KEY (computer_id);
 R   ALTER TABLE ONLY public.personal_computer DROP CONSTRAINT personal_computer_pkey;
       public            postgres    false    203                       2606    24689    road road_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.road
    ADD CONSTRAINT road_pkey PRIMARY KEY (road_id);
 8   ALTER TABLE ONLY public.road DROP CONSTRAINT road_pkey;
       public            postgres    false    219                       2606    16572    servers servers_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_pkey PRIMARY KEY (code);
 >   ALTER TABLE ONLY public.servers DROP CONSTRAINT servers_pkey;
       public            postgres    false    206                       2606    16555    telephony telephony_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.telephony
    ADD CONSTRAINT telephony_pkey PRIMARY KEY (telephon_number);
 B   ALTER TABLE ONLY public.telephony DROP CONSTRAINT telephony_pkey;
       public            postgres    false    204                       2606    16562    ups ups_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.ups
    ADD CONSTRAINT ups_pkey PRIMARY KEY (code_ups);
 6   ALTER TABLE ONLY public.ups DROP CONSTRAINT ups_pkey;
       public            postgres    false    205            $           2606    20108 "   employee_af employee_af_af_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employee_af
    ADD CONSTRAINT employee_af_af_id_fkey FOREIGN KEY (af_id) REFERENCES public.athletic_facility(af_id);
 L   ALTER TABLE ONLY public.employee_af DROP CONSTRAINT employee_af_af_id_fkey;
       public          postgres    false    217    215    3855            %           2606    20118    employee_af employee_af_am_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.employee_af
    ADD CONSTRAINT employee_af_am_fkey FOREIGN KEY (am) REFERENCES public.employee(am);
 I   ALTER TABLE ONLY public.employee_af DROP CONSTRAINT employee_af_am_fkey;
       public          postgres    false    217    201    3835                       2606    24624    employee employee_building_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_building_fkey FOREIGN KEY (building) REFERENCES public.building(code_b);
 I   ALTER TABLE ONLY public.employee DROP CONSTRAINT employee_building_fkey;
       public          postgres    false    213    201    3851                       2606    16527 !   employee employee_code_group_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_code_group_fkey FOREIGN KEY (code_group) REFERENCES public.ota_group(codeg);
 K   ALTER TABLE ONLY public.employee DROP CONSTRAINT employee_code_group_fkey;
       public          postgres    false    202    3837    201            "           2606    20123 #   employee_lake employee_lake_am_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employee_lake
    ADD CONSTRAINT employee_lake_am_fkey FOREIGN KEY (am) REFERENCES public.employee(am);
 M   ALTER TABLE ONLY public.employee_lake DROP CONSTRAINT employee_lake_am_fkey;
       public          postgres    false    216    3835    201            #           2606    20088 (   employee_lake employee_lake_lake_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employee_lake
    ADD CONSTRAINT employee_lake_lake_id_fkey FOREIGN KEY (lake_id) REFERENCES public.lake(lake_id);
 R   ALTER TABLE ONLY public.employee_lake DROP CONSTRAINT employee_lake_lake_id_fkey;
       public          postgres    false    216    214    3853            &           2606    20113 #   employee_road employee_road_am_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employee_road
    ADD CONSTRAINT employee_road_am_fkey FOREIGN KEY (am) REFERENCES public.employee(am);
 M   ALTER TABLE ONLY public.employee_road DROP CONSTRAINT employee_road_am_fkey;
       public          postgres    false    3835    201    218            !           2606    16583    it_system it_system_ibfk_1    FK CONSTRAINT     �   ALTER TABLE ONLY public.it_system
    ADD CONSTRAINT it_system_ibfk_1 FOREIGN KEY (server_code) REFERENCES public.servers(code);
 D   ALTER TABLE ONLY public.it_system DROP CONSTRAINT it_system_ibfk_1;
       public          postgres    false    3845    206    207                       2606    20068 !   ota_group ota_group_building_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ota_group
    ADD CONSTRAINT ota_group_building_fkey FOREIGN KEY (building) REFERENCES public.building(code_b);
 K   ALTER TABLE ONLY public.ota_group DROP CONSTRAINT ota_group_building_fkey;
       public          postgres    false    202    213    3851                       2606    16522    ota_group ota_group_ibfk_1    FK CONSTRAINT     |   ALTER TABLE ONLY public.ota_group
    ADD CONSTRAINT ota_group_ibfk_1 FOREIGN KEY (am_boss) REFERENCES public.employee(am);
 D   ALTER TABLE ONLY public.ota_group DROP CONSTRAINT ota_group_ibfk_1;
       public          postgres    false    202    201    3835                       2606    20073 1   personal_computer personal_computer_building_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.personal_computer
    ADD CONSTRAINT personal_computer_building_fkey FOREIGN KEY (building) REFERENCES public.building(code_b);
 [   ALTER TABLE ONLY public.personal_computer DROP CONSTRAINT personal_computer_building_fkey;
       public          postgres    false    203    3851    213                       2606    16546 *   personal_computer personal_computer_ibfk_1    FK CONSTRAINT     �   ALTER TABLE ONLY public.personal_computer
    ADD CONSTRAINT personal_computer_ibfk_1 FOREIGN KEY (am_employee) REFERENCES public.employee(am);
 T   ALTER TABLE ONLY public.personal_computer DROP CONSTRAINT personal_computer_ibfk_1;
       public          postgres    false    3835    203    201            '           2606    24690    road road_af_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.road
    ADD CONSTRAINT road_af_id_fkey FOREIGN KEY (af_id) REFERENCES public.athletic_facility(af_id);
 >   ALTER TABLE ONLY public.road DROP CONSTRAINT road_af_id_fkey;
       public          postgres    false    219    3855    215            (           2606    24700    road road_code_building_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.road
    ADD CONSTRAINT road_code_building_fkey FOREIGN KEY (code_building) REFERENCES public.building(code_b);
 F   ALTER TABLE ONLY public.road DROP CONSTRAINT road_code_building_fkey;
       public          postgres    false    219    3851    213            )           2606    24695    road road_lake_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.road
    ADD CONSTRAINT road_lake_id_fkey FOREIGN KEY (lake_id) REFERENCES public.lake(lake_id);
 @   ALTER TABLE ONLY public.road DROP CONSTRAINT road_lake_id_fkey;
       public          postgres    false    219    3853    214                        2606    24629    servers servers_building_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_building_fkey FOREIGN KEY (building) REFERENCES public.building(code_b);
 G   ALTER TABLE ONLY public.servers DROP CONSTRAINT servers_building_fkey;
       public          postgres    false    213    3851    206                       2606    20083 !   telephony telephony_building_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.telephony
    ADD CONSTRAINT telephony_building_fkey FOREIGN KEY (building) REFERENCES public.building(code_b);
 K   ALTER TABLE ONLY public.telephony DROP CONSTRAINT telephony_building_fkey;
       public          postgres    false    3851    213    204                       2606    16563    ups ups_ibfk_1    FK CONSTRAINT     �   ALTER TABLE ONLY public.ups
    ADD CONSTRAINT ups_ibfk_1 FOREIGN KEY (pc_code) REFERENCES public.personal_computer(computer_id);
 8   ALTER TABLE ONLY public.ups DROP CONSTRAINT ups_ibfk_1;
       public          postgres    false    203    3839    205            �   c   x���1
�@��1�IT��y��\u`i���kln�e���ԣ���'�u��
~q�g�Ñ=2�&�I�����{�lMȲB�C�>���60�,f{�      �   T  x���[K�@��'?&���S�V�Q�E�J@Z����]�C\��%�&r��9a7�z������r�{W��g��?84]��v<r�B��g��~�j����j1�&���Z]o�f���IE" �m,��tR5�&��{��>��T"�L���`���f��6S6�}s�t��FO���=�*$U�T��Z牤̩�F����K&���?��<�{��T'R��<�z��v�}>��T��:�� �I�&&�3N$�GSu��Қ�7x�l��Ymb�1�\PQKGu3k��`�u�h����bxò!����ά	zh�8�Y}b�1�a�Yg-^�yD	z���uUU?s#�C      �   p  x����n�8������A��2�j��%C��(�R#1��A�.��wHI��{�] I�r83�|�ДܕuM(�Z�
��;�(w�~S�dKv9��,'_�O��Ϗ�������J���4�8%�� q����?_���N7	Y�r��"�ɪ��EC٪uNd���7J���YV�FK�z|>�����F�x��T�a��:P��d��ne}C�m�jM8Q�,
	a�U�'_�������&��3�x83�����g
�.�F�$[U�n�TS��&�O���H��C@���˼"!|W)�]�\t{'�ݾVE�xmߏ��=\����wS.m���;��B���2/��27���d�2�!��������|j�o��77QBd]C$�bmr(�H*:H�Z禕��é}sc0���~G�V���oeus��|��t��jiʢ�B�@�PP������к!�!RbѷUH"1��U]V��҉@_T�`�OF������O$�(���+7}"�\iH�}�)!������=te]���09��$+��}�W��L�[�r���	�R���Y!A^4��V�B���E��e%7��jYI�6������ы�`�(KX��¨Y�Qf��l�zFko��|q��b�Z-�(�(�E�5�����ERWˌ���^�(8�BX��\xj瑊~X:M���H;�(j#9_�^p�9�'�,�aO�8d�_�Qv��ޏ���}q#���'�h:i����t�$��C��.�U��������� 
�����hQ<"��@�:'Kw��ۏ�;��B�!D������Hn@�OFHu.��g������t�x�F2��J{4@I��K��|�iݍ���c�!xb�m�5�@���R�ܤ4˅��ǻ�E2�x��,���jn�R{��C���i&;���ф���Pe�c�^��B����^m���t�hOZ�n4D=�3���v|��^7L� �V������")���9�e�y��X\�oW�!����0T�B���<#�-)�Q�|q!A����b�	�1���"�Ix�B>p:ѷ�[41YX���rʈ�狧7dǥa�+X�Ho��V�������(��8�H)����iS���&�{��M3#��`��M)���x@���71'�ս�>��q�~�@�3����gjO�b,��i��ޚ����;w� X��k6�c�q��t՛LV�H&<�s}� :.P�S�;�������񉾵�#����a4�sFa�u
����s�K�e7���O����`����ւE�[�j��� X0�U�(��>ڽc�F>�M'j7ڋ�}����Ｂs�_/�_���4��K�g���J�1f���ž����
j0�����;���aE3�� ��W�p*8�^S�DN�r]>AG���s���r�cl����D�&+؃
�Ǯ�"(�OA�R���`�GO��D�����q����"/"6պ. ��_4R��2u� #":��N���"1��y|��i�c&3�5 ����y��T�|w�N�����O�\_&�(�u����0�u�)pS>A��S!�>]���u�f���\���~���������Q�lF      �   �   x��ёE!�o)f�B@���K��&A��6{� �$�'���X�ث�?�]_�N���lZq��6��3�q��Rg
��J*��N+�z��?J �$�	����5�w<�^Hg��6�9�N�vt7[�0����?E�*�      �   �   x����E!ϏbV�I����c390�,l���ǀ� ��:�Q޸��a�?_�כJ�F�䱝����#k������B1MFt,l���Ⱦ���f&~wNl���y&���c���Ɂ'OvFMsi~k��*O      �   �   x�%�QAC�oӳ$0������V�兰�1x��	KOXy�?c�M�c�[��C�����+�rQ�Ӓ�%3���x�0��
�#��R��[S�ؾ�O
3V�軗�������<�̆0տxW8u�qg'�oY�Z�|q�������q�P�+�      �   h  x����r�0���)�h��U���ZѪ�n��3�h�p���K�1���{�o��s�
u��A�x�L펟"z�}&��.�]�)�X�r��X`ߙ���ure8:��a����(偘P*��#�IT�G���j+��K��H���Ķ�r��RlD!	x�0�T���R��)�Z�4-�ő����Ӗg)�`x�	n���� �ŦReUC�`4����A�3�%�R�������]kt�1}��L��X�hX���<+$��&����ҵ5�����;�>͚��b�R~�!� ������\Ҭōk%�n�y���3l�/2`���i�����vx�#��+�P���q~�k(�      �   z   x�3��I�N5�40406� C(mj��������&$ʣ�1�'$�s�p�=aD�'����9����1�Ψ|�	���L�2{��'�0=��!cF�<11�����h�R�$�b���� �yE      �   �   x�U�_n�0Ɵ�� �	D��p��E���� ;�N27���~��X���,�1��
x�^���"�0R¬+��o�,W��?����c�Ku��)5X6Wn�hc���m�2�/n<��l�<#��K��bv$ۑ2�9J}����O3���R�$Z��U W����KES\�&8t���D�N��i������||4ι?B[	      �   _  x����R�H���S��5�.�
*�dko��
*�+;ǧ��z��ݫ$$�O����ݓ��H
=;��m��lS|/��1�<%���4-�.6���u���(7>E ��[.������&���7ŏ<�e4?��&��'ɩ�$�%��:�g��٘���2`b�gH��� �t�"\4��kv�,�P�PSչ��F�O�Xu��2��U�x������K�I�N�;�ؕß�8z�vO�=\��P��p���d:[�"IsJ�M���<Yg?p��B f�B�m����R�t���>I�=_�ņ-ү���7���lI7�~gL��?���}��<;���}V��n�c�V�� �jj��<�����pDLD�PP�ݷ��^����~���n�P��0���Q=�@YW��o*TLQ]-��b�5��t�$�Jt�t ��>���� lU5IY��0L��)�@���e��z-41��R\ 7�-~��bb����&��`N)�bx����W]^�*/�#T]>uؤ�$j�}��e`���6����M�|C2��F��R~.���8#6��],ۘ�$U��|�Y(	j7mb��_rM8J	�i��6�^T��[4�0�|�H�[Xm��R�B8���G���K/8;�5�P�Jױ[��;�����5���4C4�J����tE�js�,IY��wRf�(�Y���-�@�l�w
�S��M	�4�`aC��Ŝ�����ȃ�u�p|�S�sD�17������Ym�/u18�<ˢ!���,��~�g�}�U��C�ja8o#�ly�b��v5�M������l�#ź�}+�2e7�`¶������tD����Wac�P
�Ň�n�����T'���g����kM}xL���@� :���+�(�B!(J�nqn|�5�! ����C#Q�!;XU�QD	 ��Ԩy쵬#4#ɵ�j�����~z�0 ��4I��\`8����C�$�d0�?�U�K��I���l������F���-�t��t��y��R!8�BK��U�'C���I����u-������)􈮨��Ұ�#D��l�S��o��^[i���/�ng;�(p� �r�Y�������E���=���F3���j�]����
3�K���oE'l�}������?�tq���uJC·�|���W6��qth�m_��j�8�x��.�1�zF��f�na6��.����a�n����+>'�?��n&-|5�TsA,A�c#VC%Jk;Ѝ�zs��|�T5���o+�DPf�H/�۬����Õ��f�/WR��C8<��߽m�l�$ZD��֡��x̀؎l�}e��0$�5�S�lp���ȿA����'''�����      �   (  x���QK�0��o~LIn��{,ӡ��XA|�M�)����6*�	�M��S���[��㫁�������Ѩ�euf��n��fv����ylS��F���5��^!!���4�x�y���u~~n�yΰ��7��,�X�Y3η.����4����r�㄁�+�.����pPZ��<���s��KuOcc`���xZ!O�}%=�g
��ޟ��Y�RX-���\獛��w�v �:Bꄝ��T��J�A�3��ԯ�h%#��b�WJ�X�(�f��g��I�4��(i^���F)�\�)�      �   �  x����N�@��w�b_�fw�=]%Hi,*$�hh"	)O�]�^����?�(VV�C�ULyH�q�J�dZ�aO�e�V�r��&��H�c�zW�ż��b�;`@2eX>�$E��C���?�z�*��������}��`"3��;�ŠX��$,6I���iĥ"a�1UL;
�<f�FrqͳH�(5=J�܍d��w�R�02��~~U��"�R�Qa��-��),�'��y������8;Z�6�O���T���^h��i�hj#�R�9��W��Q��f�R�@�ֺ��h�"�Q�%�u�[\9�y�D>�<�[����8�1P�Ѐ1�P��yI��l��~Iu��������k�q�m��Z�����A�_��Fﰶ�h���=)zP��Zp�j��44�ή�c�9��%Y      �      x������ � �      �   �   x����
�@��������{'u�R.�4!!�6"-!ߟ�!��9��_ĲJIzy�zi���*�y�"�p���%χG�������뼯r�ݻ��ȹ���ޖyo���S����>F0mXZ�ՁK{,���tɥ.}�Ҝ��}H�4FNc�4��8��i4N�q��h�F�4��8��iTN�r�Ө�F�4*�Q9��iTF�+w�� ��Oh      �   �   x�E�9B1Dk�0(�,?���8 %tHܿcB2�ʣ�xy	�}��wX$�ݯ�X�2	</����d�cր�:��Y9kv��/��,�F���ǯ{>�k�3�[ɳ��3�r����׽���	7-e$?ďs�A܅�d�%Π�[}�D�q�A�˕aoU!U�=T�T�WU!U��
�2hz���ݿ�iV     