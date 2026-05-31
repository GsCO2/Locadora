package edu.fzl.LocadoraVeiculos.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "reparo")
public class Reparo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "placa_carro", nullable = false)
    private Carro carro;

    @Column(name = "data_entrada", nullable = false)
    private LocalDate dataEntrada;

    @Column(name = "prazo_dias", nullable = false)
    private int prazoDias;

    @Column(name = "descricao", length = 255)
    private String descricao;

    @Column(name = "valor_reparo", columnDefinition = "DECIMAL(10,2)")
    private Double valorReparo;
}