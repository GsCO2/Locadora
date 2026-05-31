package edu.fzl.LocadoraVeiculos.model;

import jakarta.persistence.*;
import lombok.*; // Import do Lombok

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name = "tipo_cambio")
public class TipoCambio {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "descricao", length = 20, nullable = false)
    private String descricao;
}