package edu.fzl.LocadoraVeiculos.repository;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import edu.fzl.LocadoraVeiculos.model.Aluguel;

@Repository
public interface AluguelRepository extends JpaRepository<Aluguel, Integer> {

    Aluguel findFirstByCarroPlacaOrderByDataRetiradaDesc(String placa);
    List<Aluguel> findByStatusAluguel(String status);
}