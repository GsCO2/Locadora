package edu.fzl.LocadoraVeiculos.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import edu.fzl.LocadoraVeiculos.model.Locatario;

public interface LocatarioRepository extends JpaRepository<Locatario, String> {
}