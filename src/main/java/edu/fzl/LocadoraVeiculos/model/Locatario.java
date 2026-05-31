package edu.fzl.LocadoraVeiculos.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "locatario")
public class Locatario {

    @Id
    @Column(name = "cpf", length = 11, nullable = false)
    private String cpf;

    @Column(name = "nome", length = 100, nullable = false)
    private String nome;

    @Column(name = "num_habilitacao", length = 20, nullable = false)
    private String numeroHabilitacao;

    @Column(name = "data_nascimento", nullable = false)
    private LocalDate dataNascimento;

    @Column(name = "logradouro", length = 100)
    private String logradouro;

    @Column(name = "numero")
    private int numero;

    @Column(name = "cep", length = 8)
    private String cep;

    @Column(name = "cidade", length = 50)
    private String cidade;
}