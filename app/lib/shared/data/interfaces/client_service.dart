import 'package:image_picker/image_picker.dart';
import '../../domain/client.dart';

abstract class ClientService {
  Future<List<Client>> getClients();
  Future<Client?> getClientById(int id);
  Future<void> createClient(Client client);
  Future<void> updateClient(Client client);
  Future<void> deleteClient(int id);
  Stream<List<Client>> watchClients();
  Stream<Client?> watchClientById(int id);
  Future<String> saveAvatar(XFile file);
}
