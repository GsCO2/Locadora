package edu.fzl.LocadoraVeiculos.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import edu.fzl.LocadoraVeiculos.model.Carro;

public interface CarroRepository extends JpaRepository<Carro, String> {
    List<Carro> findByStatusVeiculoIgnoreCase(String statusVeiculo);

}