"""Generate data objects to fill in the database"""
import json
import time
import random
import requests
from api import *
from datetime import datetime, timedelta

# Server config
SERVER_URL = 'http://localhost:3000'

# Number of areas to add in the database
num_pincodes = 2
start_pincode = 226010

# Generate names
start_user = 100  # Used in names
start_user_id = 1  # Starting id in the database (used in creating Tokens)
start_auth = 100  # Used in names
start_auth_id = 1  # Starting id in the database
start_shop = 501  # Used in names
start_shop_id = 1  # Starting id in the database

# Number of entities per pincode
shops_per_pin = 40
users_per_pin = 40

# Tokens per user
tokens_per_user = 5

# ShopTypes - generate shop type by using one number between 1 and 11
shop_types = 11
shopType_mapping = {
    1 : "General Market",
    2 : "Sabzi Market",
    3 : "Supermarket",
    4 : "Restaurant and Cafes",
    5 : "Medical Store",
    6 : "Parlour and Hair Saloon",
    7 : "Dairy",
    8 : "Liquor",
    9 : "Jwellery Shop",
    10 : "Stationery Shop",
    11 : "Hardware and Construction Shops"
    }

# capacities - generate shop capacity by using one number between 1 and 3
num_capacity = 3
capacity_mapping = {
    1 : 5,
    2 : 10,
    3 : 15,
    }

# Same password for all
password = 'password'

# Counter vairables
num_users = 0
num_shops = 0
users = []
shops = []
shop_slots = []

shop_opening_time = '11:00:00';
shop_closing_time = '13:00:00';


def generate_mobile():
    return '9987' + ''.join(
        ["{}".format(random.randint(0, 9)) for num in range(0, 6)])


def generate_aadhar():
    return '112398' + ''.join(
        ["{}".format(random.randint(0, 9)) for num in range(0, 6)])


def generate_date():
    p = random.random()
    if p < 0.5:
        return
    return datetime.strftime(datetime.now(), '%Y-%m-%d')


def generate_start_time():
    return time.strftime('%H:%M:%S', time.gmtime(random.randint()))


# Generate base objects
for pincode in range(num_pincodes):
    temp_users = []
    temp_shops = []

    # User objects
    for _ in range(users_per_pin):
        user_name = start_user + num_users
        user_id = start_user_id + num_users
        user_dict = {}
        user_dict['name'] = 'User ' + str(user_name)
        user_dict['email'] = 'user' + str(user_name) + '@user.com'
        user_dict['password'] = password
        user_dict['mobileNumber'] = generate_mobile()
        user_dict['aadharNumber'] = generate_aadhar()
        user_dict['pincode'] = str(start_pincode + pincode)
        r = requests.post(url=(SERVER_URL + makeUser), json=user_dict)
        num_users += 1
        temp_users.append(user_id)

    # Shop objects
    for _ in range(shops_per_pin):
        shop_name = start_shop + num_shops
        shop_id = start_shop_id + num_shops
        shop_dict = {}
        shop_dict['shopName'] = 'Shop ' + str(shop_name)
        shop_dict['ownerName'] = 'Owner ' + str(shop_name)
        shop_dict['email'] = 'shop' + str(shop_name) + '@shop.com'
        shop_dict['mobileNumber'] = generate_mobile()
        shop_dict['aadharNumber'] = generate_aadhar()
        shop_dict['password'] = password
        new_shopTypeId = random.randint(1, shop_types)
        shop_dict['shopTypeId'] = new_shopTypeId 
        shop_dict['shopType'] = shopType_mapping[new_shopTypeId]
        shop_dict['address'] = 'Vibhav Khand, Gomti Nagar, Lucknow'
        shop_dict['landmark'] = 'Cinepolis and Kisaan Bazaar'
        shop_dict['pincode'] = str(start_pincode + pincode)
        # Give some shops verificationStatus 0 others 1
        p = random.random()
        if p < 0.025:
            shop_dict['authVerification'] = 0
        else:
            shop_dict['authVerification'] = 1
        new_capacityIdApp = random.randint(1, num_capacity)
        shop_dict['capacityIdApp'] = new_capacityIdApp
        shop_dict['capacityApp'] = capacity_mapping[new_capacityIdApp]
        shop_dict['openingTimeApp'] = shop_opening_time
        shop_dict['closingTimeApp'] = shop_closing_time
        shop_dict['currOpeningTime'] = shop_opening_time
        shop_dict['currClosingTime'] = shop_closing_time
        r = requests.post(url=(SERVER_URL + makeShop), json=shop_dict)

        num_shops += 1

    # Local Authority objects - Add a single authority
    auth_dict = {}
    auth_dict['name'] = 'Officer ' + str(start_auth)
    auth_dict['email'] = 'auth' + str(start_auth) + '@auth.com'
    auth_dict['mobileNumber'] = generate_mobile()
    auth_dict['password'] = password
    auth_dict['aadharNumber'] = generate_aadhar()
    auth_dict['pincode'] = str(start_pincode + pincode)
    r = requests.post(url=(SERVER_URL + makeAuth), json=auth_dict)
    start_auth += 1

    users.append(temp_users)
    shops.append(temp_shops)

