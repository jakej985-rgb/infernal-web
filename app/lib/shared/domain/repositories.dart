import 'client.dart';
import 'appointment.dart';
import 'inventory.dart';
import 'communication.dart';
import 'document.dart';

abstract class ClientRepository {
  Stream<List<Client>> watchAll();
  Stream<Client?> watchById(int id);
  Future<List<Client>> getUnsynced();
  Future<void> save(Client client);
  Future<void> saveFromSync(Client client);
  Future<void> delete(int id);
  Future<String?> getSyncId(int localId);
  Future<int?> getLocalId(String syncId);
}

abstract class AppointmentRepository {
  Stream<List<Appointment>> watchAll();
  Stream<Appointment?> watchById(int id);
  Future<List<Appointment>> getUnsynced();
  Future<void> save(Appointment appointment);
  Future<void> saveFromSync(Appointment appointment);
  Future<void> delete(int id);
}

abstract class InventoryRepository {
  Stream<List<InventoryItem>> watchAll();
  Future<List<InventoryItem>> getUnsynced();
  Future<void> save(InventoryItem item);
  Future<void> saveFromSync(InventoryItem item);
  Future<void> delete(int id);
}

abstract class CommunicationRepository {
  Stream<List<CommunicationRitual>> watchAll();
  Future<List<CommunicationRitual>> getUnsynced();
  Future<void> save(CommunicationRitual comm);
  Future<void> saveFromSync(CommunicationRitual comm);
  Future<void> delete(int id);
}

abstract class DocumentRepository {
  Stream<List<Document>> watchAll();
  Future<List<Document>> getUnsynced();
  Future<void> save(Document doc);
  Future<void> saveFromSync(Document doc);
  Future<void> delete(int id);
}
