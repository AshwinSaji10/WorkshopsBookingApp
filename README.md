# Workshops booking app
An integrated app for mobile devices where students can reserve their seats for a given workshop/training session and administrators can manage all details regarding the workshops, instructors, venues and sessions.
The app uses a comprehensive database management system where role based access is used to differentiate two different kinds of users.

## Technology
The technology used for building this application include
<ul>
  <li>Flutter, for the frontend design</li>
  <li>SQLite as the embedded backend database</li>
</ul>

## Database design
The database consists of six tables
<ol>
  <li>Workshops(workshop_id, workshop_name, workshop_subject)</li>
  <li>Instructors(instructor_id, instructor_name, age, gender)</li>
  <li>Locations(location_id, location_name, capacity)</li>
  <li>Sessions(session_id, w_id, i_id, l_id, date, start, end) [3 foreign keys]</li>
  <li>Users(u_id, u_name, password)</li>
  <li>Bookings(booking_id, u_id, s_id) [2 foreign keys]</li>
</ol>




## Showcase
<img src="https://github.com/user-attachments/assets/cd8be6ff-b606-4ee5-ba26-2cec3d3bfb18" width=200>
<img src = "https://github.com/user-attachments/assets/30abe153-8c85-44a0-b815-094c68b24124" width=200>

