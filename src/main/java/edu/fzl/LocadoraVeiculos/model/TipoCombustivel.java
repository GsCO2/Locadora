package edu.fzl.LocadoraVeiculos.model;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "tipo_combustivel")
public class TipoCombustivel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "nome", length = 20, nullable = false)
    private String nome;

    @Column(name = "valor_litro_extra", nullable = false)
    private Double valorLitroExtra; 
}