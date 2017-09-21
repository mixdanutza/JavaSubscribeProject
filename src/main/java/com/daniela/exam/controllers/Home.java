package com.daniela.exam.controllers;



import static org.mockito.Matchers.anyList;

import java.security.Principal;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.function.LongFunction;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.daniela.exam.models.Package;
import com.daniela.exam.models.Subscription;
import com.daniela.exam.models.User;
import com.daniela.exam.services.PackageService;
import com.daniela.exam.services.SubscriptionService;
import com.daniela.exam.services.UserService;
import com.daniela.exam.validator.UserValidator;

@Controller
public class Home {
	private UserService userService;
	private UserValidator userValidator;
	private PackageService packageService;
	private SubscriptionService subscriptionService;
	public Home(UserService userService, UserValidator userValidator, PackageService packageService, SubscriptionService subscriptionService) {
		this.userService=userService;
		this.userValidator=userValidator;
		this.packageService=packageService;
		this.subscriptionService=subscriptionService;
	}
	
    @RequestMapping("/")
    public String home(Principal principal, Model model, RedirectAttributes redirectAttributes, @ModelAttribute("subscription") Subscription subscription) {
    	//1
    	String username=principal.getName();
    	User currentUser=userService.findByUsername(username);
    	if(currentUser!=null) {
    		model.addAttribute("currentUser", currentUser);
    		List<Package> packages=packageService.findAll();
    		model.addAttribute("packages", packages);
    		return "dashboard.jsp";	
    	}else {
    		redirectAttributes.addFlashAttribute("error", "Don't try to steal my cookies!");
    		return "redirect:/login";
    	}
    }
	
	@RequestMapping("/login")
	public String login(@Valid @ModelAttribute("user") User user, @RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, BindingResult result, HttpSession session, Model model) {
		if(error !=null) {
			model.addAttribute("error", "Invalid credeantials!");
		}
		if(logout != null) {
			model.addAttribute("logoutMessage", "Successful logout!");
		}
		return "registrationPage.jsp";
	}
	
	@PostMapping("/registration")
	public String registerForm(@Valid @ModelAttribute("user") User user, BindingResult result, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        userValidator.validate(user, result);
        if(result.hasErrors()){
        	System.out.println("ERRRRRRRRRRORRRRS");
            return "registrationPage.jsp";
        }
        //check if admin exists
        if(userService.isAdmin()==true) {
        	userService.saveWithUserRole(user);     	
        }else {
        	userService.saveUserWithAdminRole(user);
        }
        redirectAttributes.addFlashAttribute("success", "You are successfully registered, please login!");
        return "redirect:/login";
		
	}
	
	
	@GetMapping("/profile")
	public String displayProfile(Model model, Principal principal, RedirectAttributes redirectAttributes) {
		String username=principal.getName();
    	User currentUser=userService.findByUsername(username);
    	if(currentUser!=null) {
//    		if(currentUser.getSubscription()==null) {
//    			return "redirect:/";
//    		}
    		model.addAttribute("currentUser", currentUser);
    		return "profile.jsp";	
    	}else {
    		redirectAttributes.addFlashAttribute("error", "Don't try to steal my cookies!");
    		return "redirect:/login";
    	}
	}
	
	@PostMapping("/newSubscription")
	public String createSubscription(@Valid @ModelAttribute("subscription") Subscription subscription, Principal principal, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
//			if(subscription.getDue()==null ) {
//				System.out.println("?????");
//				redirectAttributes.addFlashAttribute("error", "Please choose a due date!");
//				return "redirect:/";
//			}
			
//			Date date=new Date();
//			LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
//			System.out.println(localDate);
//			int month = localDate.getMonthValue();
//			System.out.println("MONTH:"+month);
//			if(month==2) {
//				if( Integer.parseInt(subscription.getDue().toString())>28) {
//					
//				}
//			}
		
			String username=principal.getName();
	    	User currentUser=userService.findByUsername(username);
			System.out.println(subscription.getDue());
			Date date=new Date();
			Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String s = formatter.format(date);
			subscription.setDue(s);
			subscriptionService.createSubscription(subscription);
			
			currentUser.setSubscription(subscription);
			
			Package pack = subscription.getPack();
			currentUser.setP(pack);
			currentUser.setSubscription(subscription);
			userService.updateUser(currentUser);
			
//			subscriptionService.updateSubscription(subscription);
			return "redirect:/profile";
	}
	
	



}
