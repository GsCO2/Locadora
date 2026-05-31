package edu.fzl.LocadoraVeiculos.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import edu.fzl.LocadoraVeiculos.model.Reparo;

@Repository
public interface ReparoRepository extends JpaRepository<Reparo, Integer> {
}