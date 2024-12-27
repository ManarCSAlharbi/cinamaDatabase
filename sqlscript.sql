REM   Script: Session
REM   cinama

CREATE TABLE Branches ( 
  branch_id INT NOT NULL, 
  location VARCHAR (255) NOT NULL, 
  PRIMARY KEY (branch_id) 
);

CREATE TABLE Theater ( 
  theater_id INT NOT NULL, 
  type VARCHAR (255), 
  branch_id INT NOT NULL, 
  capacity INT, 
  status VARCHAR (255) NOT NULL, 
  PRIMARY KEY (theater_id), 
  FOREIGN KEY (branch_id) REFERENCES Branches(branch_id) ON DELETE CASCADE, 
  CHECK (status IN ('open', 'closed', 'under maintenance', 'reserved')), 
  CONSTRAINT CHK_theater_type CHECK (type IN ('Multiplexes', 'IMAX', 'VIP', '3D', 'Standard', 'Dolby Atmos')) 
);

CREATE TABLE Employee ( 
  employee_id INT NOT NULL, 
  fname VARCHAR (50) NOT NULL, 
  lname VARCHAR (50) NOT NULL, 
  street VARCHAR (255), 
  city VARCHAR (255), 
  state VARCHAR (255), 
  branch_id INT, 
  manager_id INT, 
  birth_date DATE NOT NULL, 
  gender CHAR (1) NOT NULL, 
  email VARCHAR (255), 
  phone VARCHAR (15), 
  start_date DATE NOT NULL, 
  PRIMARY KEY (employee_id), 
  FOREIGN KEY (manager_id) REFERENCES Employee(employee_id) ON DELETE CASCADE, 
  FOREIGN KEY (branch_id) REFERENCES Branches(branch_id) ON DELETE CASCADE, 
  CHECK (gender IN ('F','M')) 
);

CREATE TABLE Movie ( 
    movie_id INT NOT NULL, 
    title VARCHAR (50) NOT NULL, 
    duration INT, 
    rating VARCHAR (5), 
    film_director VARCHAR (50), 
    release_date DATE, 
    PRIMARY KEY (movie_id), 
    CHECK (rating IN ('G', 'PG', 'PG-13', 'R')) 
);

CREATE TABLE Showtime ( 
    showtime_ID INT NOT NULL, 
    movie_id INT NOT NULL, 
    showDate DATE, 
    theater_id INT, 
    Start_time TIMESTAMP, 
    End_time TIMESTAMP, 
    PRIMARY KEY (showtime_ID), 
    FOREIGN KEY (movie_id) REFERENCES Movie (movie_id) ON DELETE CASCADE, 
    FOREIGN KEY (theater_id) REFERENCES Theater (theater_id) ON DELETE CASCADE  
);

CREATE TABLE Customer ( 
    customer_ID INT NOT NULL, 
    Fname VARCHAR (50) NOT NULL, 
    Lname VARCHAR (50) NOT NULL, 
    Email VARCHAR (255), 
    Phone VARCHAR (15), 
    Birth_date DATE NOT NULL, 
    Gender CHAR (1) NOT NULL, 
    Loyalty_points INT DEFAULT 0, 
    PRIMARY KEY (customer_ID), 
    CHECK (Gender in ('F','M')) 
);

create table Reservation ( 
  reservation_ID INT NOT NULL, 
  showtime_ID INT NOT NULL, 
  customer_ID INT NOT NULL, 
  res_date Date, 
  Time Timestamp,   
  primary key (reservation_ID), 
  FOREIGN KEY (showtime_ID) REFERENCES Showtime (showtime_ID) ON DELETE CASCADE, 
  FOREIGN KEY (customer_ID) REFERENCES Customer (customer_ID) ON DELETE CASCADE 
  );

 create table Seats ( 
    seat_ID INT NOT NULL, 
    seat_type varchar (225), 
    theater_ID INT NOT NULL, 
    price number, 
    primary key (seat_ID), 
    FOREIGN KEY (theater_ID) REFERENCES Theater (theater_ID) ON DELETE CASCADE, 
    CHECK (seat_type IN ('standard', 'premium', 'wheelchair accessible')) 
    );

 create table Seats ( 
    seat_ID INT NOT NULL, 
    seat_type varchar (225), 
    theater_ID INT NOT NULL, 
    price number, 
    primary key (seat_ID), 
    FOREIGN KEY (theater_ID) REFERENCES Theater (theater_ID) ON DELETE CASCADE, 
    CHECK (seat_type IN ('standard', 'premium', 'wheelchair accessible')) 
    );

create table Payment ( 
    payment_ID INT NOT NULL, 
    payment_date DATE, 
    payment_status varchar (225) NOT NULL, 
    customer_ID INT NOT NULL, 
    reservation_ID INT NOT NULL, 
    Total_amount number NOT NULL, 
    Discounts number DEFAULT 0, 
    primary key (payment_ID), 
    FOREIGN KEY (customer_ID) REFERENCES Customer (customer_ID) ON DELETE CASCADE, 
    FOREIGN KEY (reservation_ID) REFERENCES Reservation (reservation_ID) ON DELETE CASCADE, 
    CHECK (payment_status IN ('successful', 'pending', 'declined', 'canceled')) 
);

CREATE TABLE Genre ( 
  genre_id INT NOT NULL, 
  Genre_name VARCHAR (255) NOT NULL, 
  PRIMARY KEY (genre_id) 
);

CREATE TABLE Has_genre (  
  movie_id INT NOT NULL,  
  genre_id INT NOT NULL, 
  PRIMARY KEY (movie_id, genre_id), 
  FOREIGN KEY (movie_id) REFERENCES Movie (movie_id) ON DELETE CASCADE, 
  FOREIGN KEY (genre_id) REFERENCES Genre (genre_id) ON DELETE CASCADE  
);

CREATE TABLE Payment_method (  
  method_id INT PRIMARY KEY, 
  Customer_id INT NOT NULL, 
  Card_number VARCHAR (50) NOT NULL, 
  Card_exp_date DATE NOT NULL, 
  CVV_card number (3) NOT NULL, 
  FOREIGN KEY (customer_id) REFERENCES Customer (customer_id) ON DELETE CASCADE 
);

CREATE TABLE Payment_method (  
  method_id INT PRIMARY KEY, 
  Customer_id INT NOT NULL, 
  Card_number VARCHAR (50) NOT NULL, 
  Card_exp_date DATE NOT NULL, 
  CVV_card number (3) NOT NULL, 
  FOREIGN KEY (customer_id) REFERENCES Customer (customer_id) ON DELETE CASCADE 
);

