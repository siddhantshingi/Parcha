import 'package:token_system/Entities/request.dart';

List<Request> requests = [
  Request(
      shopId: 0,
      openTime: '11:00',
      closeTime: '16:00',
      capacity: 5,
      slotDuration: '15 mins',
      bufferDuration: '5 mins',
      status: 0,
      time: '14 May'),
  Request(
      shopId: 0,
      openTime: '11:00',
      closeTime: '18:00',
      capacity: 5,
      slotDuration: '15 mins',
      bufferDuration: '5 mins',
      status: 1,
      time: '14 May'),
  Request(
      shopId: 0,
      openTime: '11:00',
      closeTime: '18:00',
      capacity: 10,
      slotDuration: '30 mins',
      bufferDuration: '10 mins',
      status: 1,
      time: '15 May'),
  Request(
      shopId: 0,
      openTime: '11:00',
      closeTime: '20:00',
      capacity: 15,
      slotDuration: '30 mins',
      bufferDuration: '10 mins',
      status: 2,
      time: '15 May'),
];
