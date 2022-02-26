DROP TABLE IF EXISTS year_2018;
DROP TABLE IF EXISTS year_2019;
DROP TABLE IF EXISTS year_2020;

CREATE TABLE year_2018(
hotel						CHAR(50),
is_canceled					INT,
lead_time					INT,
arrival_date_year			INT,
arrival_date_month			CHAR(50),
arrival_date_week_number	INT,
arrival_date_day_of_month	INT,
stays_in_weekend_nights		INT,
stays_in_week_nights		INT,
adults						INT,
children					INT,
babies						INT,
meal						CHAR(50),
country						CHAR(50),
market_segment				CHAR(50),
distribution_channel		CHAR(50),
is_repeated_guest			INT,
previous_cancellations		INT,
previous_bookings_not_canceled	INT,
reserved_room_type			CHAR(1),
assigned_room_type			CHAR(1),
booking_changes				INT,
deposit_type				CHAR(50),
agent						text,
company						CHAR(10),
days_in_waiting_list		INT,
customer_type				CHAR(50),
adr							FLOAT,
required_car_parking_spaces	INT,
total_of_special_requests	INT,
reservation_status			CHAR(50),
reservation_status_date		DATE

);


COPY year_2018 FROM '...\Hotel Booking Data Analysis\hotel_revenue_historical_full_2018.csv' WITH CSV HEADER;


CREATE TABLE year_2019(
hotel						CHAR(50),
is_canceled					INT,
lead_time					INT,
arrival_date_year			INT,
arrival_date_month			CHAR(50),
arrival_date_week_number	INT,
arrival_date_day_of_month	INT,
stays_in_weekend_nights		INT,
stays_in_week_nights		INT,
adults						INT,
children					INT,
babies						INT,
meal						CHAR(50),
country						CHAR(50),
market_segment				CHAR(50),
distribution_channel		CHAR(50),
is_repeated_guest			INT,
previous_cancellations		INT,
previous_bookings_not_canceled	INT,
reserved_room_type			CHAR(1),
assigned_room_type			CHAR(1),
booking_changes				INT,
deposit_type				CHAR(50),
agent						text,
company						CHAR(10),
days_in_waiting_list		INT,
customer_type				CHAR(50),
adr							FLOAT,
required_car_parking_spaces	INT,
total_of_special_requests	INT,
reservation_status			CHAR(50),
reservation_status_date		DATE

);


COPY year_2019 FROM '...\Hotel Booking Data Analysis\hotel_revenue_historical_full_2019.csv' WITH CSV HEADER;




CREATE TABLE year_2020(
hotel						CHAR(50),
is_canceled					INT,
lead_time					INT,
arrival_date_year			INT,
arrival_date_month			CHAR(50),
arrival_date_week_number	INT,
arrival_date_day_of_month	INT,
stays_in_weekend_nights		INT,
stays_in_week_nights		INT,
adults						INT,
children					INT,
babies						INT,
meal						CHAR(50),
country						CHAR(50),
market_segment				CHAR(50),
distribution_channel		CHAR(50),
is_repeated_guest			INT,
previous_cancellations		INT,
previous_bookings_not_canceled	INT,
reserved_room_type			CHAR(1),
assigned_room_type			CHAR(1),
booking_changes				INT,
deposit_type				CHAR(50),
agent						text,
company						CHAR(10),
days_in_waiting_list		INT,
customer_type				CHAR(50),
adr							FLOAT,
required_car_parking_spaces	INT,
total_of_special_requests	INT,
reservation_status			CHAR(50),
reservation_status_date		DATE

);


COPY year_2020 FROM '...\Hotel Booking Data Analysis\hotel_revenue_historical_full_2020.csv' WITH CSV HEADER;


WITH hotels as (
select * from year_2018
union
select * from year_2019
union
select * from year_2020)

--select CASE WHEN agent = 'NULL' THEN NULL ELSE agent END as Agent, CASE WHEN company = 'NULL' THEN NULL ELSE company END as Company  from hotels; 

-- Analyzing the data that we have now
select 
arrival_date_year, hotel,
round(sum((stays_in_week_nights+stays_in_weekend_nights)*adr)) as Revenue 
from hotels
group by arrival_date_year, hotel order by arrival_date_year;

select * from hotels
left join market_segment
on hotels.market_segment = market_segment.market_segment
left join meal_cost
on meal_cost.meal = hotels.meal;