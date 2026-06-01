package edu.fzl.LocadoraVeiculos.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import edu.fzl.LocadoraVeiculos.model.Locatario;

@Repository
public interface LocatarioRepository extends JpaRepository<Locatario, String> {
}