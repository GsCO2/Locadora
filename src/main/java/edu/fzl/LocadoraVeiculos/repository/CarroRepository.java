package edu.fzl.LocadoraVeiculos.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import edu.fzl.LocadoraVeiculos.model.Carro;
import edu.fzl.LocadoraVeiculos.model.CarrosDispDto;

@Repository
public interface CarroRepository extends JpaRepository<Carro, String> {
    List<Carro> findByStatusVeiculoIgnoreCase(String statusVeiculo);
    @Query(value = "SELECT * FROM dbo.fn_carroDisp()", nativeQuery = true)
    List<CarrosDispDto> listarDisponiveis();
    @Query(value = "SELECT * FROM dbo.fn_carroDispComFiltro(:idCategoria)", nativeQuery = true)
    List<CarrosDispDto> findDisponiveisPorCategoria(@Param("idCategoria") Integer idCategoria);
}