package com.daniela.exam.controllers;import java.lang.ProcessBuilder.Redirect;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.daniela.exam.models.Package;
import com.daniela.exam.models.Subscription;
import com.daniela.exam.models.User;
import com.daniela.exam.services.PackageService;
import com.daniela.exam.services.SubscriptionService;
import com.daniela.exam.services.UserService;

@Controller
@RequestMapping("/admin")
public class Admin {
	PackageService packageService;
	UserService userService;
	SubscriptionService subscriptionService;
	public Admin(PackageService packageService, UserService userService, SubscriptionService subscriptionService) {
		this.packageService=packageService;
		this.userService=userService;
		this.subscriptionService=subscriptionService;
	}
	
	@GetMapping("/dashboard")
	public String admindashboard(@ModelAttribute("package") Package pack, BindingResult result, Model model) {
		//Get all users
		List<User> allUsers=userService.findAll();
		model.addAttribute("allUsers", allUsers);
		
		//Get all packages
		List<Package> allPackages=packageService.findAll();
		model.addAttribute("allPackages", allPackages);
		return "admin.jsp";
	}
	
	@PostMapping("/newPackage")
	public String createPackage(@Valid @ModelAttribute("package") Package pack, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
		if(result.hasErrors()) {
			return "admin.jsp";
		}else {
			packageService.createPackage(pack);
			redirectAttributes.addFlashAttribute("success", "You successfully created a Package!");
			return "redirect:/admin/dashboard";
		}
	}	

}
