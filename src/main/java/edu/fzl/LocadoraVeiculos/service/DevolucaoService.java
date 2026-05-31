package edu.fzl.LocadoraVeiculos.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import edu.fzl.LocadoraVeiculos.model.*;
import edu.fzl.LocadoraVeiculos.repository.*;

@Service
public class DevolucaoService {

    @Autowired 
    private AluguelRepository aRepo;
    
    @Autowired 
    private CarroRepository cRepo;

    @Transactional
    public Double finalizarDevolucao(String placa, int litros, boolean oficina) {
        Aluguel a = aRepo.findFirstByCarroPlacaOrderByDataRetiradaDesc(placa);
        
        if (a == null) {
            throw new IllegalArgumentException("Placa não encontrada: " + placa);
        }

        Carro c = a.getCarro();
        double valorDiarias = a.getQtdDias() * c.getCategoria().getValor();
        double taxaExtra = 0;
        String combustivel = c.getTipoCombustivel().getNome();
        
        if (litros > 0) {
            if (combustivel.toLowerCase().contains("gasolina")) {
                taxaExtra = litros * 7.00;
            } else if (combustivel.toLowerCase().contains("alcool") || combustivel.toLowerCase().contains("álcool")) {
                taxaExtra = litros * 5.50;
            }
        }


        c.setStatusVeiculo(oficina ? "OFICINA" : "DISPONIVEL");
        cRepo.save(c);

        a.setStatusAluguel("CONCLUIDO");
        a.setLitrosFaltantes((double) litros);
        aRepo.save(a);

        return valorDiarias + taxaExtra;
    }
}