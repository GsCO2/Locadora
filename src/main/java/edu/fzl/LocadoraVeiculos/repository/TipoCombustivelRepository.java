package edu.fzl.LocadoraVeiculos.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import edu.fzl.LocadoraVeiculos.model.TipoCombustivel;

@Repository
public interface TipoCombustivelRepository extends JpaRepository<TipoCombustivel, Integer> { 
}