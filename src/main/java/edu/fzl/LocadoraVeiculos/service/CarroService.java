package edu.fzl.LocadoraVeiculos.service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import edu.fzl.LocadoraVeiculos.model.Carro;
import edu.fzl.LocadoraVeiculos.model.CarrosDispDto;
import edu.fzl.LocadoraVeiculos.model.TipoCambio;
import edu.fzl.LocadoraVeiculos.model.TipoCombustivel;
import edu.fzl.LocadoraVeiculos.repository.CarroRepository;
import edu.fzl.LocadoraVeiculos.repository.TipoCambioRepository;
import edu.fzl.LocadoraVeiculos.repository.TipoCombustivelRepository;

@Service
public class CarroService {
    @Autowired 
    private CarroRepository cRep;
    @Autowired 
    private TipoCambioRepository cambioRep;
    @Autowired 
    private TipoCombustivelRepository combRep;
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
    
    public List<CarrosDispDto> listarDisponiveis(){
    	return cRep.listarDisponiveis();
    }
    
    public List<TipoCambio> listarCambios(){
    	return cambioRep.findAll();
    }
    
    public List<TipoCombustivel> listarCombustiveis(){
    	return combRep.findAll();
    }
    
    public List<CarrosDispDto> listaPorCategoria(int idCategoria){
    	return cRep.findDisponiveisPorCategoria(idCategoria);
    }
}