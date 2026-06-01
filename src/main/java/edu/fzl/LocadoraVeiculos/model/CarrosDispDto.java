package edu.fzl.LocadoraVeiculos.model;

import java.math.BigDecimal;

public interface CarrosDispDto {
	String getPlaca();

    String getCategoria();

    String getMarca();

    String getModelo();

    Integer getAno();

    String getCombustivel();

    String getCambio();

    BigDecimal getDiaria();
}