CREATE TABLE Has_reservation (  
  reservation_id INT NOT NULL,  
  seat_id INT NOT NULL, 
  PRIMARY KEY (reservation_id, seat_id), 
  FOREIGN KEY (reservation_id) REFERENCES Reservation (reservation_id) ON   DELETE CASCADE, 
  FOREIGN KEY (seat_id) REFERENCES Seats (seat_id) ON DELETE CASCADE  
);

INSERT INTO Branches (branch_id, location) 
VALUES 
    (1, 'Abha, Saudi Arabia'), 
    (2, 'Riyadh, Saudi Arabia'), 
    (3, 'Jeddah, Saudi Arabia'), 
    (4, 'Dammam, Saudi Arabia');

INSERT INTO Branches (branch_id, location) VALUES (1, 'Abha, Saudi Arabia');

INSERT INTO Branches (branch_id, location) VALUES (2, 'Riyadh, Saudi Arabia');

INSERT INTO Branches (branch_id, location) VALUES (3, 'Jeddah, Saudi Arabia');

INSERT INTO Branches (branch_id, location) VALUES (4, 'Dammam, Saudi Arabia');

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(1, 'John', 'Smith', 'King Fahd Road', 'Abha', 'Saudi Arabia', 1, NULL, TO_DATE('1980-01-15', 'YYYY-MM-DD'), 'M', 'john.smith@email.com', '123-456-7890', TO_DATE('2023-10-01', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(2, 'Emma', 'Johnson', 'King Abdulaziz Road', 'Abha', 'Saudi Arabia', 1, 1, TO_DATE('1985-05-20', 'YYYY-MM-DD'), 'F', 'emma.johnson@email.com', '987-654-3210', TO_DATE('2023-10-02', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(3, 'Ahmed', 'Ali', 'Madinah Road', 'Abha', 'Saudi Arabia', 1, 1, TO_DATE('1990-09-10', 'YYYY-MM-DD'), 'M', 'ahmed.ali@email.com', '123-456-7890', TO_DATE('2023-10-03', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(4, 'Lina', 'Gomez', 'Madinah Road', 'Abha', 'Saudi Arabia', 1, 1, TO_DATE('1988-03-25', 'YYYY-MM-DD'), 'F', 'lina.gomez@email.com', '987-654-3210', TO_DATE('2023-10-04', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(5, 'Mansour', 'Ibrahim', 'Prince Sultan Street', 'Abha', 'Saudi Arabia', 1, 1, TO_DATE('1982-07-12', 'YYYY-MM-DD'), 'M', 'mansour.ibrahim@email.com', '123-456-7890', TO_DATE('2023-10-05', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(6, 'Aisha', 'Al-Zahrani', '1415 Elm Street', 'Riyadh', 'Saudi Arabia', 2, NULL, TO_DATE('1975-04-18', 'YYYY-MM-DD'), 'F', 'aisha.khalid@email.com', '123-456-7890', TO_DATE('2023-10-06', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(7, 'Omar', 'Al-Shehri', '1617 Oak Street', 'Riyadh', 'Saudi Arabia', 2, 6, TO_DATE('1980-10-22', 'YYYY-MM-DD'), 'M', 'omar.nasser@email.com', '987-654-3210', TO_DATE('2023-10-07', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(8, 'Fatima', 'Al-Dosari', '1819 Pine Street', 'Riyadh', 'Saudi Arabia', 2, 6, TO_DATE('1995-12-30', 'YYYY-MM-DD'), 'F', 'fatima.abdullah@email.com', '123-456-7890', TO_DATE('2023-10-08', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(9, 'Khaled', 'Al-Zahrani', '2021 Maple Street', 'Riyadh', 'Saudi Arabia', 2, 6, TO_DATE('1988-06-15', 'YYYY-MM-DD'), 'M', 'khaled.nada@email.com', '987-654-3210', TO_DATE('2023-10-09', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(10, 'Sara', 'Hassan', '2223 Elm Street', 'Riyadh', 'Saudi Arabia', 2, 6, TO_DATE('1992-02-28', 'YYYY-MM-DD'), 'F', 'sara.hassan@email.com', '123-456-7890', TO_DATE('2023-10-10', 'YYYY-MM-DD'));

select * from Branche;

select * from Branches;

select * from employee;

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(11, 'Mona', 'Al-Harbi', '2325 Oak Street', 'Jeddah', 'Saudi Arabia', 3, NULL, TO_DATE('1984-08-14', 'YYYY-MM-DD'), 'F', 'mona.ahmed@email.com', '123-456-7890', TO_DATE('2023-10-11', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(12, 'Abdullah', 'Al-Mansour', '2527 Pine Street', 'Jeddah', 'Saudi Arabia', 3, 11, TO_DATE('1978-11-03', 'YYYY-MM-DD'), 'M', 'abdul.rahman@email.com', '987-654-3210', TO_DATE('2023-10-12', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(13, 'Layla', 'Al-Otaibi', '2729 Maple Street', 'Jeddah', 'Saudi Arabia', 3, 11, TO_DATE('1990-01-25', 'YYYY-MM-DD'), 'F', 'layla.mohammed@email.com', '123-456-7890', TO_DATE('2023-10-13', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(14, 'Saad', 'Al-Faisal', '2931 Elm Street', 'Jeddah', 'Saudi Arabia', 3, 11, TO_DATE('1985-06-07', 'YYYY-MM-DD'), 'M', 'saad.fatima@email.com', '987-654-3210', TO_DATE('2023-10-14', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(15, 'Amina', 'Al-Otaibi', '3133 Oak Street', 'Jeddah', 'Saudi Arabia', 3, 11, TO_DATE('1992-03-18', 'YYYY-MM-DD'), 'F', 'amina.hassan@email.com', '123-456-7890', TO_DATE('2023-10-15', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(16, 'Amina', 'Al-Jaber', 'King Fahd Street', 'Dammam', 'Saudi Arabia', 4, NULL, TO_DATE('1983-12-06', 'YYYY-MM-DD'), 'F', 'amina.saeed@email.com', '123-456-7890', TO_DATE('2023-10-16', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(17, 'Khalid', 'Al-Mutairi', 'Prince Saud Street', 'Dammam', 'Saudi Arabia', 4, 16, TO_DATE('1975-08-23', 'YYYY-MM-DD'), 'M', 'khalid.mahmoud@email.com', '987-654-3210', TO_DATE('2023-10-17', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(18, 'Sara', 'Al-Zahrani', 'King Abdulaziz Road', 'Dammam', 'Saudi Arabia', 4, 16, TO_DATE('1992-02-14', 'YYYY-MM-DD'), 'F', 'sara.yassin@email.com', '123-456-7890', TO_DATE('2023-10-18', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(19, 'Mansour', 'Al-Shehri', 'King Abdullah Street', 'Dammam', 'Saudi Arabia', 4, 16, TO_DATE('1988-06-30', 'YYYY-MM-DD'), 'M', 'mansour.hussein@email.com', '987-654-3210', TO_DATE('2023-10-19', 'YYYY-MM-DD'));

INSERT INTO Employee (employee_id, fname, lname, street, city, state, branch_id, manager_id, birth_date, gender, email, phone, start_date) 
VALUES 
(20, 'Leila', 'Ali', 'Prince Mohammed Bin Fahd Street', 'Dammam', 'Saudi Arabia', 4, 16, TO_DATE('1980-10-02', 'YYYY-MM-DD'), 'F', 'leila.ali@email.com', '123-456-7890', TO_DATE('2023-10-20', 'YYYY-MM-DD'));

select * from employee 
;

select * from theater 
;

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (1, 'Multiplexes', 1, 400, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (2, 'VIP', 1, 150, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (3, '3D', 2, 180, 'closed');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (4, 'Standard', 2, 300, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (5, 'Multiplexes', 3, 350, 'under maintenance');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (6, 'Dolby Atmos', 4, 250, 'reserved');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (7, 'VIP', 4, 120, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (8, 'IMAX', 1, 220, 'closed');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (9, '3D', 2, 280, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (10, 'Standard', 3, 320, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (11, 'Dolby Atmos', 4, 180, 'under maintenance');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (12, 'VIP', 1, 130, 'reserved');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (13, 'IMAX', 2, 240, 'closed');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (14, 'Multiplexes', 1, 200, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (15, 'Standard', 2, 180, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (16, 'Dolby Atmos', 3, 250, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (17, 'VIP', 4, 120, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (18, 'IMAX', 1, 200, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (19, '3D', 2, 150, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (20, 'Multiplexes', 3, 220, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (21, 'Standard', 4, 300, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (22, 'Dolby Atmos', 1, 180, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (23, 'VIP', 2, 130, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (14, 'Multiplexes', 1, 200, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (15, 'Standard', 2, 180, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (16, 'Dolby Atmos', 3, 250, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (17, 'VIP', 4, 120, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (18, 'IMAX', 1, 200, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (19, '3D', 2, 150, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (20, 'Multiplexes', 3, 220, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (21, 'Standard', 4, 300, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (22, 'Dolby Atmos', 1, 180, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (23, 'VIP', 2, 130, 'open');

SELECT * FROM THEATER 
 
;

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (24, 'IMAX', 3, 180, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (25, '3D', 4, 200, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (26, 'Multiplexes', 1, 250, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (27, 'Standard', 2, 150, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (28, 'Dolby Atmos', 3, 300, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (29, 'VIP', 4, 120, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (30, 'IMAX', 1, 180, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (31, '3D', 2, 200, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (32, 'Multiplexes', 3, 250, 'open');

INSERT INTO Theater (theater_id, type, branch_id, capacity, status) 
VALUES (33, 'Standard', 4, 150, 'open');

SELECT * FROM EMPLOYEE 
 
;

SELECT * FROM moVIE 
 
;

SELECT * FROM MOVIE 
 
;

INSERT INTO Genre (genre_id, Genre_name) VALUES (1, 'adventure');

INSERT INTO Genre (genre_id, Genre_name) VALUES (2, 'animation');

INSERT INTO Genre (genre_id, Genre_name) VALUES (3, 'comedy');

INSERT INTO Genre (genre_id, Genre_name) VALUES (4, 'drama');

INSERT INTO Genre (genre_id, Genre_name) VALUES (5, 'family');

INSERT INTO Genre (genre_id, Genre_name) VALUES (6, 'home movie');

INSERT INTO Genre (genre_id, Genre_name) VALUES (7, 'horror');

INSERT INTO Genre (genre_id, Genre_name) VALUES (8, 'music videos');

INSERT INTO Genre (genre_id, Genre_name) VALUES (9, 'science fiction');

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES 
    (1, 'Inception', 148, 'PG-13', 'Christopher Nolan', TO_DATE('2010-07-08', 'YYYY-MM-DD')), 
    (2, 'The Godfather', 175, 'R', 'Francis Ford Coppola', TO_DATE('1972-03-24', 'YYYY-MM-DD')), 
    (3, 'The Matrix', 136, 'R', 'Lana and Lilly Wachowski', TO_DATE('1999-03-24', 'YYYY-MM-DD')), 
    (4, 'Forrest Gump', 142, 'PG-13', 'Robert Zemeckis', TO_DATE('1994-07-06', 'YYYY-MM-DD')), 
    (5, 'The Shawshank Redemption', 142, 'R', 'Frank Darabont', TO_DATE('1994-09-23', 'YYYY-MM-DD')), 
    (6, 'The Dark Knight', 152, 'PG-13', 'Christopher Nolan', TO_DATE('2008-07-14', 'YYYY-MM-DD')), 
    (7, 'Titanic', 195, 'PG-13', 'James Cameron', TO_DATE('1997-12-19', 'YYYY-MM-DD')), 
    (8, 'Jurassic Park', 127, 'PG-13', 'Steven Spielberg', TO_DATE('1993-06-09', 'YYYY-MM-DD')), 
    (9, 'Avatar', 162, 'PG-13', 'James Cameron', TO_DATE('2009-12-18', 'YYYY-MM-DD')), 
    (10, 'The Sound of Music', 174, 'G', 'Robert Wise', TO_DATE('1965-03-02', 'YYYY-MM-DD'));

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (1, 'Inception', 148, 'PG-13', 'Christopher Nolan', TO_DATE('2010-07-08', 'YYYY-MM-DD'));

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (2, 'The Godfather', 175, 'R', 'Francis Ford Coppola', TO_DATE('1972-03-24', 'YYYY-MM-DD'));

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (3, 'The Matrix', 136, 'R', 'Lana and Lilly Wachowski', TO_DATE('1999-03-24', 'YYYY-MM-DD'));

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (4, 'Forrest Gump', 142, 'PG-13', 'Robert Zemeckis', TO_DATE('1994-07-06', 'YYYY-MM-DD'));

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (5, 'The Shawshank Redemption', 142, 'R', 'Frank Darabont', TO_DATE('1994-09-23', 'YYYY-MM-DD'));

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (6, 'The Dark Knight', 152, 'PG-13', 'Christopher Nolan', TO_DATE('2008-07-14', 'YYYY-MM-DD'));

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (7, 'Titanic', 195, 'PG-13', 'James Cameron', TO_DATE('1997-12-19', 'YYYY-MM-DD'));

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (8, 'Jurassic Park', 127, 'PG-13', 'Steven Spielberg', TO_DATE('1993-06-09', 'YYYY-MM-DD'));

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (9, 'Avatar', 162, 'PG-13', 'James Cameron', TO_DATE('2009-12-18', 'YYYY-MM-DD'));

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (10, 'The Sound of Music', 174, 'G', 'Robert Wise', TO_DATE('1965-03-02', 'YYYY-MM-DD'));

INSERT INTO Has_genre (movie_id, genre_id) VALUES (1, 9);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (2, 4);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (3, 9);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (4, 4);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (5, 4);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (6, 1);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (7, 6);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (8, 1);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (9, 9);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (10, 5);

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (11, 'Interstellar', 169, 'PG-13', 'Christopher Nolan', TO_DATE('2014-11-05', 'YYYY-MM-DD'));

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (12, 'The Grand Budapest Hotel', 99, 'R', 'Wes Anderson', TO_DATE('2014-02-06', 'YYYY-MM-DD'));

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (13, 'La La Land', 128, 'PG-13', 'Damien Chazelle', TO_DATE('2016-12-09', 'YYYY-MM-DD'));

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (14, 'The Lord of the Rings: The Fellowship of the Ring', 178, 'PG-13', 'Peter Jackson', TO_DATE('2001-12-19', 'YYYY-MM-DD'));

INSERT INTO Movie (movie_id, title, duration, rating, film_director, release_date) 
VALUES (15, 'Gladiator', 155, 'R', 'Ridley Scott', TO_DATE('2000-05-01', 'YYYY-MM-DD'));

INSERT INTO Has_genre (movie_id, genre_id) VALUES (11, 9);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (12, 3);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (13, 8);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (14, 2);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (15, 1);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (11, 9);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (11, 1);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (12, 3);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (12, 4);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (13, 8);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (13, 5);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (14, 2);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (14, 4);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (15, 1);

INSERT INTO Has_genre (movie_id, genre_id) VALUES (15, 4);

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (1, 11, TO_DATE('2023-11-25', 'YYYY-MM-DD'), 1, TO_TIMESTAMP('2023-11-25 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-11-25 21:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (2, 12, TO_DATE('2023-11-26', 'YYYY-MM-DD'), 2, TO_TIMESTAMP('2023-11-26 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-11-26 21:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (3, 13, TO_DATE('2023-11-27', 'YYYY-MM-DD'), 3, TO_TIMESTAMP('2023-11-27 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-11-27 22:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (4, 14, TO_DATE('2023-11-28', 'YYYY-MM-DD'), 4, TO_TIMESTAMP('2023-11-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-11-28 20:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (5, 15, TO_DATE('2023-11-29', 'YYYY-MM-DD'), 1, TO_TIMESTAMP('2023-11-29 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-11-29 20:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (6, 16, TO_DATE('2023-11-30', 'YYYY-MM-DD'), 2, TO_TIMESTAMP('2023-11-30 18:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-11-30 21:15:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (7, 17, TO_DATE('2023-12-01', 'YYYY-MM-DD'), 3, TO_TIMESTAMP('2023-12-01 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-01 22:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (8, 18, TO_DATE('2023-12-02', 'YYYY-MM-DD'), 4, TO_TIMESTAMP('2023-12-02 20:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-02 22:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (9, 19, TO_DATE('2023-12-03', 'YYYY-MM-DD'), 1, TO_TIMESTAMP('2023-12-03 17:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-03 19:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (10, 20, TO_DATE('2023-12-04', 'YYYY-MM-DD'), 2, TO_TIMESTAMP('2023-12-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-04 20:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (6, 1, TO_DATE('2023-11-30', 'YYYY-MM-DD'), 2, TO_TIMESTAMP('2023-11-30 18:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-11-30 21:15:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (7, 2, TO_DATE('2023-12-01', 'YYYY-MM-DD'), 3, TO_TIMESTAMP('2023-12-01 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-01 22:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (8, 3, TO_DATE('2023-12-02', 'YYYY-MM-DD'), 4, TO_TIMESTAMP('2023-12-02 20:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-02 22:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (9, 4, TO_DATE('2023-12-03', 'YYYY-MM-DD'), 1, TO_TIMESTAMP('2023-12-03 17:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-03 19:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (10, 5, TO_DATE('2023-12-04', 'YYYY-MM-DD'), 2, TO_TIMESTAMP('2023-12-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-04 20:30:00', 'YYYY-MM-DD HH24:MI:SS'));

select * from showtime;

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (6, 6, TO_DATE('2023-11-30', 'YYYY-MM-DD'), 2, TO_TIMESTAMP('2023-11-30 18:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-11-30 21:15:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (7, 7, TO_DATE('2023-12-01', 'YYYY-MM-DD'), 3, TO_TIMESTAMP('2023-12-01 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-01 22:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (8, 8, TO_DATE('2023-12-02', 'YYYY-MM-DD'), 4, TO_TIMESTAMP('2023-12-02 20:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-02 22:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (9, 9, TO_DATE('2023-12-03', 'YYYY-MM-DD'), 1, TO_TIMESTAMP('2023-12-03 17:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-03 19:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (10, 10, TO_DATE('2023-12-04', 'YYYY-MM-DD'), 2, TO_TIMESTAMP('2023-12-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-04 20:30:00', 'YYYY-MM-DD HH24:MI:SS'));

select * from showtime;

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (11, 1, TO_DATE('2023-12-05', 'YYYY-MM-DD'), 3, TO_TIMESTAMP('2023-12-05 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-05 21:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (12, 2, TO_DATE('2023-12-06', 'YYYY-MM-DD'), 4, TO_TIMESTAMP('2023-12-06 18:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-06 21:15:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (13, 3, TO_DATE('2023-12-07', 'YYYY-MM-DD'), 1, TO_TIMESTAMP('2023-12-07 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-07 23:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (14, 4, TO_DATE('2023-12-08', 'YYYY-MM-DD'), 2, TO_TIMESTAMP('2023-12-08 17:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-08 19:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (15, 5, TO_DATE('2023-12-09', 'YYYY-MM-DD'), 3, TO_TIMESTAMP('2023-12-09 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-09 20:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (16, 6, TO_DATE('2023-12-10', 'YYYY-MM-DD'), 4, TO_TIMESTAMP('2023-12-10 19:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-10 22:15:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (17, 6, TO_DATE('2023-12-11', 'YYYY-MM-DD'), 1, TO_TIMESTAMP('2023-12-11 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-11 23:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (18, 7, TO_DATE('2023-12-12', 'YYYY-MM-DD'), 2, TO_TIMESTAMP('2023-12-12 18:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-12 20:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (19, 8, TO_DATE('2023-12-13', 'YYYY-MM-DD'), 3, TO_TIMESTAMP('2023-12-13 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-13 23:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (20, 9, TO_DATE('2023-12-14', 'YYYY-MM-DD'), 4, TO_TIMESTAMP('2023-12-14 17:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-14 20:15:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (21, 10, TO_DATE('2023-12-15', 'YYYY-MM-DD'), 1, TO_TIMESTAMP('2023-12-15 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-15 22:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (22, 1, TO_DATE('2023-12-16', 'YYYY-MM-DD'), 2, TO_TIMESTAMP('2023-12-16 20:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-16 22:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (17, 6, TO_DATE('2023-12-11', 'YYYY-MM-DD'), 1, TO_TIMESTAMP('2023-12-11 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-11 23:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (18, 7, TO_DATE('2023-12-12', 'YYYY-MM-DD'), 2, TO_TIMESTAMP('2023-12-12 18:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-12 20:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (19, 8, TO_DATE('2023-12-13', 'YYYY-MM-DD'), 3, TO_TIMESTAMP('2023-12-13 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-13 23:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (20, 9, TO_DATE('2023-12-14', 'YYYY-MM-DD'), 4, TO_TIMESTAMP('2023-12-14 17:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-14 20:15:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (21, 10, TO_DATE('2023-12-15', 'YYYY-MM-DD'), 1, TO_TIMESTAMP('2023-12-15 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-15 22:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (22, 1, TO_DATE('2023-12-16', 'YYYY-MM-DD'), 2, TO_TIMESTAMP('2023-12-16 20:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-16 22:45:00', 'YYYY-MM-DD HH24:MI:SS'));

select * from movie 
;

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (23, 1, TO_DATE('2023-12-17', 'YYYY-MM-DD'), 3, TO_TIMESTAMP('2023-12-17 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-17 21:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (24, 2, TO_DATE('2023-12-18', 'YYYY-MM-DD'), 4, TO_TIMESTAMP('2023-12-18 19:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-18 22:15:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (25, 3, TO_DATE('2023-12-19', 'YYYY-MM-DD'), 1, TO_TIMESTAMP('2023-12-19 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-19 23:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (26, 4, TO_DATE('2023-12-20', 'YYYY-MM-DD'), 2, TO_TIMESTAMP('2023-12-20 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-20 22:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (27, 5, TO_DATE('2023-12-21', 'YYYY-MM-DD'), 3, TO_TIMESTAMP('2023-12-21 17:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-21 19:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Showtime (showtime_ID, movie_id, showDate, theater_id, Start_time, End_time) 
VALUES (28, 6, TO_DATE('2023-12-22', 'YYYY-MM-DD'), 4, TO_TIMESTAMP('2023-12-22 22:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-22 23:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Customer (customer_ID, Fname, Lname, Email, Phone, Birth_date, Gender, Loyalty_points) 
VALUES (1, 'Alice', 'Johnson', 'alice.johnson@email.com', '123-456-7890', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 'F', 100);

INSERT INTO Customer (customer_ID, Fname, Lname, Email, Phone, Birth_date, Gender, Loyalty_points) 
VALUES (2, 'Bob', 'Smith', 'bob.smith@email.com', '987-654-3210', TO_DATE('1990-08-22', 'YYYY-MM-DD'), 'M', 50);

INSERT INTO Customer (customer_ID, Fname, Lname, Email, Phone, Birth_date, Gender, Loyalty_points) 
VALUES (3, 'Catherine', 'Williams', 'catherine.williams@email.com', '123-789-4560', TO_DATE('1982-11-10', 'YYYY-MM-DD'), 'F', 75);

INSERT INTO Customer (customer_ID, Fname, Lname, Email, Phone, Birth_date, Gender, Loyalty_points) 
VALUES (4, 'David', 'Brown', 'david.brown@email.com', '987-321-6540', TO_DATE('1978-04-28', 'YYYY-MM-DD'), 'M', 120);

INSERT INTO Customer (customer_ID, Fname, Lname, Email, Phone, Birth_date, Gender, Loyalty_points) 
VALUES (5, 'Eva', 'Miller', 'eva.miller@email.com', '123-987-6540', TO_DATE('1995-02-17', 'YYYY-MM-DD'), 'F', 30);

INSERT INTO Customer (customer_ID, Fname, Lname, Email, Phone, Birth_date, Gender, Loyalty_points) 
VALUES (6, 'Frank', 'Taylor', 'frank.taylor@email.com', '987-123-4560', TO_DATE('1988-07-03', 'YYYY-MM-DD'), 'M', 90);

INSERT INTO Customer (customer_ID, Fname, Lname, Email, Phone, Birth_date, Gender, Loyalty_points) 
VALUES (7, 'Fatima', 'Abdullah', 'fatima.abdullah@email.com', '123-456-7890', TO_DATE('1987-03-15', 'YYYY-MM-DD'), 'F', 80);

INSERT INTO Customer (customer_ID, Fname, Lname, Email, Phone, Birth_date, Gender, Loyalty_points) 
VALUES (8, 'Hassan', 'Ali', 'hassan.ali@email.com', '987-654-3210', TO_DATE('1992-06-22', 'YYYY-MM-DD'), 'M', 60);

INSERT INTO Customer (customer_ID, Fname, Lname, Email, Phone, Birth_date, Gender, Loyalty_points) 
VALUES (9, 'Layla', 'Khalid', 'layla.khalid@email.com', '123-789-4560', TO_DATE('1980-09-10', 'YYYY-MM-DD'), 'F', 110);

INSERT INTO Customer (customer_ID, Fname, Lname, Email, Phone, Birth_date, Gender, Loyalty_points) 
VALUES (10, 'Youssef', 'Ahmed', 'youssef.ahmed@email.com', '987-321-6540', TO_DATE('1975-02-28', 'YYYY-MM-DD'), 'M', 45);

INSERT INTO Customer (customer_ID, Fname, Lname, Email, Phone, Birth_date, Gender, Loyalty_points) 
VALUES (11, 'Nour', 'Hamdi', 'nour.hamdi@email.com', '123-987-6540', TO_DATE('1998-12-03', 'YYYY-MM-DD'), 'F', 70);

INSERT INTO Customer (customer_ID, Fname, Lname, Email, Phone, Birth_date, Gender, Loyalty_points) 
VALUES (12, 'Amr', 'Said', 'amr.said@email.com', '987-123-4560', TO_DATE('1983-07-18', 'YYYY-MM-DD'), 'M', 95);

INSERT INTO Reservation (reservation_ID, showtime_ID, customer_ID, res_date, Time) 
VALUES (1, 1, 1, TO_DATE('2023-11-25', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-11-25 18:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Reservation (reservation_ID, showtime_ID, customer_ID, res_date, Time) 
VALUES (2, 5, 8, TO_DATE('2023-11-26', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-11-26 20:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Reservation (reservation_ID, showtime_ID, customer_ID, res_date, Time) 
VALUES (3, 10, 12, TO_DATE('2023-11-27', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-11-27 15:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Reservation (reservation_ID, showtime_ID, customer_ID, res_date, Time) 
VALUES (4, 15, 5, TO_DATE('2023-11-28', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-11-28 19:20:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Reservation (reservation_ID, showtime_ID, customer_ID, res_date, Time) 
VALUES (5, 20, 9, TO_DATE('2023-11-29', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-11-29 21:10:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Reservation (reservation_ID, showtime_ID, customer_ID, res_date, Time) 
VALUES (6, 24, 11, TO_DATE('2023-11-30', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-11-30 16:55:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Reservation (reservation_ID, showtime_ID, customer_ID, res_date, Time) 
VALUES (7, 3, 6, TO_DATE('2023-12-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-01 17:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Reservation (reservation_ID, showtime_ID, customer_ID, res_date, Time) 
VALUES (8, 7, 15, TO_DATE('2023-12-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-02 19:45:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Reservation (reservation_ID, showtime_ID, customer_ID, res_date, Time) 
VALUES (9, 12, 3, TO_DATE('2023-12-03', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-03 14:20:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Reservation (reservation_ID, showtime_ID, customer_ID, res_date, Time) 
VALUES (10, 18, 7, TO_DATE('2023-12-04', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-04 20:10:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Reservation (reservation_ID, showtime_ID, customer_ID, res_date, Time) 
VALUES (11, 23, 14, TO_DATE('2023-12-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-05 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Reservation (reservation_ID, showtime_ID, customer_ID, res_date, Time) 
VALUES (12, 26, 2, TO_DATE('2023-12-06', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-06 21:30:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (01, 'VIP', 11, 150);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (02, 'standard', 12, 40);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (03, 'standard', 23, 40);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (04, 'VIP', 2, 150);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (05, 'premium', 3, 50);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (06, 'premium', 1, 50);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (07, 'standard', 5, 40);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (08, 'VIP', 6, 150);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (09, 'premium', 7, 50);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (10, 'standard', 8, 40);

INSERT INTO Seats (Seat_ID, seat_type, Theater_ID, price) 
VALUES (01, 'VIP', 11, 150);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (02, 'standard', 12, 40);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (03, 'standard', 23, 40);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (04, 'VIP', 2, 150);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (05, 'premium', 3, 50);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (06, 'premium', 1, 50);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (07, 'standard', 5, 40);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (08, 'VIP', 6, 150);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (09, 'premium', 7, 50);

INSERT INTO Seats (Seat_ID, Stype, Theater_ID, price) 
VALUES (10, 'standard', 8, 40);

select * from reservation 
select * from customer 
select * from showtime;

select * from reservation;

select * from customer;

select * from showtime;

select * from theater;

select * from seats;

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (1, 'standard', 1, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(2, 'premium', 1, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(3, 'wheelchair accessible', 1, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (1, 'standard', 1, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(2, 'premium', 1, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (1, 'standard', 1, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(2, 'premium', 1, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (1, 'standard', 1, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(2, 'premium', 1, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (1, 'standard', 1, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(2, 'premium', 1, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (1, 'standard', 1, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(2, 'premium', 1, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (1, 'standard', 1, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(2, 'premium', 1, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (1, 'standard', 1, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(2, 'premium', 1, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(3, 'wheelchair accessible', 1, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (4, 'standard', 1, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(5, 'premium', 1, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (6, 'standard', 1, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(7, 'premium', 1, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (8, 'standard', 1, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(9, 'premium', 1, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (10, 'standard', 1, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (11, 'standard', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(12, 'premium', 2, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(13, 'wheelchair accessible', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (14, 'standard', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(15, 'premium', 2, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (16, 'standard', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(17, 'premium', 2, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (18, 'standard', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(19, 'premium', 2, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (20, 'standard', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (11, 'standard', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(12, 'premium', 2, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(13, 'wheelchair accessible', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (14, 'standard', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(15, 'premium', 2, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (16, 'standard', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(17, 'premium', 2, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (18, 'standard', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(19, 'premium', 2, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (20, 'standard', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (11, 'standard', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(12, 'premium', 2, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(13, 'wheelchair accessible', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (14, 'standard', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(15, 'premium', 2, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (16, 'standard', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(17, 'premium', 2, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (18, 'standard', 2, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES(19, 'premium', 2, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (20, 'standard', 2, 40);

select *  from seats;

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (21, 'standard', 3, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (22, 'premium', 3, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (23, 'wheelchair accessible', 3, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (24, 'standard', 3, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (25, 'premium', 3, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (26, 'standard', 3, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (27, 'premium', 3, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (28, 'standard', 3, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (29, 'premium', 3, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (30, 'standard', 3, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (31, 'standard', 4, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (32, 'premium', 4, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (33, 'wheelchair accessible', 4, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (34, 'standard', 4, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (35, 'premium', 4, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (36, 'standard', 4, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (37, 'premium', 4, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (38, 'standard', 4, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (39, 'premium', 4, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (40, 'standard', 4, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (31, 'standard', 4, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (32, 'premium', 4, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (33, 'wheelchair accessible', 4, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (34, 'standard', 4, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (35, 'premium', 4, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (36, 'standard', 4, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (37, 'premium', 4, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (38, 'standard', 4, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (39, 'premium', 4, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (40, 'standard', 4, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (41, 'standard', 5, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (42, 'premium', 5, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (43, 'wheelchair accessible', 5, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (44, 'standard', 5, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (45, 'premium', 5, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (46, 'standard', 6, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (47, 'premium', 6, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (48, 'standard', 6, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (49, 'premium', 6, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (50, 'standard', 6, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (51, 'standard', 7, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (52, 'premium', 7, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (53, 'wheelchair accessible', 7, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (54, 'standard', 7, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (55, 'premium', 7, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (56, 'standard', 8, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (57, 'premium', 8, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (58, 'standard', 8, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (59, 'premium', 8, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (60, 'standard', 8, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (61, 'standard', 9, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (62, 'premium', 9, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (63, 'wheelchair accessible', 9, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (64, 'standard', 9, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (65, 'premium', 9, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (66, 'standard', 10, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (67, 'premium', 10, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (68, 'standard', 10, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (69, 'premium', 10, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (70, 'standard', 10, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (71, 'standard', 11, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (72, 'premium', 11, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (73, 'wheelchair accessible', 11, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (74, 'standard', 11, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (75, 'premium', 11, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (76, 'standard', 12, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (77, 'premium', 12, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (78, 'standard', 12, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (79, 'premium', 12, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (80, 'standard', 12, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (81, 'standard', 13, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (82, 'premium', 13, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (83, 'wheelchair accessible', 13, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (84, 'standard', 13, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (85, 'premium', 13, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (81, 'standard', 13, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (82, 'premium', 13, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (86, 'standard', 14, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (87, 'premium', 14, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (88, 'standard', 14, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (89, 'premium', 14, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (90, 'standard', 14, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (83, 'wheelchair accessible', 13, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (84, 'standard', 13, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (85, 'premium', 13, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (86, 'standard', 14, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (87, 'premium', 14, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (88, 'standard', 14, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (89, 'premium', 14, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (90, 'standard', 14, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (91, 'standard', 15, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (92, 'premium', 15, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (93, 'wheelchair accessible', 15, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (94, 'standard', 15, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (95, 'premium', 15, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (96, 'standard', 16, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (97, 'premium', 16, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (98, 'standard', 16, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (99, 'premium', 16, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (100, 'standard', 16, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (101, 'standard', 17, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (102, 'premium', 17, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (103, 'wheelchair accessible', 17, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (104, 'standard', 17, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (105, 'premium', 17, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (106, 'standard', 18, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (107, 'premium', 18, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (108, 'standard', 18, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (109, 'premium', 18, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (110, 'standard', 18, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (111, 'standard', 19, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (112, 'premium', 19, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (113, 'wheelchair accessible', 19, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (114, 'standard', 19, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (115, 'premium', 19, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (116, 'standard', 20, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (117, 'premium', 20, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (118, 'standard', 20, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (119, 'premium', 20, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (120, 'standard', 20, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (121, 'standard', 19, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (122, 'premium', 19, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (123, 'wheelchair accessible', 19, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (124, 'standard', 19, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (125, 'premium', 19, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (126, 'standard', 20, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (127, 'premium', 20, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (128, 'standard', 20, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (129, 'premium', 20, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (130, 'standard', 20, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (131, 'standard', 21, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (132, 'premium', 21, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (133, 'standard', 21, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (134, 'premium', 21, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (135, 'standard', 21, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (136, 'premium', 22, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (137, 'standard', 22, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (138, 'premium', 22, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (139, 'standard', 22, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (140, 'premium', 22, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (121, 'standard', 19, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (122, 'premium', 19, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (123, 'wheelchair accessible', 19, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (124, 'standard', 19, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (125, 'premium', 19, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (126, 'standard', 20, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (127, 'premium', 20, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (128, 'standard', 20, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (129, 'premium', 20, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (130, 'standard', 20, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (131, 'standard', 21, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (132, 'premium', 21, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (133, 'standard', 21, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (134, 'premium', 21, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (135, 'standard', 21, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (136, 'premium', 22, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (137, 'standard', 22, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (138, 'premium', 22, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (139, 'standard', 22, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (140, 'premium', 22, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (141, 'standard', 23, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (142, 'premium', 23, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (143, 'wheelchair accessible', 23, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (144, 'standard', 23, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (145, 'premium', 23, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (146, 'standard', 24, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (147, 'premium', 24, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (148, 'standard', 24, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (149, 'premium', 24, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (150, 'standard', 24, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (151, 'standard', 25, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (152, 'premium', 25, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (153, 'wheelchair accessible', 25, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (154, 'standard', 25, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (155, 'premium', 25, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (156, 'standard', 26, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (157, 'premium', 26, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (158, 'standard', 26, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (159, 'premium', 26, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (160, 'standard', 26, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (161, 'standard', 27, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (162, 'premium', 27, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (163, 'wheelchair accessible', 27, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (164, 'standard', 27, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (165, 'premium', 27, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (166, 'standard', 28, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (167, 'premium', 28, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (168, 'standard', 28, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (169, 'premium', 28, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (170, 'standard', 28, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (171, 'premium', 29, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (172, 'standard', 29, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (173, 'premium', 29, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (174, 'standard', 29, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (175, 'premium', 29, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (176, 'standard', 30, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (177, 'premium', 30, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (178, 'standard', 30, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (179, 'premium', 30, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (180, 'standard', 30, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (181, 'standard', 31, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (182, 'premium', 31, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (183, 'wheelchair accessible', 31, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (184, 'standard', 31, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (185, 'premium', 31, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (186, 'standard', 32, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (187, 'premium', 32, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (188, 'standard', 32, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (189, 'premium', 32, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (190, 'standard', 32, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (191, 'standard', 33, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (192, 'premium', 33, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (193, 'wheelchair accessible', 33, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (194, 'standard', 33, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (195, 'premium', 33, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (196, 'standard', 33, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (197, 'premium', 33, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (198, 'standard', 33, 40);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (199, 'premium', 33, 60);

INSERT INTO Seats (seat_ID, seat_type, theater_ID, price) 
VALUES (200, 'standard', 33, 40);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (1, TO_DATE('2023-11-20', 'YYYY-MM-DD'), 'successful', 1, 1, 100.00, 5.00);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (2, TO_DATE('2023-11-21', 'YYYY-MM-DD'), 'pending', 2, 2, 80.00, 0);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (3, TO_DATE('2023-11-22', 'YYYY-MM-DD'), 'declined', 3, 3, 120.00, 10.00);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (4, TO_DATE('2023-11-23', 'YYYY-MM-DD'), 'canceled', 4, 4, 90.00, 0);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (5, TO_DATE('2023-11-24', 'YYYY-MM-DD'), 'successful', 5, 5, 150.00, 15.00);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (6, TO_DATE('2023-11-25', 'YYYY-MM-DD'), 'pending', 6, 6, 110.00, 0);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (7, TO_DATE('2023-11-26', 'YYYY-MM-DD'), 'declined', 7, 7, 120.00, 5.00);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (8, TO_DATE('2023-11-27', 'YYYY-MM-DD'), 'successful', 8, 8, 90.00, 0);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (9, TO_DATE('2023-11-28', 'YYYY-MM-DD'), 'canceled', 9, 9, 110.00, 3.00);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (10, TO_DATE('2023-11-29', 'YYYY-MM-DD'), 'pending', 10, 10, 70.00, 0);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (11, TO_DATE('2023-11-30', 'YYYY-MM-DD'), 'successful', 11, 11, 120.00, 5.00);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (12, TO_DATE('2023-12-01', 'YYYY-MM-DD'), 'successful', 12, 12, 80.00, 2.00);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (13, TO_DATE('2023-12-02', 'YYYY-MM-DD'), 'successful', 13, 13, 100.00, 0);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (14, TO_DATE('2023-12-03', 'YYYY-MM-DD'), 'successful', 14, 14, 110.00, 3.00);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (15, TO_DATE('2023-12-04', 'YYYY-MM-DD'), 'successful', 15, 15, 90.00, 0);

INSERT INTO Payment (payment_ID, payment_date, payment_status, customer_ID, reservation_ID, Total_amount, Discounts) 
VALUES (16, TO_DATE('2023-12-05', 'YYYY-MM-DD'), 'successful', 16, 16, 70.00, 0);

select * from payment 
;

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (1, 1, '1234-5678-9012-3456', TO_DATE('2024-12-31', 'YYYY-MM-DD'), 123);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (2, 2, '5678-9012-3456-7890', TO_DATE('2023-10-31', 'YYYY-MM-DD'), 456);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (3, 3, '9012-3456-7890-1234', TO_DATE('2025-05-31', 'YYYY-MM-DD'), 789);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (4, 4, '3456-7890-1234-5678', TO_DATE('2024-08-31', 'YYYY-MM-DD'), 234);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (5, 5, '7890-1234-5678-9012', TO_DATE('2023-11-30', 'YYYY-MM-DD'), 567);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (6, 6, '2345-6789-0123-4567', TO_DATE('2025-02-28', 'YYYY-MM-DD'), 890);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (7, 7, '6789-0123-4567-8901', TO_DATE('2023-09-30', 'YYYY-MM-DD'), 123);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (8, 8, '0123-4567-8901-2345', TO_DATE('2024-04-30', 'YYYY-MM-DD'), 456);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (9, 9, '4567-8901-2345-6789', TO_DATE('2025-07-31', 'YYYY-MM-DD'), 789);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (10, 10, '8901-2345-6789-0123', TO_DATE('2023-12-31', 'YYYY-MM-DD'), 234);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (11, 11, '1234-5678-9012-3456', TO_DATE('2024-05-31', 'YYYY-MM-DD'), 567);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (12, 12, '5678-9012-3456-7890', TO_DATE('2023-08-31', 'YYYY-MM-DD'), 890);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES  
    (1, 1, '1234-5678-9012-3456', TO_DATE('2024-12-31', 'YYYY-MM-DD'), 123), 
    (2, 1, '5678-9012-3456-7890', TO_DATE('2023-10-31', 'YYYY-MM-DD'), 456);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (3, 2, '9012-3456-7890-1234', TO_DATE('2025-05-31', 'YYYY-MM-DD'), 789);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES  
    (4, 3, '3456-7890-1234-5678', TO_DATE('2024-08-31', 'YYYY-MM-DD'), 234), 
    (5, 3, '7890-1234-5678-9012', TO_DATE('2023-11-30', 'YYYY-MM-DD'), 567);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (6, 4, '2345-6789-0123-4567', TO_DATE('2025-02-28', 'YYYY-MM-DD'), 890);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (7, 5, '6789-0123-4567-8901', TO_DATE('2023-09-30', 'YYYY-MM-DD'), 123);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (8, 6, '0123-4567-8901-2345', TO_DATE('2024-04-30', 'YYYY-MM-DD'), 456);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (9, 7, '4567-8901-2345-6789', TO_DATE('2025-07-31', 'YYYY-MM-DD'), 789);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (10, 8, '8901-2345-6789-0123', TO_DATE('2023-12-31', 'YYYY-MM-DD'), 234);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (11, 9, '1234-5678-9012-3456', TO_DATE('2024-05-31', 'YYYY-MM-DD'), 567);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES  
    (12, 10, '5678-9012-3456-7890', TO_DATE('2023-08-31', 'YYYY-MM-DD'), 890), 
    (13, 10, '9012-3456-7890-1234', TO_DATE('2025-01-31', 'YYYY-MM-DD'), 123);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES  
    
    (13, 1, '5678-9012-3456-7890', TO_DATE('2023-10-31', 'YYYY-MM-DD'), 456);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (14, 2, '9012-3456-7890-1234', TO_DATE('2025-05-31', 'YYYY-MM-DD'), 789);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES  
     
    (15, 3, '7890-1234-5678-9012', TO_DATE('2023-11-30', 'YYYY-MM-DD'), 567);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (17, 4, '2345-6789-0123-4567', TO_DATE('2025-02-28', 'YYYY-MM-DD'), 890);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (18, 5, '6789-0123-4567-8901', TO_DATE('2023-09-30', 'YYYY-MM-DD'), 123);

INSERT INTO Payment_method (method_id, Customer_id, Card_number, Card_exp_date, CVV_card) 
VALUES (19, 6, '0123-4567-8901-2345', TO_DATE('2024-04-30', 'YYYY-MM-DD'), 456);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (1, 1);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES(1, 2);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (1, 3);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (2, 4);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES(2, 5);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (3, 7);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES(3, 8);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES(3, 9);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (4, 10);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES(4, 11);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (5, 13);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES(5, 14);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (6, 16);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES(6, 17);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (7, 19);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES(7, 20);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES(7, 21);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (8, 24);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (9, 25);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES(9, 26);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES(9, 27);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (10, 28), (10, 29), (10, 30);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (11, 31);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (11, 32);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (12, 34);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (12, 35);

INSERT INTO Has_reservation (reservation_id, seat_id) 
VALUES (12, 36);

select * from Has_resrvation  
 
;

select * from Has_reservation  
 
;

