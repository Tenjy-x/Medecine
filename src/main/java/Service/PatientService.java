package Service;

import Repository.PatientRepository;

import java.util.List;

import Model.Patient;
public class PatientService {
    private final PatientRepository patientRepository;

    public PatientService(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }

    public void save(Patient p) {
        patientRepository.save(p);
    }

    public List<Patient> findAll() {
        return patientRepository.findAll();
    }

    public Patient findById(Integer id) {
        return patientRepository.findById(id).orElse(null);
    }

    public void deleteById(Integer id) {
        patientRepository.deleteById(id);
    }
}
