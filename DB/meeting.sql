-- Create table
create table MEETING_BOOKROOM
(
  id        NUMBER not null,
  roomid    NUMBER not null,
  meetingid NUMBER not null,
  userid    VARCHAR2(16) not null,
  org       VARCHAR2(16) not null,
  starttime DATE not null,
  endtime   DATE not null,
  status    NUMBER not null,
  creatdate DATE default sysdate not null
)
tablespace TS_INTRAWEB
  pctfree 10
  initrans 1
  maxtrans 255;
-- Add comments to the columns 
comment on column MEETING_BOOKROOM.roomid
  is '������id';
comment on column MEETING_BOOKROOM.meetingid
  is '����id';
comment on column MEETING_BOOKROOM.userid
  is 'Ա�����';
comment on column MEETING_BOOKROOM.org
  is '����';
comment on column MEETING_BOOKROOM.starttime
  is '��ʼʱ��';
comment on column MEETING_BOOKROOM.endtime
  is '����ʱ��';
comment on column MEETING_BOOKROOM.status
  is '״̬:1.������2.�û�ȡ��';
comment on column MEETING_BOOKROOM.creatdate
  is '����ʱ��';

-- Create table
create table MEETING_COMMON
(
  id      NUMBER not null,
  title   VARCHAR2(128),
  type    NUMBER,
  common1 VARCHAR2(256),
  common2 VARCHAR2(256),
  common3 VARCHAR2(256)
)
tablespace TS_INTRAWEB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table MEETING_COMMON
  is '���ڴ���ⵥλ���ƺ͹̶���ν';
-- Add comments to the columns 
comment on column MEETING_COMMON.type
  is '1���̶���ν��2��������λ��';
-- Create/Recreate primary, unique and foreign key constraints 
alter table MEETING_COMMON
  add constraint PK_MEETING_COMMON primary key (ID)
  using index 
  tablespace TS_INTRAWEB
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


-- Create table
create table MEETING_EXPLAIN
(
  id       NUMBER not null,
  name     VARCHAR2(128),
  style    NUMBER,
  unit     VARCHAR2(8),
  parentid NUMBER,
  display  NUMBER
)
tablespace TS_INTRAWEB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table MEETING_EXPLAIN
  is '�����й�˵��������';
-- Add comments to the columns 
comment on column MEETING_EXPLAIN.style
  is '1:��ѡ��;2:�ı���;3:�����б�';
comment on column MEETING_EXPLAIN.display
  is '0:����;1:��ʾ;';
-- Create/Recreate primary, unique and foreign key constraints 
alter table MEETING_EXPLAIN
  add constraint PK_MEETING_EXPLAIN primary key (ID)
  using index 
  tablespace TS_INTRAWEB
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Create table
create table MEETING_MONEY
(
  id      NUMBER not null,
  org     VARCHAR2(8),
  orgsort NUMBER,
  orgname VARCHAR2(64),
  year    NUMBER(4),
  money   NUMBER(10,2)
)
tablespace TS_INTRAWEB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table MEETING_MONEY
  is '����Ԥ�㾭��';
-- Add comments to the columns 
comment on column MEETING_MONEY.org
  is '���ű���';
comment on column MEETING_MONEY.orgsort
  is '��������';
comment on column MEETING_MONEY.orgname
  is '��������';
comment on column MEETING_MONEY.year
  is '��';
comment on column MEETING_MONEY.money
  is '����Ԥ����';
-- Create/Recreate primary, unique and foreign key constraints 
alter table MEETING_MONEY
  add constraint PK_MEETING_MONE primary key (ID)
  using index 
  tablespace TS_INTRAWEB
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Create table
create table MEETING_PLAN
(
  id             NUMBER(10) not null,
  starttime      DATE,
  endtime        DATE,
  content        VARCHAR2(512),
  leader         VARCHAR2(300),
  depart         VARCHAR2(400),
  remark         VARCHAR2(500),
  creattime      DATE default sysdate,
  commiterid     VARCHAR2(8),
  commitdepart   VARCHAR2(30),
  type           VARCHAR2(1),
  presider       VARCHAR2(50),
  grade          VARCHAR2(1),
  category       NUMBER,
  fdepart        VARCHAR2(400),
  budget         NUMBER default 0.00,
  contact        VARCHAR2(64),
  address        VARCHAR2(500),
  contactphone   VARCHAR2(16),
  reserve_roomid NUMBER,
  org            VARCHAR2(8),
  meetingid      NUMBER
)
tablespace TS_INTRAWEB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column MEETING_PLAN.starttime
  is '���鿪ʼʱ��';
