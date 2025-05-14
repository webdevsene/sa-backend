package tech.chilo.sa.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import tech.chilo.sa.entites.Client;

import java.util.UUID;

public interface ClientRepository extends JpaRepository<Client, UUID> {

    Client findByEmail(String email);

}