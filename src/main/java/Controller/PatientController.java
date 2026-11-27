package Controller;

import Config.JpaConfig;
import Model.Patient;
import Repository.PatientRepository;
import Service.PatientService;
import Tendry.Annotation.AnnotationController;
import Tendry.Annotation.UrlMapping;
import Tendry.Annotation.Webapi;
import Tendry.Web.ModelAndView;
import java.util.List;
import static Tendry.Web.ModelAndView.redirect;



@AnnotationController
public class PatientController {
    private final PatientService patientService;

    public PatientController() {
        this.patientService = new PatientService(JpaConfig.getBean(PatientRepository.class));
    }

    @UrlMapping(path = "/")
    public ModelAndView accueil() {
        return redirect("/patients");
    }

    @UrlMapping(path = "/patients")
    public ModelAndView liste() {
        ModelAndView mv = new ModelAndView("patient/list");
        List<Patient> patients = patientService.findAll();
        mv.setAttribute("patients", patients);
        return mv;
    }

    @UrlMapping(path = "/patients/api")
    @Webapi
    public List<Patient> listeapi() {
        List<Patient> patients = patientService.findAll();
        return patients;
    }

    // ---------- Create ----------
    @UrlMapping(path = "/patients/create")
    public ModelAndView createForm() {
        ModelAndView mv = new ModelAndView("patient/form");
        return mv;
    }

    @UrlMapping(path = "/patients/create", method = "POST")
    public ModelAndView create(Patient patient) {
        patientService.save(patient);
        return redirect("/patients");
    }

    // ---------- Update ----------
    @UrlMapping(path = "/patients/update")
    public ModelAndView updateForm(Integer id) {
        ModelAndView mv = new ModelAndView("patient/form");
        Patient patient = patientService.findById(id);
        mv.setAttribute("patient", patient);
        return mv;
    }

    @UrlMapping(path = "/patients/update", method = "POST")
    public ModelAndView update(Patient patient) {
        patientService.save(patient);
        return redirect("/patients");
    }

    // ---------- Delete ----------
    @UrlMapping(path = "/patients/delete", method = "POST")
    public ModelAndView delete(Integer id) {
        patientService.deleteById(id);
        return redirect("/patients");
    }

    @UrlMapping(path = "/patients/{id}") 
    public  ModelAndView fiche(Integer id) {
        ModelAndView mv = new ModelAndView("patient/detail");
        Patient p = patientService.findById(id);
        mv.setAttribute("patient", p);
        return mv;
    }
}