comment on column MEETING_PLAN.endtime
  is '�������ʱ��';
comment on column MEETING_PLAN.content
  is '��������';
comment on column MEETING_PLAN.leader
  is '�����쵼';
comment on column MEETING_PLAN.depart
  is '�μӻ��鲿��';
comment on column MEETING_PLAN.remark
  is '����˵��';
comment on column MEETING_PLAN.creattime
  is '���������ύʱ��';
comment on column MEETING_PLAN.commiterid
  is '�����ύ��id';
comment on column MEETING_PLAN.commitdepart
  is '�������벿��';
comment on column MEETING_PLAN.type
  is '��������(1����;2:�ڲ�����;3�ⲿ����;4:��ѵ)';
comment on column MEETING_PLAN.presider
  is '����������';
comment on column MEETING_PLAN.grade
  is '���鼶��(1:�ۺϻ���;2:���ڻ���)';
comment on column MEETING_PLAN.category
  is '1��ͨ�ã�2������1-2�Ż��飻3������3-4�Ż��飻4������5-6�Ż���';
comment on column MEETING_PLAN.fdepart
  is '�λ��ϼ�/�ⵥλ���쵼';
comment on column MEETING_PLAN.budget
  is '����Ԥ�����';
comment on column MEETING_PLAN.contact
  is '������ϵ��';
comment on column MEETING_PLAN.contactphone
  is '��ϵ�˵绰';
comment on column MEETING_PLAN.reserve_roomid
  is 'Ԥ��������';
comment on column MEETING_PLAN.org
  is '��֯����';
comment on column MEETING_PLAN.meetingid
  is '��ʽ����id';

-- Create table
create table MEETING_ROOM
(
  id       NUMBER(10) not null,
  roomname VARCHAR2(20),
  capacity NUMBER(4),
  remark   VARCHAR2(200),
  parentid NUMBER(10),
  type     NUMBER(1) default 1
)
tablespace TS_INTRAWEB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column MEETING_ROOM.type
  is '1:������;2:��ѵ���Ľ���';
-- Create/Recreate primary, unique and foreign key constraints 
alter table MEETING_ROOM
  add constraint PK_MEETING_ROOM primary key (ID)
  using index 
  tablespace TS_INTRAWEB
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MEETING_ROOM
  add constraint FK_MEETING_ROOM foreign key (PARENTID)
  references MEETING_ROOM (ID) on delete cascade;

-- Create table
create table MEETING_TEMPLATE
(
  id                NUMBER(10) not null,
  building          VARCHAR2(50),
  starttime         DATE,
  endtime           DATE,
  content           VARCHAR2(400),
  leader            VARCHAR2(300),
  depart            VARCHAR2(400),
  remark            VARCHAR2(500),
  committime        DATE,
  commiterid        VARCHAR2(8),
  commitdepart      VARCHAR2(30),
  approverid        VARCHAR2(8),
  alloterid         VARCHAR2(8),
  presider          VARCHAR2(50),
  grade             VARCHAR2(1),
  scheduledperiod   VARCHAR2(2),
  daysbeforetrigger VARCHAR2(2),
  lasttriggerdate   DATE,
  isautotrigger     VARCHAR2(1),
  room              VARCHAR2(20),
  capacity          VARCHAR2(4),
  meetingroomid     NUMBER(10) not null,
  category          NUMBER,
  fdepart           VARCHAR2(400),
  contact           VARCHAR2(64),
  contactphone      VARCHAR2(16)
)
tablespace TS_INTRAWEB
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column MEETING_TEMPLATE.category
  is '1��ͨ�ã�2������1-2�Ż��飻3������3-4�Ż��飻4������5-6�Ż���';
