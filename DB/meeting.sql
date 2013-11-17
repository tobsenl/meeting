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
  is '会议室id';
comment on column MEETING_BOOKROOM.meetingid
  is '会议id';
comment on column MEETING_BOOKROOM.userid
  is '员工编号';
comment on column MEETING_BOOKROOM.org
  is '部门';
comment on column MEETING_BOOKROOM.starttime
  is '开始时间';
comment on column MEETING_BOOKROOM.endtime
  is '结束时间';
comment on column MEETING_BOOKROOM.status
  is '状态:1.正常；2.用户取消';
comment on column MEETING_BOOKROOM.creatdate
  is '创建时间';

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
  is '用于存放外单位名称和固定称谓';
-- Add comments to the columns 
comment on column MEETING_COMMON.type
  is '1：固定称谓；2：外来单位；';
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
  is '会议有关说明项设置';
-- Add comments to the columns 
comment on column MEETING_EXPLAIN.style
  is '1:复选框;2:文本框;3:下拉列表';
comment on column MEETING_EXPLAIN.display
  is '0:隐藏;1:显示;';
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
  is '会议预算经费';
-- Add comments to the columns 
comment on column MEETING_MONEY.org
  is '部门编码';
comment on column MEETING_MONEY.orgsort
  is '部门排序';
comment on column MEETING_MONEY.orgname
  is '部门名称';
comment on column MEETING_MONEY.year
  is '年';
comment on column MEETING_MONEY.money
  is '经费预算金额';
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
  is '会议开始时间';
comment on column MEETING_PLAN.endtime
  is '会议结束时间';
comment on column MEETING_PLAN.content
  is '会议内容';
comment on column MEETING_PLAN.leader
  is '会议领导';
comment on column MEETING_PLAN.depart
  is '参加会议部门';
comment on column MEETING_PLAN.remark
  is '会议说明';
comment on column MEETING_PLAN.creattime
  is '会议申请提交时间';
comment on column MEETING_PLAN.commiterid
  is '申请提交人id';
comment on column MEETING_PLAN.commitdepart
  is '会议申请部门';
comment on column MEETING_PLAN.type
  is '会议类型(1例会;2:内部会议;3外部会议;4:培训)';
comment on column MEETING_PLAN.presider
  is '会议主持人';
comment on column MEETING_PLAN.grade
  is '会议级别(1:综合会议;2:处内会议)';
comment on column MEETING_PLAN.category
  is '1：通用；2：生产1-2号机组；3：扩建3-4号机组；4：扩建5-6号机组';
comment on column MEETING_PLAN.fdepart
  is '参会上级/外单位及领导';
comment on column MEETING_PLAN.budget
  is '会议预算费用';
comment on column MEETING_PLAN.contact
  is '会议联系人';
comment on column MEETING_PLAN.contactphone
  is '联系人电话';
comment on column MEETING_PLAN.reserve_roomid
  is '预定会议室';
comment on column MEETING_PLAN.org
  is '组织处室';
comment on column MEETING_PLAN.meetingid
  is '正式会议id';

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
  is '1:会议室;2:培训中心教室';
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
  is '1：通用；2：生产1-2号机组；3：扩建3-4号机组；4：扩建5-6号机组';
