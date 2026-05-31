package edu.fzl.LocadoraVeiculos.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import edu.fzl.LocadoraVeiculos.model.TipoCambio;

public interface TipoCambioRepository extends JpaRepository<TipoCambio, Integer> { 
}