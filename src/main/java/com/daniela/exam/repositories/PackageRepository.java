package com.daniela.exam.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.daniela.exam.models.Package;

@Repository
public interface PackageRepository extends CrudRepository<Package, Long> {

}
