INSERT INTO Account (Type, Full_Name, Email, Phone_Number, Address, Payment_Token)
VALUES ('admin', 'Jane Smith', 'jane.smith@email.com', '123-456-7890', '123 Main St', 'tok_abc123');

INSERT INTO Account (Type, Full_Name, Email)
VALUES ('buyer', 'John Mith', 'JohnMith@email.com');

INSERT INTO Account (Type, Full_Name, Email)
VALUES ('artist', 'The Weekend', 'weekend@email.com');

INSERT INTO Venue (Admin_ID, Venue_Name, Address, Capacity, Price)
VALUES (1, 'Phoenix Concert Hall', '410 Sherbourne St', 1200, 5000);

INSERT INTO Account (Type, Full_Name, Email, Phone_Number, Address, Payment_Token)
VALUES ('admin', 'Marco Alvarez', 'marco.alvarez@example.com', '416-555-0101', '12 Bay St, Toronto', 'tok_mx01');

INSERT INTO Account (Type, Full_Name, Email, Phone_Number, Address)
VALUES ('admin', 'Priya Kohli', 'priya.kohli@example.com', '647-555-0199', '77 King St W, Toronto');

INSERT INTO Account (Type, Full_Name, Email)
VALUES ('artist', 'Rhea Park', 'rhea.park@example.com');

INSERT INTO Account (Type, Full_Name, Email)
VALUES ('artist', 'DJ Solace', 'solace.dj@example.com');

INSERT INTO Account (Type, Full_Name, Email)
VALUES ('buyer', 'Jonathan Esemogie', 'jonathan.esemogie@example.com');

INSERT INTO Account (Type, Full_Name, Email)
VALUES ('buyer', 'Ryan Pham', 'ryan.pham@example.com');

INSERT INTO Account (Type, Full_Name, Email, Phone_Number, Address, Payment_Token)
VALUES ('admin', 'Marco Alvarez', 'marco.alvarez@example.com', '416-555-0101', '12 Bay St, Toronto', 'tok_mx01');

INSERT INTO Account (Type, Full_Name, Email, Phone_Number, Address)
VALUES ('admin', 'Priya Kohli', 'priya.kohli@example.com', '647-555-0199', '77 King St W, Toronto');

INSERT INTO Account (Type, Full_Name, Email)
VALUES ('artist', 'Rhea Park', 'rhea.park@example.com');

INSERT INTO Account (Type, Full_Name, Email)
VALUES ('artist', 'DJ Solace', 'solace.dj@example.com');

INSERT INTO Account (Type, Full_Name, Email)
VALUES ('buyer', 'Jonathan Esemogie', 'jonathan.esemogie@example.com');

INSERT INTO Account (Type, Full_Name, Email)
VALUES ('buyer', 'Ryan Pham', 'ryan.pham@example.com');

INSERT INTO Schedule (Venue_ID, Date_Time_Start, Date_Time_End, Status)
VALUES (
  (SELECT Venue_ID FROM Venue WHERE Venue_Name = 'Harbourfront Theatre'),
  TIMESTAMP '2025-10-18 19:30:00', TIMESTAMP '2025-10-18 22:30:00',
  'scheduled'
);

INSERT INTO Schedule (Venue_ID, Date_Time_Start, Date_Time_End, Status)
VALUES (
  (SELECT Venue_ID FROM Venue WHERE Venue_Name = 'Harbourfront Theatre'),
  TIMESTAMP '2025-10-25 20:00:00', TIMESTAMP '2025-10-25 23:00:00',
  'scheduled'
);

INSERT INTO Schedule (Venue_ID, Date_Time_Start, Date_Time_End, Status)
VALUES (
  (SELECT Venue_ID FROM Venue WHERE Venue_Name = 'Echo Dome'),
  TIMESTAMP '2025-11-01 21:00:00', TIMESTAMP '2025-11-02 01:00:00',
  'scheduled'
);

INSERT INTO Event (Performer_ID, Schedule_ID, Event_Name, Ticket_Price, Total_Tickets, Status)
VALUES (
  (SELECT Account_ID FROM Account WHERE Full_Name = 'Rhea Park'),
  (SELECT Schedule_ID FROM Schedule s
     JOIN Venue v ON v.Venue_ID = s.Venue_ID
    WHERE v.Venue_Name = 'Harbourfront Theatre'
      AND s.Date_Time_Start = TIMESTAMP '2025-10-18 19:30:00'),
  'Rhea Park — Acoustic Night',
  45.00, 850, 'scheduled'
);

INSERT INTO Event (Performer_ID, Schedule_ID, Event_Name, Ticket_Price, Total_Tickets, Status)
VALUES (
  (SELECT Account_ID FROM Account WHERE Full_Name = 'DJ Solace'),
  (SELECT Schedule_ID FROM Schedule s
     JOIN Venue v ON v.Venue_ID = s.Venue_ID
    WHERE v.Venue_Name = 'Echo Dome'
      AND s.Date_Time_Start = TIMESTAMP '2025-11-01 21:00:00'),
  'DJ Solace — Midnight Rave',
  75.00, 2500, 'scheduled'
);

INSERT INTO Ticket (Event_ID, User_ID, Seat_Number, Status)
VALUES (
  (SELECT Event_ID FROM Event WHERE Event_Name = 'Rhea Park — Acoustic Night'),
  (SELECT Account_ID FROM Account WHERE Full_Name = 'Ryan Pham'),
  'B12',
  'paid'
);

INSERT INTO Ticket (Event_ID, User_ID, Seat_Number, Status)
VALUES (
  (SELECT Event_ID FROM Event WHERE Event_Name = 'Rhea Park — Acoustic Night'),
  (SELECT Account_ID FROM Account WHERE Full_Name = 'Jonathan Esemogie'),
  'B13',
  'reserved'
);

INSERT INTO Ticket (Event_ID, User_ID, Seat_Number, Status)
VALUES (
  (SELECT Event_ID FROM Event WHERE Event_Name = 'DJ Solace — Midnight Rave'),
  (SELECT Account_ID FROM Account WHERE Full_Name = 'Ryan Pham'),
  NULL,   -- general admission
  'paid'
);


COMMIT;
