package edu.fzl.LocadoraVeiculos.repository;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import edu.fzl.LocadoraVeiculos.model.Aluguel;
import edu.fzl.LocadoraVeiculos.model.AluguelDto;

@Repository
public interface AluguelRepository extends JpaRepository<Aluguel, Integer> {

    Aluguel findFirstByCarroPlacaOrderByDataRetiradaDesc(String placa);
    List<Aluguel> findByStatusAluguel(String status);
    @Query("SELECT a.id as id, " +
    		"c.placa as placa, c.marca as marca, c.modelo as modelo, " +
    		"l.cpf as cpf, l.nome as nome, " +
    		"a.dataRetirada as dataRetirada, a.qtdDias as qtdDias, a.statusAluguel as statusAluguel " +
    		"FROM Aluguel a " +
    		"JOIN a.carro c " +
    		"JOIN a.locatario l " +
    		"WHERE (:status IS NULL OR a.statusAluguel = :status)")
    	List<AluguelDto> listPorFiltro(@Param("status") String status);
}