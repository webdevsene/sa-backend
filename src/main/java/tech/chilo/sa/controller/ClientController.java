package tech.chilo.sa.controller;

import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import tech.chilo.sa.entites.Client;
import tech.chilo.sa.service.ClientService;
import tech.chilo.sa.service.EmailService;

import java.util.List;

@RestController
@RequestMapping(path = "client")
@CrossOrigin(origins = "http://localhost:3000", allowCredentials = "true", maxAge = 3600)
public class ClientController {
    private ClientService clientService;

    private EmailService emailService;

    public ClientController(ClientService clientService, EmailService emailService) {
        this.clientService = clientService;
        this.emailService = emailService;
    }

    @ResponseStatus(value = HttpStatus.CREATED)
    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    public void creer(@Valid @RequestBody Client client) {
        this.clientService.creer(client);
        this.emailService.sendEmail(client.getEmail(), "sa inscription client", "no-replay : ce message a ete envoye par SA ");

    }

    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Client> rechercher() {
        return  this.clientService.rechercher();
    }

    @GetMapping(path = "{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public Client lire(@PathVariable int id) {
        return  this.clientService.lire(id);
    }

    @ResponseStatus(value = HttpStatus.NO_CONTENT)
    @PutMapping(path = "{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public void modifier(@PathVariable int id, @Valid @RequestBody Client client) {
        this.clientService.modifier(id, client);
    }
}
