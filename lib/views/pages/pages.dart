import 'dart:io';
import 'dart:async';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depoto/services/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:depoto/models/models.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../main.dart';

part 'mainMenu.dart';

part 'survei.dart';

part 'containerDetails.dart';

part 'cameraScreen.dart';

part 'cameraView.dart';

part 'surveiList.dart';

part 'cardView/details.dart';
part 'cardView/cardView.dart';

part '../pages/cardView/changeDetailView.dart';
part 'splash.dart';
part 'cameraChangeDetails.dart';