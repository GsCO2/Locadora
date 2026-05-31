package edu.fzl.LocadoraVeiculos.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import edu.fzl.LocadoraVeiculos.model.TipoCombustivel;

public interface TipoCombustivelRepository extends JpaRepository<TipoCombustivel, Integer> { 
}