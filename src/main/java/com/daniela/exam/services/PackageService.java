package com.daniela.exam.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.daniela.exam.models.Package;
import com.daniela.exam.repositories.PackageRepository;

@Service
public class PackageService {
	PackageRepository packageRepository;
	
	public PackageService(PackageRepository packageRepository) {
		this.packageRepository=packageRepository;
	}

	public void createPackage(Package pack) {
		packageRepository.save(pack);
	}

	public List<Package> findAll() {
		return (List<Package>) packageRepository.findAll();
	}

	public void updatePackage(Package pack) {
		packageRepository.save(pack);
		
	}
	

}
