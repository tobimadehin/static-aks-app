# AKS Application

This project deploys a static web page with terraform to the Azure Kubernetes service.

## Deployment steps
### Pre-requisites
1. An Azure account
2. A terraform intallation   
```https://learn.hashicorp.com/tutorials/terraform/install-cli```
3. kubectl installation
```https://kubernetes.io/docs/tasks/tools/```   
4. Minikube installation    
```https://minikube.sigs.k8s.io/docs/start/```  
5. Azure CLI
```https://docs.microsoft.com/en-us/cli/azure/install-azure-cli```

### Steps
1. Clone the project to your machine    

2. Create a active directory service principal account      
```az ad sp create-for-rbac --skip-assignment```

3. Replace the files from your terraform.tfvars with the app id and password on your console       
```# terraform.tfvars```  
```appId    = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"```     
```password = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"```     

4. Initialize terraform with ```terraform init```   

5. Edit the container registry to a unique alpha-numeric value   

6. Run ```terraform validate``` to see if everything is intact   

7. Run ```terraform apply -auto-approve```      

8. Configure kubectl    
```az aks get-credentials --resource-group $(terraform output -raw resource_group_name) --name $(terraform output -raw kubernetes_cluster_name)```

9. Integrate the ACR with the AKS cluster   
```az aks update -n my-aks-cluster -g my-resource-group --attach-acr $(terraform output -raw container_registry_name)```    

10. Start minikube  ```minikube start```    

11. Deploy ```minikube start```, activate minikube as the docker daemon ```eval $(minikube docker-env)```, Change directory ```cd dockerfiles```, build docker image ```docker build . -t my-aks-app:0.0.1```, add image to minikube ```minikube image load my-aks-app:0.0.1```, run in minikube ```kubectl run hello-my-aks-app --image=my-aks-app:0.0.1 --image-pull-policy=Never```

12. Check if pods are running ```kubectl get pods```  

13. Don't forget to clean up! ```terraform destroy -auto-approve```   


### Relevant links to learn more    
1. https://learn.hashicorp.com/tutorials/terraform/aks
