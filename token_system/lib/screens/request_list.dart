import 'package:token_system/Entities/request.dart';

List<Request> requests = [
  Request(
      shopId: 0,
      openTime: '11:00',
      closeTime: '16:00',
      maxCapacity: 5,
      duration: '15 mins',
      bufferTime: '5 mins',
      status: 0,
      timestamp: '14 May'),
  Request(
      shopId: 0,
      openTime: '11:00',
      closeTime: '18:00',
      maxCapacity: 5,
      duration: '15 mins',
      bufferTime: '5 mins',
      status: 1,
      timestamp: '14 May'),
  Request(
      shopId: 0,
      openTime: '11:00',
      closeTime: '18:00',
      maxCapacity: 10,
      duration: '30 mins',
      bufferTime: '10 mins',
      status: 1,
      timestamp: '15 May'),
  Request(
      shopId: 0,
      openTime: '11:00',
      closeTime: '20:00',
      maxCapacity: 15,
      duration: '30 mins',
      bufferTime: '10 mins',
      status: 2,
      timestamp: '15 May'),
];
