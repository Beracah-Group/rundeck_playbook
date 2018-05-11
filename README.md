# Setup Rundeck Server/Client

- Create files/ssh_keys directory in the root directory if the playbook

  ```mkdir files/ssh_keys```
- Add private key ```id_rsa``` and and public key ```id_rsa.pub``` to ```files/ssh_keys``` directory

- Rename ```hosts.example``` to ```hosts``` and replace ```rundeck_server_host```, ```ssh_password```, ```ssh_user``` with values reflecting your own server setup. Do the same for the client entries

- To run the playbook, run

 ```ansible-playbook playbook.yml -i hosts --extra-vars "client_id=oauth_client_id" --extra-vars "client_secret=oauth_client_secret" --extra-vars "cookie_secret=cookie_secret" --extra-vars "email_domain=email_domain" --extra-vars "rundeck_host=rundeck_host"```
 
 Replace the command line varuables with values reflecting your setup
