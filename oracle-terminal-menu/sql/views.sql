-- 1. ADMIN VIEW - Full system overview
CREATE OR REPLACE VIEW Admin_View AS
SELECT 
    acc.Account_ID,
    acc.Full_Name,
    acc.Type,
    acc.Email,
    acc.Phone_Number,
    v.Venue_ID,
    v.Venue_Name,
    v.Address AS Venue_Address,
    v.Capacity,
    v.Price AS Venue_Price,
    s.Schedule_ID,
    s.Date_Time_Start,
    s.Date_Time_End,
    s.Status AS Schedule_Status,
    e.Event_ID,
    e.Event_Name,
    e.Ticket_Price,
    e.Total_Tickets,
    e.Status AS Event_Status,
    t.Ticket_ID,
    t.Purchase_Date_Time,
    t.Seat_Number,
    t.Status AS Ticket_Status
FROM Account acc
LEFT JOIN Venue v ON v.Admin_ID = acc.Account_ID
LEFT JOIN Schedule s ON s.Venue_ID = v.Venue_ID
LEFT JOIN Event e ON e.Schedule_ID = s.Schedule_ID
LEFT JOIN Ticket t ON t.Event_ID = e.Event_ID;

-- 2. ARTIST VIEW - For performers to see their events and sales
CREATE OR REPLACE VIEW Artist_View AS
SELECT 
    e.Event_ID,
    e.Event_Name,
    e.Ticket_Price,
    e.Total_Tickets,
    e.Status AS Event_Status,
    s.Date_Time_Start,
    s.Date_Time_End,
    v.Venue_Name,
    v.Address AS Venue_Address,
    v.Capacity,

    /* count ONLY valid tickets */
    SUM(CASE WHEN UPPER(t.Status) = 'VALID' THEN 1 ELSE 0 END) AS Tickets_Sold,

    /* revenue = sum of price for each valid ticket */
    SUM(CASE WHEN UPPER(t.Status) = 'VALID' THEN e.Ticket_Price ELSE 0 END) AS Total_Revenue
FROM Event e
JOIN Schedule s ON e.Schedule_ID = s.Schedule_ID
JOIN Venue v    ON s.Venue_ID = v.Venue_ID
LEFT JOIN Ticket t ON t.Event_ID = e.Event_ID
GROUP BY 
    e.Event_ID, e.Event_Name, e.Ticket_Price, e.Total_Tickets, e.Status,
    s.Date_Time_Start, s.Date_Time_End, v.Venue_Name, v.Address, v.Capacity;

-- 3. BUYER VIEW - For customers to see their tickets
CREATE OR REPLACE VIEW Buyer_View AS
SELECT 
    t.Ticket_ID,
    e.Event_Name,
    e.Ticket_Price,
    TO_CHAR(s.Date_Time_Start, 'MM/DD/YYYY HH24:MI') AS Event_Start,
    TO_CHAR(s.Date_Time_End, 'MM/DD/YYYY HH24:MI') AS Event_End,
    v.Venue_Name,
    v.Address AS Venue_Address,
    t.Seat_Number,
    t.Status AS Ticket_Status,
    TO_CHAR(t.Purchase_Date_Time, 'MM/DD/YYYY HH24:MI') AS Purchase_Time
FROM Ticket t
JOIN Event e ON t.Event_ID = e.Event_ID
JOIN Schedule s ON e.Schedule_ID = s.Schedule_ID
JOIN Venue v ON s.Venue_ID = v.Venue_ID;
