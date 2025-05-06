package tech.chilo.sa.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import tech.chilo.sa.entites.Client;

public interface ClientRepository extends JpaRepository<Client, Integer> {

    Client findByEmail(String email);

}