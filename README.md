# HV_pro: High Availability with Google Cloud

High Availability (HA) and redundancy are crucial pillars in the IT world. Our latest project focuses on ensuring these aspects using Terraform on Google Cloud, providing consistent access to essential tools hosted on NGINX web servers.

## Project Overview:
- **Platform**: We utilize Google Cloud for this project. However, if you're testing or replicating it, you can also use VirtualBox locally.
- **Web Servers**: We set up two NGINX web servers in a High Availability (HA) configuration.
  - **Server 1**: Accessing this server via its IP will display "Hello World 1" on `index.html`.
  - **Server 2**: Browsing to its IP will show "Hello World 2" on `index.html`.
- **Tools**: The infrastructure setup is managed using Terraform, while configurations are handled via Ansible playbooks.
  
## Bonus Challenge:
For those looking to go the extra mile, introduce a third VM equipped with NGINX to serve as a load balancer. This setup should seamlessly toggle between Server 1 and Server 2, ensuring optimal load distribution.