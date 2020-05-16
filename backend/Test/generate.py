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
users_per_pin = 20

# Tokens per user
tokens_per_user = 5

# ShopTypes - generate shop type by using one number between 1 and 11
shop_types = 11

# Same password for all
password = 'password'

# Counter vairables
num_users = 0
num_shops = 0
users = []
shops = []
shop_slots = []


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
        user_dict['contactNumber'] = generate_mobile()
        user_dict['aadharNumber'] = generate_aadhar()
        user_dict['state'] = 'Uttar Pradesh'
        user_dict['district'] = 'Lucknow'
        user_dict['pincode'] = str(start_pincode + pincode)
        user_dict['verificationStatus'] = 1
        r = requests.post(url=(SERVER_URL + makeUser), json=user_dict)
        num_users += 1
        temp_users.append(user_id)

    # Shop objects
    for _ in range(shops_per_pin):
        shop_name = start_shop + num_shops
        shop_id = start_shop_id + num_shops
        shop_dict = {}
        shop_dict['name'] = 'Shop ' + str(shop_name)
        shop_dict['owner'] = 'Owner ' + str(shop_name)
        shop_dict['email'] = 'shop' + str(shop_name) + '@shop.com'
        shop_dict['contactNumber'] = generate_mobile()
        shop_dict['shopType'] = random.randint(1, shop_types)
        shop_dict['address'] = 'Vibhav Khand, Gomti Nagar, Lucknow'
        shop_dict['landmark'] = 'Cinepolis and Kisaan Bazaar'
        shop_dict['password'] = password
        shop_dict['state'] = 'Uttar Pradesh'
        shop_dict['district'] = 'Lucknow'
        shop_dict['pincode'] = str(start_pincode + pincode)
        # Give some shops verificationStatus 0 others 1
        p = random.random()
        if p < 0.25:
            shop_dict['verificationStatus'] = 0
        else:
            shop_dict['verificationStatus'] = 1
        shop_dict['verifierId'] = 0
        shop_dict['shopSize'] = random.randint(1, 3)
        shop_dict['openTime'] = '10:00:00'
        shop_dict['closeTime'] = '17:00:00'
        r = requests.post(url=(SERVER_URL + makeShop), json=shop_dict)
        # Add into list if verificationStatus is 1
        if shop_dict['verificationStatus'] == 1:
            temp_shops.append((shop_id, shop_dict['shopSize']))
        num_shops += 1

    # Local Authority objects - Add a single authority
    auth_dict = {}
    auth_dict['name'] = 'Officer ' + str(start_auth)
    auth_dict['email'] = 'auth' + str(start_auth) + '@auth.com'
    auth_dict['contactNumber'] = generate_mobile()
    auth_dict['password'] = password
    auth_dict['aadharNumber'] = generate_aadhar()
    auth_dict['state'] = 'Uttar Pradesh'
    auth_dict['district'] = 'Lucknow'
    auth_dict['pincode'] = str(start_pincode + pincode)
    auth_dict['verificationStatus'] = 1
    r = requests.post(url=(SERVER_URL + makeAuth), json=auth_dict)
    start_auth += 1

    users.append(temp_users)
    shops.append(temp_shops)

# Generate functionality objects
# Generate shop bookings first
for pincode in range(num_pincodes):
    temp_shop_slots = []

    for tup in shops[pincode]:
        shop_id = tup[0]
        shop_size = tup[1]
        # Generate bookings for today and tomorrow
        for day in range(2):
            # Generate 12 slots per day
            for slot in range(10):
                shop_booking_dict = {}
                shop_booking_dict['shopId'] = shop_id
                shop_booking_dict['date'] = datetime.strftime(
                    datetime.now() - timedelta(day), '%Y-%m-%d')
                if shop_size == 1:
                    time_in_seconds = 36000 + slot * 1200
                    shop_booking_dict['duration'] = '00:15:00'
                    shop_booking_dict['capacity'] = 5
                elif shop_size == 2:
                    time_in_seconds = 36000 + slot * 2100
                    shop_booking_dict['duration'] = '00:30:00'
                    shop_booking_dict['capacity'] = 10
                else:
                    time_in_seconds = 36000 + slot * 2400
                    shop_booking_dict['duration'] = '00:30:00'
                    shop_booking_dict['capacity'] = 20
                shop_booking_dict['startTime'] = time.strftime(
                    '%H:%M:%S', time.gmtime(time_in_seconds))

                r = requests.post(url=(SERVER_URL + makeBooking),
                                  json=shop_booking_dict)
                temp_shop_slots.append(shop_booking_dict)

        # Add for tomorrow
        for slot in range(10):
            shop_booking_dict = {}
            shop_booking_dict['shopId'] = shop_id
            shop_booking_dict['date'] = datetime.strftime(
                datetime.now() + timedelta(1), '%Y-%m-%d')
            if shop_size == 1:
                time_in_seconds = 36000 + slot * 1200
                shop_booking_dict['duration'] = '00:15:00'
                shop_booking_dict['capacity'] = 5
            elif shop_size == 2:
                time_in_seconds = 36000 + slot * 2100
                shop_booking_dict['duration'] = '00:30:00'
                shop_booking_dict['capacity'] = 10
            else:
                time_in_seconds = 36000 + slot * 2400
                shop_booking_dict['duration'] = '00:30:00'
                shop_booking_dict['capacity'] = 20
            shop_booking_dict['startTime'] = time.strftime(
                '%H:%M:%S', time.gmtime(time_in_seconds))

            r = requests.post(url=(SERVER_URL + makeBooking),
                              json=shop_booking_dict)
            temp_shop_slots.append(shop_booking_dict)
    shop_slots.append(temp_shop_slots)

# Generate tokens
for pincode in range(num_pincodes):
    len_slot = len(shop_slots[pincode])
    for user_id in users[pincode]:
        for _ in range(tokens_per_user):
            choose_slot = shop_slots[pincode][random.randint(0, len_slot - 1)]
            token_dict = {}
            token_dict['userId'] = user_id
            token_dict['date'] = choose_slot['date']
            token_dict['shopId'] = choose_slot['shopId']
            token_dict['startTime'] = choose_slot['startTime']
            token_dict['duration'] = choose_slot['duration']
            r = requests.post(url=(SERVER_URL + bookToken), json=token_dict)
