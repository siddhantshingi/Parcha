"""Generate data objects to fill in the database"""
import json
import time
import random
import requests
from api import *
from utils import *
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
num_shopTypes = 11

# capacities - generate shop capacity by using one number between 1 and 3
num_capacity = 3

# Same password for all
password = 'password'

# Counter vairables
num_users = 0
num_shops = 0

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

user_details = []
verified_shop_details = []

# Generate base objects
for pincode in range(num_pincodes):
    temp_user_details = []
    temp_verified_shop_details = []
    # User objects
    for _ in range(users_per_pin):
        user_name = start_user + num_users
        user_id = start_user_id + num_users
        user_email = 'user' + str(user_name) + '@user.com'
        user_dict = {}
        user_dict['name'] = 'User ' + str(user_name)
        user_dict['email'] = user_email
        user_dict['password'] = password
        user_dict['mobileNumber'] = generate_mobile()
        user_dict['aadharNumber'] = generate_aadhar()
        user_dict['pincode'] = str(start_pincode + pincode)
        r = requests.post(url=(SERVER_URL + makeUser), json=user_dict)
        num_users += 1

        temp_user_details.append({"user_id": user_id, "user_name": 'User ' + str(user_name), "user_email": user_email})

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
        new_shopTypeId = random.randint(1, num_shopTypes)
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
            temp_verified_shop_details.append({"shop_id":shop_id, "shop_name":'Shop ' + str(shop_name)});
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

    user_details.append(temp_user_details);
    verified_shop_details.append(temp_verified_shop_details);

print ("users, shops, localAuths table filled up!");

# initiate periodic function
r = requests.post(url=(SERVER_URL + makeBooking), json=auth_dict)
print ("shopBookngs table filled up!");

# Generate tokens
num_tokens = 0
for pincode in range(num_pincodes):
    for user in user_details[pincode]:
        for _ in range(tokens_per_user):
            token_dict = {}
            shop = random.choice(verified_shop_details[pincode])
            token_dict['shopId'] = shop['shop_id']
            token_dict['shopName'] = shop['shop_name']
            token_dict['userId'] = user['user_id']
            token_dict['userName'] = user['user_name']
            token_dict['userEmail'] = user['user_email']
            token_dict['date'] = datetime.strftime(datetime.now() + timedelta(random.randint(0,2)), '%Y-%m-%d')
            token_dict['slotNumber'] = random.randint(slotNumber_mapping[shop_opening_time], slotNumber_mapping[shop_closing_time] - 1)
            r = requests.post(url=(SERVER_URL + bookToken), json=token_dict)
            num_tokens += 1
print ("tokens table filled up: ",num_tokens);