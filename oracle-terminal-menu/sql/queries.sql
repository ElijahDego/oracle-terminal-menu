-- Advanced Queries (based on the Ticket Booking System)

-- QUERY 1: List users who have NOT bought any ticket to a DJ Solace event
PROMPT === Query 1: Buyers who did NOT purchase tickets for DJ Solace ===
SELECT a.Account_ID, a.Full_Name
FROM Account a
WHERE a.Type = 'buyer'
  AND a.Account_ID NOT IN (
    SELECT t.User_ID
    FROM Ticket t
    JOIN Event e ON t.Event_ID = e.Event_ID
    WHERE e.Event_Name LIKE '%DJ Solace%'
  )
ORDER BY a.Full_Name;

-- QUERY 2: List artists who have sold more than 500 tickets in total
PROMPT === Query 2: Artists with more than 500 tickets sold ===
SELECT a.Full_Name AS Artist_Name, COUNT(t.Ticket_ID) AS Tickets_Sold
FROM Account a
JOIN Event e ON a.Account_ID = e.Performer_ID
JOIN Ticket t ON e.Event_ID = t.Event_ID
WHERE a.Type = 'artist'
  AND UPPER(t.Status) = 'PAID'
GROUP BY a.Full_Name
HAVING COUNT(t.Ticket_ID) > 500
ORDER BY Tickets_Sold DESC;

-- QUERY 3: For each venue, show total number of events and average ticket price
PROMPT === Query 3: Event count and average ticket price per venue ===
SELECT v.Venue_Name, COUNT(e.Event_ID) AS Total_Events,
       ROUND(AVG(e.Ticket_Price), 2) AS Avg_Ticket_Price
FROM Venue v
LEFT JOIN Schedule s ON v.Venue_ID = s.Venue_ID
LEFT JOIN Event e ON s.Schedule_ID = e.Schedule_ID
GROUP BY v.Venue_Name
ORDER BY Avg_Ticket_Price DESC;

-- QUERY 4: List all artists who have scheduled events in October 2025
PROMPT === Query 4: Artists scheduled for October 2025 events ===
SELECT DISTINCT a.Full_Name AS Artist, e.Event_Name, s.Date_Time_Start
FROM Account a
JOIN Event e ON a.Account_ID = e.Performer_ID
JOIN Schedule s ON e.Schedule_ID = s.Schedule_ID
WHERE a.Type = 'artist'
  AND s.Date_Time_Start BETWEEN TIMESTAMP '2025-10-01 00:00:00' AND TIMESTAMP '2025-10-31 23:59:59'
ORDER BY s.Date_Time_Start;

-- QUERY 5: List all venues that hosted more than 1 unique artist
PROMPT === Query 5: Venues that hosted more than one unique artist ===
SELECT v.Venue_Name, COUNT(DISTINCT e.Performer_ID) AS Unique_Artists
FROM Venue v
JOIN Schedule s ON v.Venue_ID = s.Venue_ID
JOIN Event e ON s.Schedule_ID = e.Schedule_ID
GROUP BY v.Venue_Name
HAVING COUNT(DISTINCT e.Performer_ID) > 1
ORDER BY Unique_Artists DESC;
