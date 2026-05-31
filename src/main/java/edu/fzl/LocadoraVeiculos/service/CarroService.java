package edu.fzl.LocadoraVeiculos.service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import edu.fzl.LocadoraVeiculos.model.Carro;
import edu.fzl.LocadoraVeiculos.repository.CarroRepository;

@Service
public class CarroService {
    @Autowired 
    private CarroRepository cRep;
    
    public void salvar(Carro c) { 
    	cRep.save(c); 
    }
    
    public List<Carro> listar() {
    	return cRep.findAll(); 
    }
    
    public Carro buscar(String placa) { 
    	return cRep.findById(placa).orElse(null); 
    }
    
    public void excluir(String placa) { 
    	cRep.deleteById(placa); 
    }
    
    public List<Carro> listarPorStatus(String status) {
        return cRep.findByStatusVeiculoIgnoreCase(status);
    }
}