package edu.fzl.LocadoraVeiculos.model;

import java.time.LocalDate;

public interface  AluguelDto {
	String getPlaca();
    String getMarca();
    String getModelo();
    String getCpf();
    String getNome();
    Integer getId();
    LocalDate getDataRetirada();
    Integer getQtdDias();
    String getStatusAluguel();
}
