import '../models/profile_model.dart';

class ProfileViewModel {
  ProfileModel getProfile() {
    return ProfileModel(
      fullName: "Ahmed Ben Ameur",
      email: "ahmed.benameur@supcom.tn",
      phone: "+216 55 181 294",
      address: "Cité El Ghazala, Ariana 2083",
      birthDate: "15 Mars 2003",
      studentId: "2023-012345",
      major: "Ingénieur en Télécommunications",
      academicYear: "2023-2024",
      group: "2A-G2",
      gpa: "13.00",
      credits: "156",
      yearLevel: "2ème",
    );
  }
}
