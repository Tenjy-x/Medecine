package Config;

import jakarta.persistence.EntityManagerFactory;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

/**
 * Démarre Spring Data JPA sans Spring MVC (MY_FRAMEWORK gère le web).
 * Les interfaces du package "Repository" (ex : PatientRepository) sont
 * implémentées automatiquement par Spring.
 *
 * Utilisation : PatientRepository repo = JpaConfig.getBean(PatientRepository.class);
 */
@Configuration
@PropertySource("classpath:db.properties")
@EnableJpaRepositories(basePackages = "Repository")
@EnableTransactionManagement
public class JpaConfig {

    // Contexte Spring créé une seule fois pour toute l'application
    private static AnnotationConfigApplicationContext context;

    public static synchronized <T> T getBean(Class<T> type) {
        if (context == null) {
            context = new AnnotationConfigApplicationContext(JpaConfig.class);
        }
        return context.getBean(type);
    }

    @Bean
    public DataSource dataSource(Environment env) {
        DriverManagerDataSource ds = new DriverManagerDataSource();
        ds.setDriverClassName(env.getProperty("db.driver"));
        ds.setUrl(env.getProperty("db.url"));
        ds.setUsername(env.getProperty("db.user"));
        ds.setPassword(env.getProperty("db.password"));
        return ds;
    }

    @Bean
    public LocalContainerEntityManagerFactoryBean entityManagerFactory(DataSource dataSource) {
        LocalContainerEntityManagerFactoryBean emf = new LocalContainerEntityManagerFactoryBean();
        emf.setDataSource(dataSource);
        emf.setPackagesToScan("Model"); // entités @Entity
        emf.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        return emf;
    }

    @Bean
    public PlatformTransactionManager transactionManager(EntityManagerFactory emf) {
        return new JpaTransactionManager(emf);
    }
}
