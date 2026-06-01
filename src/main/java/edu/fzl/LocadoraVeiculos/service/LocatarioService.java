package edu.fzl.LocadoraVeiculos.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import edu.fzl.LocadoraVeiculos.model.Locatario;
import edu.fzl.LocadoraVeiculos.repository.LocatarioRepository;
import java.util.List;

@Service
public class LocatarioService {

    @Autowired
    private LocatarioRepository repository;
    
    @Autowired
    private ValidacaoCPFService validaCPF;
    
    public void salvar(Locatario locatario) throws Exception {
        boolean valido = validaCPF.valido(locatario.getCpf());
        if(!valido) {
        	throw new Exception("CPF Invalido.");
        }
    	repository.save(locatario);
    }

    public List<Locatario> listarTodos() {
        return repository.findAll();
    }

    public Locatario buscarPorCpf(String cpf) throws Exception {
    	boolean valido = validaCPF.valido(cpf);
        if(!valido) {
        	throw new Exception("CPF Invalido.");
        }
        return repository.findById(cpf).orElse(null);
    }

    public void excluir(String cpf) throws Exception {
    	boolean valido = validaCPF.valido(cpf);
        if(!valido) {
        	throw new Exception("CPF Invalido.");
        }
    	repository.deleteById(cpf);
    }
}