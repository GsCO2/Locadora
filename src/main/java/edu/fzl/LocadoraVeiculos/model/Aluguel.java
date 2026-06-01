package edu.fzl.LocadoraVeiculos.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "aluguel")
public class Aluguel {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "placa_carro", nullable = false)
	private Carro carro;

	@ManyToOne
	@JoinColumn(name = "cpf_locatario", nullable = false)
	private Locatario locatario;

	@Column(name = "data_retirada")
	private LocalDate dataRetirada;

	@Column(name = "qtd_dias")
	private int qtdDias;

	@Column(name = "status_aluguel")
	private String statusAluguel = "ATIVO";

	@Column(name = "tanque_cheio")
	private boolean tanqueCheio;

	@Column(name = "litros_faltantes")
	private Double litrosFaltantes;

	public String getStatusAluguel() {
		return statusAluguel;
	}

	public void setStatusAluguel(String statusAluguel) {
		this.statusAluguel = statusAluguel;
	}
}