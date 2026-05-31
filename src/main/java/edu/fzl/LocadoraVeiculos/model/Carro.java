package edu.fzl.LocadoraVeiculos.model;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "carro")
public class Carro {

	@Id
	@Column(name = "placa", length = 7)
	private String placa;

	@Column(name = "marca", length = 30, nullable = false)
	private String marca;

	@Column(name = "modelo", length = 30, nullable = false)
	private String modelo;

	@Column(name = "cor", length = 20, nullable = false)
	private String cor;

	@Column(name = "ano", nullable = false)
	private int ano;

	@Column(name = "quilometragem", nullable = false)
	private int quilometragem;

	@Column(name = "status_veiculo")
	private String statusVeiculo = "DISPONIVEL";

	@ManyToOne
	@JoinColumn(name = "id_categoria", nullable = false)
	private Categoria categoria;

	@ManyToOne
	@JoinColumn(name = "id_cambio", nullable = false)
	private TipoCambio tipoCambio;

	@ManyToOne
	@JoinColumn(name = "id_combustivel", nullable = false)
	private TipoCombustivel tipoCombustivel;

	public String getStatusVeiculo() {
		return statusVeiculo;
	}

	public void setStatusVeiculo(String statusVeiculo) {
		this.statusVeiculo = statusVeiculo;
	}

	public String getStatus() {
		return statusVeiculo;
	}

	public void setStatus(String status) {
		this.statusVeiculo = status;
	}
}