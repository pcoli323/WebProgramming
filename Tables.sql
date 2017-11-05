create table tbl_User (
	userNumber int NOT NULL auto_increment,
    email varchar(100) not null,
    pwd varchar(50) not null,
    userName varchar(50) not null,
    regDate timestamp not null default now(),
    updateDate timestamp,
    
    primary key(userNumber)
);

create table tbl_Follow (
	following int not null,
    followed int not null,
    
    primary key(following, followed),
    foreign key (following) references tbl_User (userNumber),
    foreign key (followed) references tbl_User (userNumber)
);

create table tbl_Course (
	courseNumber int not null auto_increment,
    courseName varchar(200) not null,
    userNumber int not null,
    regDate timestamp not null default now(),
    updateDate timestamp,
    isPosted boolean not null default 0,
    isGotten boolean not null default 0,
    readCount int default 0,
    story TEXT,
    
    primary key(courseNumber),
    foreign key (userNumber) references tbl_User (userNumber)
);

create table tbl_Reply (
	replyNumber int not null auto_increment,
    courseNumber int not null,
    reply text not null,
    regDate timestamp not null default now(),
    updateDate timestamp,
    report int not null default 0,
    replyer int not null,
    
    primary key(replyNumber),
    foreign key(replyer) references tbl_User(userNumber),
    foreign key(courseNumber) references tbl_Course(courseNumber)
);

create table tbl_CourseInfo (
	gotoNumber int not null auto_increment,
    courseNumber int not null,
    isRepresented boolean not null default 0,
    representedOrder int not null default 0,
    isNew boolean not null default 0,
    
    gotoAddr1 varchar(100),
    gotoAddr2 varchar(50),
    gotoAreaCode int,
    gotoContentID int,
    gotoContentTypeID int,
    gotoCreateTime long,
    gotoImageReal varchar(200),
    gotoImageThum varchar(200),
    gotoLocationX varchar(50),
    gotoLocationY varchar(50),
    gotoModifiedTime long,
    gotoReadCount int,
    gotoSigunguCode int,
    gotoTel varchar(50),
    gotoTitle varchar(50),
    gotoDate Date,
    gotoOrder int,
    
    primary key(gotoNumber),
    foreign key(courseNumber) references tbl_Course(courseNumber)
);

create table tbl_Like (
	courseNumber int not null,
    userNumber int not null,
    
    primary key(courseNumber, userNumber),
    foreign key (courseNumber) references tbl_Course (courseNumber),
    foreign key (userNumber) references tbl_User (userNumber)
);

create table tbl_Image (
	imageNumber int not null auto_increment,
    realfile mediumblob,
    thumfile mediumblob,
    userNumber int not null,
    type varchar(10) not null,
    
    primary key (imageNumber),
    foreign key (userNumber) references tbl_User (userNumber)
);

create table tbl_Area (
	areaCode int not null,
    areaName varchar(30) not null,
    isServiced boolean not null default 0,
    isServicedAll boolean not null default 0,
    
    primary key (areaCode)
);

create table tbl_Sigungu (
	areaCode int not null,
	sigunguCode int not null,
    sigunguName varchar(30) not null,
    isServiced boolean not null default 0,
    
    primary key (areaCode,sigunguCode),
    foreign key (areaCode) references tbl_Area (areaCode)
);

create table tbl_CourseInfoSimple (
	courseNumber int not null,
    areaCode int not null,
    sigunguCode int not null,
    startDate Date not null,
    endDate Date not null,
    
    primary key (courseNumber,areaCode,sigunguCode),
    foreign key (courseNumber) references tbl_Course (courseNumber)
);

create table tbl_Authorizing (
	email varchar(100) not null,
    authCode int not null
);

create table tbl_Color(
	colorNumber int not null,
	color varchar(10) not null,

	primary key (colorNumber)
);