print ("users, shops, localAuths table filled up!");

r = requests.post(url=(SERVER_URL + makeBooking), json=auth_dict)
print ("shopBookngs table filled up!");
# Generate functionality objects
# Generate shop bookings first
# for pincode in range(num_pincodes):
#     temp_shop_slots = []

#     for tup in shops[pincode]:
#         shop_id = tup[0]
#         shop_size = tup[1]
#         # Generate bookings for today and tomorrow
#         for day in range(2):
#             # Generate 12 slots per day
#             for slot in range(10):
#                 shop_booking_dict = {}
#                 shop_booking_dict['shopId'] = shop_id
#                 shop_booking_dict['date'] = datetime.strftime(
#                     datetime.now() - timedelta(day), '%Y-%m-%d')
#                 if shop_size == 1:
#                     time_in_seconds = 36000 + slot * 1200
#                     shop_booking_dict['duration'] = '00:15:00'
#                     shop_booking_dict['capacity'] = 5
#                 elif shop_size == 2:
#                     time_in_seconds = 36000 + slot * 2100
#                     shop_booking_dict['duration'] = '00:30:00'
#                     shop_booking_dict['capacity'] = 10
#                 else:
#                     time_in_seconds = 36000 + slot * 2400
#                     shop_booking_dict['duration'] = '00:30:00'
#                     shop_booking_dict['capacity'] = 20
#                 shop_booking_dict['startTime'] = time.strftime(
#                     '%H:%M:%S', time.gmtime(time_in_seconds))

#                 r = requests.post(url=(SERVER_URL + makeBooking),
#                                   json=shop_booking_dict)
#                 temp_shop_slots.append(shop_booking_dict)

#         # Add for tomorrow
#         for slot in range(10):
#             shop_booking_dict = {}
#             shop_booking_dict['shopId'] = shop_id
#             shop_booking_dict['date'] = datetime.strftime(
#                 datetime.now() + timedelta(1), '%Y-%m-%d')
#             if shop_size == 1:
#                 time_in_seconds = 36000 + slot * 1200
#                 shop_booking_dict['duration'] = '00:15:00'
#                 shop_booking_dict['capacity'] = 5
#             elif shop_size == 2:
#                 time_in_seconds = 36000 + slot * 2100
#                 shop_booking_dict['duration'] = '00:30:00'
#                 shop_booking_dict['capacity'] = 10
#             else:
#                 time_in_seconds = 36000 + slot * 2400
#                 shop_booking_dict['duration'] = '00:30:00'
#                 shop_booking_dict['capacity'] = 20
#             shop_booking_dict['startTime'] = time.strftime(
#                 '%H:%M:%S', time.gmtime(time_in_seconds))

#             r = requests.post(url=(SERVER_URL + makeBooking),
#                               json=shop_booking_dict)
#             temp_shop_slots.append(shop_booking_dict)
#     shop_slots.append(temp_shop_slots)

# Generate tokens
# for pincode in range(num_pincodes):
#     # len_slot = len(shop_slots[pincode])
#     for user_id in users[pincode]:
#         for _ in range(tokens_per_user):
#             choose_slot = shop_slots[pincode][random.randint(0, len_slot - 1)]
#             token_dict = {}
#             token_dict['shopId'] = 
#             token_dict['shopName'] = 
#             token_dict['userId'] = 
#             token_dict['userName'] = 
#             token_dict['date'] = choose_slot['date']
#             token_dict['slotNumber'] = choose_slot['slotNumber']
#             r = requests.post(url=(SERVER_URL + bookToken), json=token_dict)
