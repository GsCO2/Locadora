package edu.fzl.LocadoraVeiculos.service;

import org.springframework.stereotype.Service;

@Service
public class ValidacaoCPFService {
	
	public boolean valido(String cpf) {
		if(cpf == null || cpf.length() != 11) {
			return false;
		}
		
		cpf = cpf.replaceAll("[^0-9]", "");
		
		if (cpf.matches("(\\d)\\1{10}")) {
            return false;
        }
		
		String[] cpfSplitado = cpf.split("");
		int soma = 0;
		int peso = 10;
		for(int i = 0; i < 9; i++) {
			soma +=  Integer.parseInt(cpfSplitado[i]) * peso--;
		}
		int digito1;

		if(soma % 11 < 2) {
			digito1 = 0;
		} else {
			digito1 = 11 - (soma % 11);
		}
		
		if(digito1 != Integer.parseInt(cpfSplitado[9])) {
			return false;
		}
		
		soma = 0;
		peso = 11;
		for(int i = 0; i < 10; i++) {
			soma +=  Integer.parseInt(cpfSplitado[i]) * peso--;
		}
		
		int digito2;

		if(soma % 11 < 2) {
			digito2 = 0;
		} else {
			digito2 = 11 - (soma % 11);
		}
		
		if(digito2 != Integer.parseInt(cpfSplitado[10])) {
			return false;
		}
		
		return true;
	}
}
