package com.daniela.exam.services;

import org.springframework.stereotype.Service;

import com.daniela.exam.models.Subscription;
import com.daniela.exam.repositories.SubscriptionRepository;



@Service
public class SubscriptionService {
	private SubscriptionRepository subscriptionRepository;
	
	public SubscriptionService(SubscriptionRepository subscriptionRepository) {
		this.subscriptionRepository=subscriptionRepository;
	}

	public void createSubscription(Subscription subscription) {
		subscriptionRepository.save(subscription);		
	}

	public void updateSubscription(Subscription subscription) {
		subscriptionRepository.save(subscription);		
	}

}
