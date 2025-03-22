import 'package:hive_flutter/hive_flutter.dart';
import 'package:photoapp/models/booking.dart';
import 'package:photoapp/models/photobooth.dart';
import 'package:photoapp/models/party_cart.dart';
import 'package:photoapp/models/three_sixty.dart';
import 'package:photoapp/models/magazine.dart';

class DatabaseService {
  static const String _bookingBox = 'bookings';
  static const String _photoboothBox = 'photobooths';
  static const String _partyCartBox = 'party_carts';
  static const String _threeSixtyBox = 'three_sixty';
  static const String _magazineBox = 'magazines';

  static Box<Booking>? _bookingBoxInstance;
  static Box<Photobooth>? _photoboothBoxInstance;
  static Box<PartyCart>? _partyCartBoxInstance;
  static Box<ThreeSixty>? _threeSixtyBoxInstance;
  static Box<Magazine>? _magazineBoxInstance;

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter<Booking>(BookingAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter<Photobooth>(PhotoboothAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter<PartyCart>(PartyCartAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter<ThreeSixty>(ThreeSixtyAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter<Magazine>(MagazineAdapter());
    }

    await Future.wait([
      Hive.openBox<Booking>(_bookingBox),
      Hive.openBox<Photobooth>(_photoboothBox),
      Hive.openBox<PartyCart>(_partyCartBox),
      Hive.openBox<ThreeSixty>(_threeSixtyBox),
      Hive.openBox<Magazine>(_magazineBox),
    ]);

    _bookingBoxInstance = Hive.box<Booking>(_bookingBox);
    _photoboothBoxInstance = Hive.box<Photobooth>(_photoboothBox);
    _partyCartBoxInstance = Hive.box<PartyCart>(_partyCartBox);
    _threeSixtyBoxInstance = Hive.box<ThreeSixty>(_threeSixtyBox);
    _magazineBoxInstance = Hive.box<Magazine>(_magazineBox);
  }

  static void printDatabaseContents() {
    print('\n=== Database Contents ===');
    print('\nBookings:');
    _bookingBoxInstance?.values.forEach((booking) {
      print('ID: ${booking.bookingId}');
      print('Customer: ${booking.customerName}');
      print('Service: ${booking.serviceName}');
      print('Package: ${booking.packageName}');
      print('Price: ${booking.price}');
      print('Schedule: ${booking.schedule}');
      print('Location: ${booking.location}');
      print('Phone: ${booking.phoneNumber}');
      print('-------------------');
    });

    print('\nPhotobooths:');
    _photoboothBoxInstance?.values.forEach((photobooth) {
      print('ID: ${photobooth.photoboothId}');
      print('Booking ID: ${photobooth.bookingId}');
      print('Date: ${photobooth.dateTime}');
      print('Phone: ${photobooth.phoneNumber}');
      print('-------------------');
    });

    print('\nParty Carts:');
    _partyCartBoxInstance?.values.forEach((partyCart) {
      print('ID: ${partyCart.partyCartId}');
      print('Booking ID: ${partyCart.bookingId}');
      print('Date: ${partyCart.dateTime}');
      print('Phone: ${partyCart.phoneNumber}');
      print('-------------------');
    });

    print('\n360 Videos:');
    _threeSixtyBoxInstance?.values.forEach((threeSixty) {
      print('ID: ${threeSixty.threesixtyId}');
      print('Booking ID: ${threeSixty.bookingId}');
      print('Date: ${threeSixty.dateTime}');
      print('Phone: ${threeSixty.phoneNumber}');
      print('-------------------');
    });

    print('\nMagazines:');
    _magazineBoxInstance?.values.forEach((magazine) {
      print('ID: ${magazine.magazineId}');
      print('Booking ID: ${magazine.bookingId}');
      print('Date: ${magazine.dateTime}');
      print('Phone: ${magazine.phoneNumber}');
      print('-------------------');
    });
  }

  static Future<void> addBooking(Booking booking) async {
    final box = Hive.box<Booking>(_bookingBox);
    await box.put(booking.bookingId, booking);
  }

  static Future<void> updateBooking(Booking booking) async {
    final box = Hive.box<Booking>(_bookingBox);
    await box.put(booking.bookingId, booking);
  }

  static Future<void> deleteBooking(String bookingId) async {
    final box = Hive.box<Booking>(_bookingBox);
    await box.delete(bookingId);
  }

  static Booking? getBooking(String bookingId) {
    final box = Hive.box<Booking>(_bookingBox);
    return box.get(bookingId);
  }

  static List<Booking> getAllBookings() {
    final box = Hive.box<Booking>(_bookingBox);
    return box.values.toList();
  }

  static Future<void> addPhotobooth(Photobooth photobooth) async {
    final box = Hive.box<Photobooth>(_photoboothBox);
    await box.put(photobooth.photoboothId, photobooth);
  }

  static Future<void> updatePhotobooth(Photobooth photobooth) async {
    final box = Hive.box<Photobooth>(_photoboothBox);
    await box.put(photobooth.photoboothId, photobooth);
  }

  static Future<void> deletePhotobooth(String photoboothId) async {
    final box = Hive.box<Photobooth>(_photoboothBox);
    await box.delete(photoboothId);
  }

  static Photobooth? getPhotobooth(String photoboothId) {
    final box = Hive.box<Photobooth>(_photoboothBox);
    return box.get(photoboothId);
  }

  static List<Photobooth> getAllPhotobooths() {
    final box = Hive.box<Photobooth>(_photoboothBox);
    return box.values.toList();
  }

  static Future<void> addPartyCart(PartyCart partyCart) async {
    final box = Hive.box<PartyCart>(_partyCartBox);
    await box.put(partyCart.partyCartId, partyCart);
  }

  static Future<void> updatePartyCart(PartyCart partyCart) async {
    final box = Hive.box<PartyCart>(_partyCartBox);
    await box.put(partyCart.partyCartId, partyCart);
  }

  static Future<void> deletePartyCart(String partyCartId) async {
    final box = Hive.box<PartyCart>(_partyCartBox);
    await box.delete(partyCartId);
  }

  static PartyCart? getPartyCart(String partyCartId) {
    final box = Hive.box<PartyCart>(_partyCartBox);
    return box.get(partyCartId);
  }

  static List<PartyCart> getAllPartyCarts() {
    final box = Hive.box<PartyCart>(_partyCartBox);
    return box.values.toList();
  }

  static Future<void> addThreeSixty(ThreeSixty threeSixty) async {
    final box = Hive.box<ThreeSixty>(_threeSixtyBox);
    await box.put(threeSixty.threesixtyId, threeSixty);
  }

  static Future<void> updateThreeSixty(ThreeSixty threeSixty) async {
    final box = Hive.box<ThreeSixty>(_threeSixtyBox);
    await box.put(threeSixty.threesixtyId, threeSixty);
  }

  static Future<void> deleteThreeSixty(String threeSixtyId) async {
    final box = Hive.box<ThreeSixty>(_threeSixtyBox);
    await box.delete(threeSixtyId);
  }

  static ThreeSixty? getThreeSixty(String threeSixtyId) {
    final box = Hive.box<ThreeSixty>(_threeSixtyBox);
    return box.get(threeSixtyId);
  }

  static List<ThreeSixty> getAllThreeSixty() {
    final box = Hive.box<ThreeSixty>(_threeSixtyBox);
    return box.values.toList();
  }

  static Future<void> addMagazine(Magazine magazine) async {
    final box = Hive.box<Magazine>(_magazineBox);
    await box.put(magazine.magazineId, magazine);
  }

  static Future<void> updateMagazine(Magazine magazine) async {
    final box = Hive.box<Magazine>(_magazineBox);
    await box.put(magazine.magazineId, magazine);
  }

  static Future<void> deleteMagazine(String magazineId) async {
    final box = Hive.box<Magazine>(_magazineBox);
    await box.delete(magazineId);
  }

  static Magazine? getMagazine(String magazineId) {
    final box = Hive.box<Magazine>(_magazineBox);
    return box.get(magazineId);
  }

  static List<Magazine> getAllMagazines() {
    final box = Hive.box<Magazine>(_magazineBox);
    return box.values.toList();
  }

  static Future<void> closeBoxes() async {
    await Future.wait([
      Hive.box<Booking>(_bookingBox).close(),
      Hive.box<Photobooth>(_photoboothBox).close(),
      Hive.box<PartyCart>(_partyCartBox).close(),
      Hive.box<ThreeSixty>(_threeSixtyBox).close(),
      Hive.box<Magazine>(_magazineBox).close(),
    ]);
  }
}
