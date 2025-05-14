package tech.chilo.sa.service;

import jakarta.persistence.EntityNotFoundException;
import jakarta.validation.Valid;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import tech.chilo.sa.entites.Client;
import tech.chilo.sa.repository.ClientRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Validated
public class ClientService {

    private ClientRepository clientRepository;
    private EmailService emailService;

    public ClientService(ClientRepository clientRepository, EmailService emailService) {
        this.clientRepository = clientRepository;
        this.emailService = emailService;
    }

    public void creer(@Valid Client client) {
        //TODO recuperer le client en base
        Client clientEnBD = this.clientRepository.findByEmail(client.getEmail());

        if (clientEnBD == null) {
            // System.out.println(client.getEmail());
            this.clientRepository.save(client);
            //TODO envoyer un email de verification au client
            this.emailService.sendEmail(client.getEmail(), "sa Inscription client", "no-replay : ce message a ete envoye par SA ");
        }

    }

    public List<Client> rechercher() {
        return  this.clientRepository.findAll();
    }

    public Client lire(UUID id) {
        Optional<Client> optionalClient = this.clientRepository.findById(id);

        return  optionalClient.orElseThrow(() -> new EntityNotFoundException("Aucun element correspond à votre recherche. Votre objet n'existe pas"));

        // if (optionalClient.isPresent()) {
        //     return optionalClient.get();
        // }
        // else {
        //     return null;
        // }
    }

    public Client lireOuCreer(@Valid Client client) {
        Client clientEnBD = this.clientRepository.findByEmail(client.getEmail());

        if (clientEnBD == null) {
            // System.out.println(client.getEmail());
            clientEnBD = this.clientRepository.save(client);

            //TODO envoyer un email de verification au client
            this.emailService.sendEmail(client.getEmail(), "sa Inscription client", "no-replay : ce message a ete envoye par SA ");


        }

        return clientEnBD;
    }

    public void modifier(UUID id, Client client) {

        Client clientEnBd = this.lire(id);

        if (clientEnBd.getId() == client.getId()) {
            clientEnBd.setEmail(client.getEmail());
            clientEnBd.setTelephone(client.getTelephone());
            this.clientRepository.save(clientEnBd);

        }
    }

    public void supprimer(UUID id) {

        this.clientRepository.deleteById(id);
    }
}
