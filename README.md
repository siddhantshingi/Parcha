# Parcha
Token based application to ensure social distancing at market place or grocery shops

## Concept
Amid the lockdown situation caused due to the COVID-19 outbreak, many local authorities have allowed the market (mainly for essential commodities) to be open for a restricted period of time. Despite awareness drives and police intervention, the marketplaces or grocery shops in the city continue to remain crowded with people in the allowed time. The media has reported several such cases. The best solution in such cases appears to be **direct-to-door delivery**.  

While direct-to-door delivery in western countries is comparatively easy because of a few reasons such as the existence of zip postal codes, technology, structure/architecture/town plan of the cities, government databases of households, etc. The last-mile distribution in India is particularly complicated. Even if the direct-to-door delivery is made possible in India, it will be helpful only in the lockdown period. When the lockdown is removed and the country starts to go back to its normal pace, there will again be large amounts of violations of social distancing at essential shops.

There is a need for a system that **controls the number of customers** at essential shops at a given time. We propose a token-based application in which people need to request for a token to visit a shop. This token shallbe valid only for that shop and for a particular time slotas chosen by the user. The distribution of these tokens will be restricted such that there is no crowding at the shops. The user is allowed to buy from a shop only if his/her token is activated. The token expires after a period of time.

## Demo
Checkout our demo video on YouTube [here](https://www.youtube.com/watch?v=SgupLSuz5rc).

## Critical Aspects
1. **Minimally Online Application**: In India, where good internet connectivity is not available at all places and not available for all people, we need an application which is as minimally online as possible. We need to make most operations offline. As a start, we have implemented Offline Verification in Parcha. For more details, check README of token-system.  
2. **Authority Intervention**: As we go through various phases of un-lockdown, various rules and regulations shall be set in place by the local administration and monitoring whether shops and marketplaces are adhering to the norms is important. We implement this by an Authority feature set, to approve the shops to be opened and to track their opening and closing times.

## Workflow
![Workflow for the Application](Workflow.png)

## Development
The backend for the application has been developed in NodeJS, with the data being stored in a MySQL Database. For the user application, Flutter has been used to develop native application for Android and iOS Devices.

## Documentation
Go to the READMEs of the individual directories of Backend/ and token_system/  
The API calls are located in the Backend/ directory  
The Flutter app is located in the token_system/ directory  

## Contributing
Feel free to contribute in the following ways:
1. Raise an issue on our Repo [here](https://github.com/siddhantshingi/Parcha/issues).  
2. Fork the repo, make changes and raise a PR. Information [here](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request)  
3. Contact any of the authors below.

## Authors
+ [Siddhant Shingi](https://github.com/siddhantshingi)
+ [Divyanshu Saxena](https://github.com/DivyanshuSaxena)
+ [Srijan Sinha](https://github.com/srijan-sinha)
+ [Akshay Neema](https://github.com/akshayneema)
+ [Akshat Khare](https://github.com/akshat-khare)
