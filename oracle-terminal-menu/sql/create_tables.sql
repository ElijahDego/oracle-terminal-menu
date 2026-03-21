
-- ACCOUNT
CREATE TABLE Account (
  Account_ID     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  Type           VARCHAR2(10) CHECK (Type IN ('buyer','artist','admin')),
  Full_Name      VARCHAR2(100) NOT NULL,
  Email          VARCHAR2(100) NOT NULL UNIQUE,
  Phone_Number   VARCHAR2(20),
  Address        VARCHAR2(255),
  Payment_Token  VARCHAR2(255)
);

-- VENUE
CREATE TABLE Venue (
  Venue_ID    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  Admin_ID    NUMBER NOT NULL,
  Venue_Name  VARCHAR2(100) NOT NULL,
  Address     VARCHAR2(255),
  Capacity    NUMBER CHECK (Capacity >= 0),
  Price       NUMBER(10,2) CHECK (Price >= 0),
  CONSTRAINT fk_venue_admin FOREIGN KEY (Admin_ID)
    REFERENCES Account(Account_ID)
    ON DELETE CASCADE
);

-- SCHEDULE
CREATE TABLE Schedule (
  Schedule_ID     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  Venue_ID        NUMBER NOT NULL,
  Date_Time_Start TIMESTAMP NOT NULL,
  Date_Time_End   TIMESTAMP NOT NULL,
  Status          VARCHAR2(20) DEFAULT 'scheduled',
  CONSTRAINT fk_schedule_venue FOREIGN KEY (Venue_ID)
    REFERENCES Venue(Venue_ID)
    ON DELETE CASCADE,
  CONSTRAINT chk_schedule_time CHECK (Date_Time_End > Date_Time_Start)
);

-- EVENT  (Venue_ID removed; Schedule_ID made UNIQUE)
CREATE TABLE Event (
  Event_ID       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  Performer_ID   NUMBER NOT NULL,
  Schedule_ID    NUMBER NOT NULL,
  Event_Name     VARCHAR2(150) NOT NULL,
  Ticket_Price   NUMBER(10,2) CHECK (Ticket_Price >= 0),
  Total_Tickets  NUMBER CHECK (Total_Tickets >= 0),
  Status         VARCHAR2(20) DEFAULT 'scheduled',
  CONSTRAINT fk_event_performer FOREIGN KEY (Performer_ID)
    REFERENCES Account(Account_ID)
    ON DELETE CASCADE,
  CONSTRAINT fk_event_schedule FOREIGN KEY (Schedule_ID)
    REFERENCES Schedule(Schedule_ID)
    ON DELETE CASCADE,
  CONSTRAINT uq_event_schedule UNIQUE (Schedule_ID)
);

-- TICKET
CREATE TABLE Ticket (
  Ticket_ID           NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  Event_ID            NUMBER NOT NULL,
  User_ID             NUMBER NOT NULL,
  Purchase_Date_Time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  Seat_Number         VARCHAR2(20),
  Status              VARCHAR2(20) DEFAULT 'valid',
  CONSTRAINT fk_ticket_event FOREIGN KEY (Event_ID)
    REFERENCES Event(Event_ID)
    ON DELETE CASCADE,
  CONSTRAINT fk_ticket_user FOREIGN KEY (User_ID)
    REFERENCES Account(Account_ID)
    ON DELETE CASCADE,
  CONSTRAINT uq_ticket_event_seat UNIQUE (Event_ID, Seat_Number)
);
