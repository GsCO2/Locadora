package edu.fzl.LocadoraVeiculos.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import edu.fzl.LocadoraVeiculos.model.Reparo;
import edu.fzl.LocadoraVeiculos.model.Carro;
import edu.fzl.LocadoraVeiculos.repository.ReparoRepository;
import edu.fzl.LocadoraVeiculos.repository.CarroRepository;

@Service
public class ReparoService {

    @Autowired private ReparoRepository rRepo;
    @Autowired private CarroRepository cRepo;

    @Transactional
    public void registrarReparo(Reparo reparo) {
        rRepo.save(reparo);
        Carro carro = reparo.getCarro();
        if (!carro.getStatusVeiculo().equalsIgnoreCase("OFICINA")) {
            carro.setStatusVeiculo("OFICINA");
            cRepo.save(carro);
        }
    }

    @Transactional
    public void finalizarReparo(int idReparo) {
        Reparo r = rRepo.findById(idReparo).orElse(null);
        if (r != null) {
            Carro c = r.getCarro();
            c.setStatusVeiculo("DISPONIVEL");
            cRepo.save(c);
            rRepo.delete(r);
        }
    }

    public List<Reparo> listarTodos() {
        return rRepo.findAll();
    }
}