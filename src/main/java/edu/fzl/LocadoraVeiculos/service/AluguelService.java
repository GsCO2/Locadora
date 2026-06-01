package edu.fzl.LocadoraVeiculos.service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import edu.fzl.LocadoraVeiculos.model.Aluguel;
import edu.fzl.LocadoraVeiculos.model.AluguelDto;
import edu.fzl.LocadoraVeiculos.model.Carro;
import edu.fzl.LocadoraVeiculos.repository.AluguelRepository;
import edu.fzl.LocadoraVeiculos.repository.CarroRepository;

@Service
public class AluguelService {

    @Autowired 
    private AluguelRepository aRepo;
    
    @Autowired 
    private CarroRepository cRepo;

    @Transactional
    public void registrarLocacao(Aluguel a) {
        aRepo.save(a);
        Carro c = a.getCarro();
        c.setStatusVeiculo("ALUGADO");
        cRepo.save(c);
    }

    @Transactional
    public void excluirLocacao(int idAluguel) {
        Aluguel a = aRepo.findById(idAluguel).orElse(null);
        if (a != null) {
            Carro c = a.getCarro();
            c.setStatusVeiculo("DISPONIVEL");
            cRepo.save(c);
            aRepo.delete(a);
        }
    }

    public List<Aluguel> listarTodos() {
        return aRepo.findAll();
    }
    
    public List<AluguelDto> listarLocacoes(String status) {
        return aRepo.listPorFiltro(status);
    }
}