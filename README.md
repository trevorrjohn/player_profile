# Player Profiles

## Step 1:

Import and persist the players from the following CBS api for baseball, football, and basketball.

<http://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=baseball&response_format=JSON>

## Step 2:

Create a JSON api endpoint for a player. Like seen below

```json
{
id: 
name_brief:
first_name:
last_name:
position:
age:
average_position_age_diff:
}
```

Each element in the JSON should be self explanatory except for the following two.

### name_brief:

* For football players it should be first initial and their last name like P. Manning
* For basketball players it should be first name plus last initial like  Kobe B.
* For baseball players it should be just first initial and last initial like G. S.

### average_position_age_diff:

* This value should the difference between the age of the player vs the average age for his position
