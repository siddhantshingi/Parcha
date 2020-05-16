# Token System Test Data Generation

## Using the script

```console
>>> python generate.py
```

The script generates 20 users and 40 shops per pincode, with each pincode being monitored by one localAuth.  
Each user gets 5 tokens and slots are generated for each shop for today, yesterday and tomorrow.  

## Parameters

Data Generation Parameters:  
1. start\_user: Start user name from this number  
2. start\_user\_id: The created users in the database should start from this number. For example, if the present users in the database have id till 200, then this should be set at 201.  
3. start\_auth: Start authority name from this number  
4. start\_shop: Start shop name from this number  
5. start\_shop\_id: The created shop objects in the database should start from this number (Similar to start\_user\_id above).  

Number of data objects to be generated:  
1. num\_pincodes: Number of pincodes, for which data is to be added. (default: 2)  
2. shops\_per\_pin: Number of shops per pincode  
3. users\_per\_pin: Number of users per pincode  
4. tokens\_per\_user: Number of tokens to be generated per user. (default: 5)

